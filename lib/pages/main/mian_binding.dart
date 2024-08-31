import 'package:get/get.dart';

import 'main_controller.dart';

class MainBinding extends Bindings {
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}