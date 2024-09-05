import 'package:netease_cloud_music_app/http/api/user/dto/user_account.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';

class UserApi {
  static Future<UserAccount> getUserAccount(int uid) async {
    final res = await HttpUtils.get("/user/detail", params: {
      "uid": uid,
    });
    return UserAccount.fromJson(res);
  }

  static Future<void> loginRefresh() async {
    await HttpUtils.get("/login/refresh");
  }
}
