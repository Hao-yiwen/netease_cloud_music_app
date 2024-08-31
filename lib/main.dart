import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netease_cloud_music_app/common/service/theme_binding.dart';
import 'package:netease_cloud_music_app/common/service/theme_service.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';
import 'package:netease_cloud_music_app/pages/found/found_controller.dart';
import 'package:netease_cloud_music_app/pages/home/home_binding.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/pages/splash/splash_controller.dart';
import 'package:netease_cloud_music_app/pages/timeline/timeline_controller.dart';
import 'package:netease_cloud_music_app/pages/user/user_binding.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import 'common/constants/colors.dart';
import 'common/constants/url.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // https://docs-neteasecloudmusicapi.vercel.app/docs/#/?id=_1-%e6%89%8b%e6%9c%ba%e7%99%bb%e5%bd%95
  // 全局dio封装
  await HttpUtils.init(baseUrl: BASE_URL);
  // 初始化权限校验 del 在这里初始化是否有必要
  // Get.put(AuthController());
  // 全局依赖共享
  final getIt = GetIt.instance;
  await _initGetService(getIt);
  final _appRouter = getIt<AppRouter>();

  runApp(ScreenUtilInit(
    // 750想当与iphone6/7/8 plus的设计尺寸 375相当于iphone6/7/8的设计尺寸
    // flutter中的逻辑像素 / 375 约等于 1
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? child) {
      ThemeBinding().dependencies();
      print("获取屏幕宽高 ${ScreenUtil().screenWidth} ${ScreenUtil().screenHeight}");
      return Obx(() {
        return GetMaterialApp.router(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeService.to.currentThemeMode,
          routerDelegate: _appRouter.delegate(
            navigatorObservers: () => [MyObserver()],
          ),
          initialBinding: BindingsBuilder((){
            HomeBinding().dependencies();
            UserBinding().dependencies();
          }),
          routeInformationParser: _appRouter.defaultRouteParser(),
        );
      });
    },
  ));
}

class MyObserver extends AutoRouterObserver {
  _clearOrPutController(name, {bool del = false}) {
    if (name.isEmpty) return;
    switch (name) {
      case 'User':
        del
            ? Get.delete<UserController>()
            : Get.lazyPut(() => UserController());
        break;
      case 'SplashRoute':
        del
            ? Get.delete<SplashController>()
            : Get.lazyPut(() => SplashController());
        break;
      case 'Search':
        del
            ? Get.delete<SearchController>()
            : Get.lazyPut(() => SearchController());
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
  getIt.registerSingleton<AppRouter>(AppRouter());
  await Hive.initFlutter('music');
  getIt.registerSingleton<Box>(await Hive.openBox('cache'));
}
