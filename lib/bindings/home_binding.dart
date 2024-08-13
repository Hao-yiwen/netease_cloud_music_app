import 'package:get/get.dart';
import 'package:netease_cloud_music_app/controllers/home_controller.dart';

class HomeBinding extends Bindings {

  HomeBinding();

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
