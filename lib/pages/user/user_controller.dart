import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/common/utils/dialog_utils.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/http/api/login/dto/login_status_dto.dart';
import 'package:netease_cloud_music_app/http/api/login/login_api.dart';
import 'package:netease_cloud_music_app/http/api/timeline/dto/events.dart';
import 'package:netease_cloud_music_app/http/api/user/dto/user_account.dart';
import 'package:netease_cloud_music_app/http/api/user/user_api.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';

import '../../http/api/timeline/timeline_api.dart';
import '../../routes/routes.dart';

enum LoginStatus { login, noLogin }

class UserController extends GetxController {
  Rx<UserAccount> userAccount = UserAccount().obs;
  RxBool loding = false.obs;
  Rx<Events> ownEvent = Events().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserState();
      _getUserAccount();
      _getOwnEvent();
    });
  }

  Future<void> getUserState() async {
    try {
      LoginStatusDto loginStatusDto = await LoginApi.loginStatus();
      if (loginStatusDto.code == 200 && loginStatusDto.profile != null) {
        HomeController.to.userData.value = loginStatusDto;
        HomeController.to.loginStatus.value = LoginStatus.login;
        HomeController.to.box
            .put(LOGIN_DATA, jsonEncode(loginStatusDto.toJson()));
      } else {
        WidgetUtil.showToast('登录失败,请重新登录');
        HomeController.to.loginStatus.value = LoginStatus.noLogin;
        logout();
      }
    } catch (e) {
      HomeController.to.loginStatus.value = LoginStatus.noLogin;
      LogBox.error(e);
    }
  }

  Future<void> logout() async {
    try {
      HomeController.to.box.delete(LOGIN_DATA);
      GetIt.instance<AppRouter>().replaceNamed(Routes.login);
      await LoginApi.logout();
    } catch (e) {
      LogBox.error(e);
    }
  }

  static UserController get to => Get.find();

  Future<void> _getUserAccount() async {
    try {
      loding.value = true;
      if (HomeController.to.userData.value.profile != null) {
        userAccount.value = await UserApi.getUserAccount(
            HomeController.to.userData.value.profile!.userId!);
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loding.value = false;
    }
  }

  Future<void> refreshLoginStatus(BuildContext? context) async {
    try {
      await UserApi.loginRefresh();
    } catch (e) {
      if (context != null) {
        DialogUtils.showModal(context, "登录信息已过期，请重新登录", () {
          logout();
        }, () {});
      }
    }
  }

  Future<void> _getOwnEvent() async {
    try {
      loding.value = true;
      if (HomeController.to.userData.value.profile?.userId != null) {
        final Events events = await TimelineApi.getUserEvent(
            HomeController.to.userData.value.profile?.userId);
        ownEvent.value = events;
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      loding.value = false;
    }
  }
}
