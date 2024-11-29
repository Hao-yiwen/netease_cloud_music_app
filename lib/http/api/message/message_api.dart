import 'package:netease_cloud_music_app/http/api/message/dto/private_message.dart';

import '../../http_utils.dart';

class MessageApi {
  static Future<PrivateMessage> getPrivateMessage() async {
    final res = await HttpUtils.get("/msg/private");
    return PrivateMessage.fromJson(res);
  }
}
