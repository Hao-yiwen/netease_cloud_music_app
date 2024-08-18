import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../routes/routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Box box = GetIt.instance<Box>();
  var isFirst = true.obs;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    isFirst.value = box.get('isFirst', defaultValue: true);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await Future.delayed(Duration(milliseconds: isFirst.value ? 6000 : 2000));
    toHome();
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void toHome() {
    box.put('isFirst', false);
    GetIt.instance<AppRouter>().replaceNamed('/login');
  }
}
