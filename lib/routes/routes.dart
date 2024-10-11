import 'package:auto_route/auto_route.dart';
import 'package:netease_cloud_music_app/routes/auth_guard.dart';
import 'routes.gr.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const login = _Paths.login;
  static const main = _Paths.main;
  static const found = _Paths.found;
  static const timeline = _Paths.timeline;
  static const user = _Paths.user;
  static const roaming = _Paths.roaming;
  static const splash = _Paths.splash;
  static const search = _Paths.search;
  static const newSongs = _Paths.newSongs;
  static const empty = _Paths.empty;
  static const about = _Paths.about;
  static const webview = _Paths.webview;
  static const songsList = _Paths.songsList;
  static const other = _Paths.other;
  static const comment = _Paths.comment;
  static const message = _Paths.message;
  static const mvPlayer = _Paths.mvPlayer;
}

abstract class _Paths {
  _Paths._();

  static const String home = '/home';
  static const String login = '/login';
  static const String main = 'main';
  static const String found = 'found';
  static const String timeline = 'timeline';
  static const String user = 'user';
  static const String roaming = 'roaming';
  static const String splash = '/splash';
  static const String search = '/search';
  static const String newSongs = 'newSongs';
  static const String empty = 'empty';
  static const String about = '/about';
  static const String webview = '/webview';
  static const String songsList = '/songsList';
  static const String other = '*';
  static const String comment = '/comment';
  static const String message = '/message';
  static const String mvPlayer = '/mvPlayer';
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
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
            AutoRoute(path: Routes.empty, page: EmptyRoute.page),
            AutoRoute(path: Routes.timeline, page: Timeline.page),
            AutoRoute(path: Routes.user, page: User.page),
            AutoRoute(path: Routes.newSongs, page: NewsSongs.page),
          ],
        ),
        AutoRoute(path: Routes.search, page: Search.page),
        AutoRoute(page: MessageRoute.page, path: Routes.message),
        AutoRoute(path: Routes.login, page: Login.page, guards: [AuthGuard()]),
        AutoRoute(path: Routes.splash, page: SplashRoute.page, initial: true),
        CustomRoute(
            page: About.page,
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            durationInMilliseconds: 200,
            path: Routes.about),
        CustomRoute(
            page: WebViewRoute.page,
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            durationInMilliseconds: 200,
            path: Routes.webview),
        AutoRoute(path: Routes.songsList, page: SongsList.page),
        AutoRoute(path: Routes.comment, page: CommentRoute.page),
        AutoRoute(path: Routes.mvPlayer, page: MvPlayer.page),
        AutoRoute(path: Routes.other, page: ErrorRoute.page),
      ];

  @override
  late final List<AutoRouteGuard> guards = [];
}

enum TAB_ENUM {
  main(0),
  found(1),
  roaming(2),
  timeline(3),
  user(4);

  final int value;

  const TAB_ENUM(this.value);

  static TAB_ENUM fromValue(int value) {
    switch (value) {
      case 0:
        return main;
      case 1:
        return found;
      case 2:
        return roaming;
      case 3:
        return timeline;
      case 4:
        return user;
      default:
        return main;
    }
  }
}
