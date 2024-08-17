import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netease_cloud_music_app/api/http_utils.dart';
import 'package:netease_cloud_music_app/bindings/home_binding.dart';
import 'package:netease_cloud_music_app/pages/found/found_controller.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/pages/mine/mine_controller.dart';
import 'package:netease_cloud_music_app/pages/timeline/timeline_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import 'common/constants/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // https://docs-neteasecloudmusicapi.vercel.app/docs/#/?id=_1-%e6%89%8b%e6%9c%ba%e7%99%bb%e5%bd%95
  // 全局dio封装
  await HttpUtils.init(baseUrl: 'http://127.0.0.1:3000');
  // 初始化权限校验 del 在这里初始化是否有必要
  // Get.put(AuthController());
  // 全局依赖共享
  final getIt = GetIt.instance;
  await _initGetService(getIt);
  final _appRouter = AppRouter();

  runApp(ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? child) {
      HomeBinding().dependencies();
      return GetMaterialApp.router(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [MyObserver()],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
      );
    },
  ));
}

class MyObserver extends AutoRouterObserver {
  _clearOrPutController(name, {bool del = false}) {
    if (name.isEmpty) return;
    switch (name) {
      case 'Mine':
        del
            ? Get.delete<MineController>()
            : Get.lazyPut(() => MineController());
        break;
      case 'Main':
        del
            ? Get.delete<MainController>()
            : Get.lazyPut(() => MainController());
        break;
      case 'Found':
        del
            ? Get.delete<FoundController>()
            : Get.lazyPut(() => FoundController());
        break;
      case 'Timeline':
        del
            ? Get.delete<TimelineController>()
            : Get.lazyPut(() => TimelineController());
        break;
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('New route pushed: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    print('Route popped: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    print('Route removed: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('Tab route re-visited: ${route.name}');
  }
}

Future<void> _initGetService(GetIt getIt) async {
  await Hive.initFlutter('music');
  getIt.registerSingleton<Box>(await Hive.openBox('cache'));
}
