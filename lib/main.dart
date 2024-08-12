import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import 'common/constants/colors.dart';
import 'controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());

  runApp(ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? child) {
      return GetMaterialApp.router(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        // showPerformanceOverlay: true,
        // checkerboardOffscreenLayers: true,
        // checkerboardRasterCacheImages: true,
        themeMode: ThemeMode.system,
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
      );
    },
  ));
}