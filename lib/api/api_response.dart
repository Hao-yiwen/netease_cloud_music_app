class ApiResponse<T> {
  final int code;
  final bool? more;
  final T? data;
  final String? message;

  ApiResponse({required this.code, this.more, this.data, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) create) {
    return ApiResponse(
      code: json['code'],
      more: json['more'] ?? false,
      data: json.containsKey('data') ? create(json['data']) : null,
      message: json['message'],
    );
  }

  // 方便创建没有data的响应
  factory ApiResponse.withoutData(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      more: json['more'] ?? false,
      data: null,
      message: json['message'],
    );
  }
}
