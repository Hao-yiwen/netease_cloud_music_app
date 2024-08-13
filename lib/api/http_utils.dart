import 'package:dio/dio.dart';
import 'package:netease_cloud_music_app/api/http.dart';

class HttpUtils {
  static void init(
      {required String baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      List<Interceptor>? interceptors}) {
    Http().init(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        interceptors: interceptors);
  }

  static void setHeaders(Map<String, dynamic> map) {
    Http().setHeaders(map);
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    bool refresh = false,
  }) async {
    return await Http().get(
      path,
      params: params,
      options: options,
      refresh: refresh,
    );
  }

  static Future post(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await Http().post(
      path,
      data: data,
      params: params,
      options: options,
    );
  }

  static Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
    );
  }

  static Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
    );
  }
}
