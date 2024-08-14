import 'package:netease_cloud_music_app/api/api_response.dart';
import 'package:netease_cloud_music_app/api/http_utils.dart';

class LoginApi {
  Future<ApiResponse> loginWithPhone(String phone, String password) async {
    // Call the login API
    final res = await HttpUtils.get('/login/cellphone', params: {
      'phone': phone,
      'password': password,
    });

    return ApiResponse.fromJson(res, create)
  }
}
