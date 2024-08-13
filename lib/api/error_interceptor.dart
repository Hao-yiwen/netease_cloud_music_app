import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/api/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppException appException = AppException.create(err);
    debugPrint("error: ${appException.toString()}");
    DioException tmpErr = err.copyWith(error: appException);
    super.onError(tmpErr, handler);
  }
}
