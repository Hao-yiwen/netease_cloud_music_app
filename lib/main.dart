import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netease_cloud_music_app/api/http_utils.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import 'common/constants/colors.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // https://docs-neteasecloudmusicapi.vercel.app/docs/#/?id=_1-%e6%89%8b%e6%9c%ba%e7%99%bb%e5%bd%95
  // 本地服务
  await HttpUtils.init(baseUrl: 'http://127.0.0.1:3000');
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
