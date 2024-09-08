import 'dart:io';

import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/banner.dart';

import '../../http/api/found/found_api.dart';

class FoundController extends GetxController {
  // loading
  RxBool loading = false.obs;

  // banner
  Rx<Banner> banner = Banner().obs;

  @override
  void onInit() {
    super.onInit();
    _getBanner();
  }

  _getBanner() async {
    try {
      loading.value = true;
      if (Platform.isIOS) {
        banner.value = await FoundApi.getBanner(BannerType.IPHONE.value);
      } else {
        banner.value = await FoundApi.getBanner(BannerType.ANDROID.value);
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loading.value = false;
    }
  }

  static FoundController get to => Get.find<FoundController>();
}
