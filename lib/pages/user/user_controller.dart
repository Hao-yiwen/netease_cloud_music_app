import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/common/utils/dialog_utils.dart';
import 'package:netease_cloud_music_app/http/api/login/dto/login_status_dto.dart';
import 'package:netease_cloud_music_app/http/api/login/login_api.dart';
import 'package:netease_cloud_music_app/http/api/user/dto/user_account.dart';
import 'package:netease_cloud_music_app/http/api/user/user_api.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';

enum LoginStatus { login, noLogin }

class UserController extends GetxController {
  Rx<UserAccount> userAccount = UserAccount().obs;
  RxBool loding = false.obs;

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
    });
  }

  Future<void> getUserState() async {
    try {
      LoginStatusDto loginStatusDto = await LoginApi.loginStatus();
      if (loginStatusDto.code == 200 && loginStatusDto.profile != null) {
        HomeController.to.userData.value = loginStatusDto;
        HomeController.to.loginStatus.value = LoginStatus.login;
        HomeController.to.box
            .put(loginData, jsonEncode(loginStatusDto.toJson()));
      } else {
        WidgetUtil.showToast('登录失败,请重新登录');
        HomeController.to.loginStatus.value = LoginStatus.noLogin;
      }
    } catch (e) {
      HomeController.to.loginStatus.value = LoginStatus.noLogin;
      print(e);
    }
  }

  Future<void> logout() async {
    HomeController.to.box.delete(loginData);
  }

  static UserController get to => Get.find();

  Future<void> _getUserAccount() async {
    try {
      loding.value = true;
      userAccount.value = await UserApi.getUserAccount(
          HomeController.to.userData.value.profile!.userId);
    } catch (e) {
      print(e);
    } finally {
      loding.value = false;
    }
  }

  Future<void> refreshLoginStatus() async {
    try {
      await UserApi.loginRefresh();
    } catch (e) {
      // 弹出弹窗提示用户登录信息已过期需要重新登录
      await DialogUtils.showModal(
          GetIt.instance<BuildContext>(), "当前用户信息已过期，请重新登录", () {}, () {});
    }
  }
}
