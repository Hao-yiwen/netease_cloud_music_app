import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/service/theme_service.dart';

class ThemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeService>(() => ThemeService());
  }
}