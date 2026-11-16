import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:netease_cloud_music_app/common/base_url.dart';
import 'package:netease_cloud_music_app/http/login_failure.dart';

void main() {
  test('risk-control responses are not described as a dead network', () {
    expect(
      describeLoginFailure(_dioError(400, {
        'code': 8821,
        'message': '需要行为验证码验证',
      })),
      contains('扫码'),
    );
    expect(
      describeApiLogin(code: -462, message: '人机验证'),
      contains('自己的服务器'),
    );
    expect(
      describeApiLogin(code: 400, message: '验证码错误'),
      '验证码错误',
    );
  });

  test('connection failures point at the API address', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/captcha/sent'),
      type: DioExceptionType.connectionError,
    );
    expect(describeLoginFailure(error), contains('接口地址'));
  });

  test('base url gains a scheme and a trailing slash', () {
    expect(normalizeBaseUrl('192.168.1.8:3000'), 'http://192.168.1.8:3000/');
    expect(
      normalizeBaseUrl('https://example.com/api'),
      'https://example.com/api/',
    );
    expect(
      () => normalizeBaseUrl('ftp://example.com'),
      throwsFormatException,
    );
  });
}

DioException _dioError(int status, Map<String, dynamic> body) {
  final options = RequestOptions(path: '/login/cellphone');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: status,
      data: body,
    ),
  );
}
