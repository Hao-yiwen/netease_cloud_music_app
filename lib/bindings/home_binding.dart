import 'package:get/get.dart';
import 'package:netease_cloud_music_app/api/api_service.dart';
import 'package:netease_cloud_music_app/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  final ApiService apiService;

  HomeBinding({required this.apiService});

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(apiService: apiService));
  }
}
