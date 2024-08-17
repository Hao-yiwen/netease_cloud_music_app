import 'package:auto_route/auto_route.dart';
import 'routes.gr.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const login = _Paths.login;
  static const main = _Paths.main;
  static const found = _Paths.found;
  static const timeline = _Paths.timeline;
  static const mine = _Paths.mine;
}

abstract class _Paths {
  _Paths._();

  static const String home = '/home';
  static const String login = '/login';
  static const String main = 'main';
  static const String found = 'found';
  static const String timeline = 'timeline';
  static const String mine = 'mine';
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: Routes.home,
          page: Home.page,
          children: [
            AutoRoute(path: Routes.main, page: Main.page, initial: true),
            AutoRoute(path: Routes.found, page: Found.page),
            AutoRoute(path: Routes.timeline, page: Timeline.page),
            AutoRoute(path: Routes.mine, page: Mine.page),
          ],
        ),
        AutoRoute(path: Routes.login, page: Login.page, initial: true),
      ];

  @override
  late final List<AutoRouteGuard> guards = [];
}
