import 'package:netease_cloud_music_app/api/api_response.dart';
import 'package:netease_cloud_music_app/api/http_utils.dart';
import 'package:netease_cloud_music_app/api/src/dto/login_status_dto.dart';

class LoginApi {
  static Future<ApiResponse> loginWithPhone(
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

    return ApiResponse.withoutData(res);
  }

  static Future<ApiResponse> captcha(String phone) async {
    final res = await HttpUtils.get('/captcha/sent', params: {
      'phone': phone,
    });
    return ApiResponse.withoutData(res);
  }

  static Future<ApiResponse<LoginStatusDto>> loginStatus() async {
    final res = await HttpUtils.get('/login/status');
    return ApiResponse.fromJson(res, (data) => LoginStatusDto.fromJson(data));
  }
}
