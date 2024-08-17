import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}