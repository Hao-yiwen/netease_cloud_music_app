import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'error_interceptor.dart';
import 'api/login/dto/login_status_dto.dart';

class Http {
  ///超时时间
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  static Http? _instance;

  factory Http(){
    return _instance ??= Http._internal();
  }

  static late Dio _dio;
  static final String baseUrl = "http://127.0.0.1:3000";

  static late CookieManager cookieManager;
  static late PathProvider pathProvider;

  UserLoginStateController usc = UserLoginStateController();

  Http._internal() {
    // 初始化userController
    usc.init();
  }

  static Future<void> _initializeCookieManager() async {
    pathProvider = PathProvider();
    await pathProvider.init();

    // 初始化 cookieManager
    cookieManager = CookieManager(PersistCookieJar(
        storage: FileStorage(pathProvider.getCookieSavedPath())));

    // 添加到 Dio 的拦截器中
    _dio.interceptors.add(cookieManager);
  }

  static Future<void> init({
    required String baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) async {
    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: CONNECT_TIMEOUT),
        receiveTimeout: Duration(milliseconds: RECEIVE_TIMEOUT)));

    // 日志美化
    if (bool.fromEnvironment('DEBUG')) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
          logPrint: (object) {
            if (object is String) {
              print(object.replaceAll('║', ''));
            }
          }));
    }

    // 错误处理
    _dio.interceptors.add(ErrorInterceptor());

    // 请求缓存
    final cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      allowPostMethod: false,
    );
    _dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    await _initializeCookieManager(); // Initialize CookieManager

    _dio.options = dio.options.copyWith(
        baseUrl: baseUrl,
        connectTimeout:
            Duration(milliseconds: connectTimeout ?? CONNECT_TIMEOUT),
        receiveTimeout:
            Duration(milliseconds: receiveTimeout ?? RECEIVE_TIMEOUT),
        contentType: 'application/json; charset=utf-8',
        headers: {});
    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  void setHeaders(Map<String, dynamic> map) {
    _dio.options.headers.addAll(map);
  }

  static Dio get dio => _dio;

  static Future<bool> checkCookie() async {
    var cookies =
        await cookieManager.cookieJar.loadForRequest(Uri.parse(baseUrl));
    return cookies.isNotEmpty;
  }

  static Future<List<Cookie>> loadCookies({Uri? host}) async {
    return await cookieManager.cookieJar
        .loadForRequest(host ?? Uri.parse(baseUrl));
  }

  static Future<void> clearCookie() async {
    await cookieManager.cookieJar.deleteAll();
  }

  /// restful get 操作
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    bool refresh = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      "refresh": refresh,
    });
    Response response;
    response = await _dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
    );
    return response.data;
  }
}

class UserLoginStateController {
  LoginState? _curLoginState;

  StreamController? _controller;

  UserLoginStateController();

  Future<void> init() async {
    _checkCreateSavePath();
    await _readAccountInfo();
    _refreshLoginStatus(
        (await HttpUtils.loadCookies()).isNotEmpty && _accountInfo != null
            ? LoginState.Logined
            : LoginState.Logout);
  }

  bool get isLogined {
    return _curLoginState == LoginState.Logined;
  }

  StreamSubscription listenLoginState(
      void Function(LoginState event, LoginStatusDto? accountInfoWrap)
          onChange) {
    var controller = _controller;
    if (controller == null) {
      _controller = controller = StreamController.broadcast(sync: true);
    }
    return controller.stream.listen((t) {
      onChange(t, accountInfo);
    });
  }

  _checkCreateSavePath() {
    var file = _saveFile();
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
  }

  File _saveFile() {
    return File(Http.pathProvider.getDataSavedPath() + "_accountInfo.json");
  }

  void onLogined(LoginStatusDto info) {
    _accountInfo = info;
    _refreshLoginStatus(LoginState.Logined);
    _saveAccountInfo(info);
  }

  LoginStatusDto? _accountInfo;

  LoginStatusDto? get accountInfo => _accountInfo;

  Future<void> _readAccountInfo() async {
    try {
      String accountInfo = _saveFile().readAsStringSync();
      _accountInfo = LoginStatusDto.fromJson(jsonDecode(accountInfo));
    } catch (e) {
      LogBox.error(e.toString());
      await onLogout();
    }
  }

  onLogout() async {
    await HttpUtils.clearCookie();
    _accountInfo = null;
    _saveAccountInfo(null);
    _refreshLoginStatus(LoginState.Logout);
  }

  void _saveAccountInfo(LoginStatusDto? loginStatus) {
    _saveFile().writeAsStringSync(jsonEncode(loginStatus?.toJson()), flush: true);
  }

  void _refreshLoginStatus(LoginState logout) {
    var controller = _controller;
    if (controller != null && _curLoginState != logout) {
      controller.add(logout);
    }
    _curLoginState = logout;
  }

  void destory() {
    _controller?.close();
  }
}

enum LoginState {
  Logined,
  Logout,
}

class PathProvider {
  var _cookiePath = '';
  var _dataPath = '';

  init() async {
    _cookiePath =
        "${(await getApplicationSupportDirectory()).absolute.path}/music/.cookies/";
    _dataPath =
        "${(await getApplicationSupportDirectory()).absolute.path}/music/.data/";
  }

  String getCookieSavedPath() {
    return _cookiePath;
  }

  String getDataSavedPath() {
    return _dataPath;
  }
}
