import 'package:netease_cloud_music_app/api/app_exception.dart';

class ApiResponse<T> implements Exception {
  Status status;
  AppException? exception;
  T? data;

  // 完成的构造函数
  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  // 其他可能的构造函数
  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.error(this.exception) : status = Status.ERROR;

  // 便利方法
  bool get isSuccess => status == Status.COMPLETED;
}

enum Status {
  COMPLETED,
  LOADING,
  ERROR,
}
