import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

class RoamingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RoamingController());
  }
}