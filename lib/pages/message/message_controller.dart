import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/message/dto/private_message.dart';

import '../../http/api/message/message_api.dart';

class MessageController extends GetxController {
  RxBool loading = false.obs;
  Rx<PrivateMessage> privateMessage = PrivateMessage().obs;

  @override
  void onInit() {
    super.onInit();
    _getPrivateMessage();
  }

  Future<void> _getPrivateMessage() async {
    try {
      loading.value = true;
      var res = await MessageApi.getPrivateMessage();
      if (res.code == 200) {
        privateMessage.value = res;
      } else {
        LogBox.error("获取私信失败");
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }
}
