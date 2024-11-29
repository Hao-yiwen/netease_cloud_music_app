import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:netease_cloud_music_app/common/music_handler.dart';
import 'package:netease_cloud_music_app/common/service/theme_binding.dart';
import 'package:netease_cloud_music_app/common/service/theme_service.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';
import 'package:netease_cloud_music_app/pages/home/home_binding.dart';
import 'package:netease_cloud_music_app/pages/login/login_controller.dart';
import 'package:netease_cloud_music_app/pages/message/message_binding.dart';
import 'package:netease_cloud_music_app/pages/mv_player/mv_player_controller.dart';
import 'package:netease_cloud_music_app/pages/splash/splash_controller.dart';
import 'package:netease_cloud_music_app/pages/user/user_binding.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';
import 'package:netease_cloud_music_app/routes/routes.gr.dart';
import 'package:netease_cloud_music_app/common/constants/colors.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';

Future<void> main() async {
  await _initializeApp();
  final appRouter = GetIt.instance<AppRouter>();

  runApp(_buildApp(appRouter));
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpUtils.init(baseUrl: BASE_URL);
  await _initGetService(GetIt.instance);
}

Widget _buildApp(AppRouter appRouter) {
  return ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => _buildMaterialApp(context, appRouter),
  );
}

Widget _buildMaterialApp(BuildContext context, AppRouter appRouter) {
  ThemeBinding().dependencies();
  LogBox.debug(
      'Screen size: ${ScreenUtil().screenWidth}x${ScreenUtil().screenHeight}');

  return Obx(() => GetMaterialApp.router(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeService.to.currentThemeMode,
        routerDelegate: appRouter.delegate(
          navigatorObservers: () => [MyObserver()],
        ),
        initialBinding: _initializeBindings(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ));
}

Bindings _initializeBindings() {
  return BindingsBuilder(() {
    HomeBinding().dependencies();
    UserBinding().dependencies();
    MessageBinding().dependencies();
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => MvPlayerController());
  });
}

class MyObserver extends AutoRouterObserver {
  final Map<String, dynamic Function()> _controllerFactories = {
    Login.name: () => LoginController(),
    User.name: () => UserController(),
    SplashRoute.name: () => SplashController(),
    MvPlayer.name: () => MvPlayerController(),
  };

  void _clearOrPutController(String name, {bool del = false}) {
    if (name.isEmpty || !_controllerFactories.containsKey(name)) return;

    if (del) {
      // 在删除控制器之前先检查是否存在
      if (Get.isRegistered(tag: name)) {
        Get.delete(tag: name);
      }
    } else {
      // 在创建控制器之前先检查是否已存在
      if (!Get.isRegistered(tag: name)) {
        Get.lazyPut(_controllerFactories[name]!, tag: name, fenix: true);
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    LogBox.info('Route pushed: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    LogBox.info('Route popped: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    LogBox.info('Route removed: ${route.settings.name}');
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    LogBox.info('Tab route initialized: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    LogBox.info('Tab route changed: ${route.name}');
  }
}

Future<void> _initGetService(GetIt getIt) async {
  getIt
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AudioPlayer>(AudioPlayer());

  await Hive.initFlutter('music');
  getIt.registerSingleton<Box>(await Hive.openBox('cache'));

  final musicHandler = await AudioService.init<MusicHandler>(
    builder: () => MusicHandler(),
    config: const AudioServiceConfig(),
  );
  getIt.registerSingleton<MusicHandler>(musicHandler);
}
