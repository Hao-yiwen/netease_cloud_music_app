import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'error_interceptor.dart';

class Http {
  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static Http _instance = Http._internal();

  factory Http() => _instance;

  late Dio _dio;
  final String baseUrl = "http://127.0.0.1:3000";

  static late CookieManager cookieManager;
  static late PathProvider pathProvider;

  Http._internal() {
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
  }

  Future<void> _initializeCookieManager() async {
    pathProvider = PathProvider();
    await pathProvider.init();

    // 初始化 cookieManager
    cookieManager = CookieManager(PersistCookieJar(
        storage: FileStorage(pathProvider.getCookieSavedPath())));

    // 添加到 Dio 的拦截器中
    _dio.interceptors.add(cookieManager);
  }

  Future<void> init({
    required String baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) async {
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

  Dio get dio => _dio;

  Future<bool> checkCookie() async {
    var cookies =
        await cookieManager.cookieJar.loadForRequest(Uri.parse(baseUrl));
    return cookies.isNotEmpty;
  }

  Future<void> clearCookie() async {
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
