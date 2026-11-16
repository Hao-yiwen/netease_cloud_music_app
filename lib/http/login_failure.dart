import 'package:dio/dio.dart';

/// 把登录请求的失败说成人话。
///
/// 网易云现在会用 HTTP 400 返回业务码，例如 8821（行为验证码）和 -462（人机验证）。
/// 这些不是设备没网。社区目前能稳定走通的是扫码，短信和密码在公网接口上经常被拦。
String describeLoginFailure(Object error) {
  if (error is DioException) {
    final fromBody = _messageFromBody(error.response?.data);
    if (fromBody != null) return fromBody;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return '连不上接口。请检查网络，或修改接口地址。';
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        if (status == 404) return '接口地址不对，没有这个路径。';
        return '接口返回了错误。请修改接口地址，或改用扫码登录。';
      case DioExceptionType.badCertificate:
        return '接口证书校验失败。';
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        break;
    }
  }
  return '登录失败。请检查接口地址，或改用扫码登录。';
}

/// 接口已经返回 JSON 时使用。没有可展示的内容时返回 null。
String? describeApiLogin({int? code, String? message}) {
  final text = (message ?? '').trim();
  if (code == 8821 ||
      _containsAny(text, ['行为验证码', '登录存在风险', '环境异常'])) {
    return '网易云拦截了短信和密码登录。请改用扫码；公网接口经常被拦，可以换成自己部署的 NeteaseCloudMusicApiEnhanced。';
  }
  if (code == -462 || _containsAny(text, ['人机验证', '验证成功后'])) {
    return '接口触发了人机验证。扫码更稳，或把接口地址改成自己的服务器。';
  }
  if (text.isNotEmpty && code != null && code != 200) return text;
  if (text.isNotEmpty && code == null) return text;
  return null;
}

String? _messageFromBody(dynamic data) {
  if (data is! Map) return null;
  final code = _asInt(data['code']);
  final message = data['message'] ?? data['msg'];
  return describeApiLogin(
    code: code,
    message: message is String ? message : null,
  );
}

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

bool _containsAny(String text, List<String> parts) {
  for (final part in parts) {
    if (text.contains(part)) return true;
  }
  return false;
}
