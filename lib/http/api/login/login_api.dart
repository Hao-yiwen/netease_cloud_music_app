import 'package:dio/dio.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/http.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';
import 'package:netease_cloud_music_app/http/api/login/dto/login_status_dto.dart';

class LoginApi {
  static Future<LoginStatusDto> loginWithPhone(
      {required String phone,
      String? password = '',
      String? captcha = ''}) async {
    String? countryCode;
    if (phone.startsWith('+')) {
      // Split with space
      final parts = phone.split(' ');
      if (parts.length == 2) {
        countryCode = parts[0].substring(1); // Remove the +
        phone = parts[1];
      }
    }
    final params = {
      'phone': phone,
      if (captcha?.isNotEmpty == true)
        'captcha': captcha
      else
        'password': password,
      if (countryCode != null) 'countrycode': countryCode,
    };
    final res = await HttpUtils.get('/login/cellphone', params: params);
    var info = LoginStatusDto.fromJson(res);
    Http().usc.onLogined(info);

    return info;
  }

  static Future<ServerStatusBean> captcha(String phone) async {
    String? countryCode;
    if (phone.startsWith('+')) {
      // Split with space
      final parts = phone.split(' ');
      if (parts.length == 2) {
        countryCode = parts[0].substring(1); // Remove the +
        phone = parts[1];
      }
    }
    final params = {
      'phone': phone,
      if (countryCode != null) 'ctcode': countryCode,
    };
    final res = await HttpUtils.get('/captcha/sent', params: params);
    return ServerStatusBean.fromJson(res);
  }

  static Future<LoginStatusDto> loginStatus() async {
    final res = await HttpUtils.get('/login/status');
    var info = LoginStatusDto.fromJson(res['data']);
    Http().usc.onLogined(info);
    return info;
  }

  static Future<void> logout() async {
    await HttpUtils.get('/logout');
    Http().usc.onLogout();
  }
}
