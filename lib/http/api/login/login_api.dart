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
    final params = {
      'phone': phone,
      if (captcha?.isNotEmpty == true)
        'captcha': captcha
      else
        'password': password,
    };
    final res = await HttpUtils.get('/login/cellphone', params: params);
    var info = LoginStatusDto.fromJson(res);
    Http().usc.onLogined(info);

    return info;
  }

  static Future<ServerStatusBean> captcha(String phone) async {
    final res = await HttpUtils.get('/captcha/sent', params: {
      'phone': phone,
    });
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
