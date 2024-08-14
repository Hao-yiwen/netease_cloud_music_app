import 'package:get/get.dart';
import 'package:netease_cloud_music_app/api/http_utils.dart';

import '../api/src/login_api.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  Future<void> statusCheck() async {
    final cookieExt = await HttpUtils.checkCookie();
    if (cookieExt) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }
}
