import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService with WidgetsBindingObserver {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    syncWithSystem();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    syncWithSystem();
  }

  void switchThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }

  void syncWithSystem() {
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    themeMode.value =
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeMode get currentThemeMode => themeMode.value;

  static ThemeService get to => Get.find();
}
