import 'package:auto_route/auto_route.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';

import '../pages/user/user_controller.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    await HomeController.to.initUserData();
    final loginStatus = HomeController.to.loginStatus;

    if (loginStatus.value == LoginStatus.login) {
      router.replaceNamed('/home');
      UserController.to.refreshLoginStatus(router.navigatorKey.currentContext);
    } else {
      resolver.next(true);
    }
  }
}
