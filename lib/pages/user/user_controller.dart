import 'dart:convert';

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
  static UserController get to => Get.find();

  final Rx<UserAccount> userAccount = UserAccount().obs;
  final RxBool loading = false.obs;
  final Rx<Events> ownEvent = Events().obs;
  bool _isDisposed = false;

  @override
  void onInit() {
    super.onInit();
    _isDisposed = false;
  }

  @override
  void onReady() {
    super.onReady();
    if (!_isDisposed) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _initializeData());
    }
  }

  @override
  void onClose() {
    _isDisposed = true;
    loading.value = false;
    super.onClose();
  }

  void _initializeData() {
    getUserState();
    _getUserAccount();
    _getOwnEvent();
  }

  Future<void> getUserState() async {
    if (_isDisposed) return;

    try {
      final loginStatusDto = await LoginApi.loginStatus();
      if (_isDisposed) return;

      if (_isValidLoginStatus(loginStatusDto)) {
        _handleSuccessfulLogin(loginStatusDto);
      } else {
        _handleFailedLogin();
      }
    } catch (e) {
      if (!_isDisposed) {
        HomeController.to.loginStatus.value = LoginStatus.noLogin;
        LogBox.error(e);
      }
    }
  }

  bool _isValidLoginStatus(LoginStatusDto loginStatusDto) {
    return loginStatusDto.code == 200 && loginStatusDto.profile != null;
  }

  void _handleSuccessfulLogin(LoginStatusDto loginStatusDto) {
    HomeController.to.userData.value = loginStatusDto;
    HomeController.to.loginStatus.value = LoginStatus.login;
    HomeController.to.box.put(LOGIN_DATA, jsonEncode(loginStatusDto.toJson()));
  }

  void _handleFailedLogin() {
    WidgetUtil.showToast('登录失败,请重新登录');
    HomeController.to.loginStatus.value = LoginStatus.noLogin;
    logout();
  }

  Future<void> logout() async {
    try {
      await HomeController.to.box.delete(LOGIN_DATA);
      GetIt.instance<AppRouter>().replaceNamed(Routes.login);
      await LoginApi.logout();
    } catch (e) {
      LogBox.error(e);
    }
  }

  Future<void> _getUserAccount() async {
    if (_isDisposed) return;

    try {
      loading.value = true;
      final profile = HomeController.to.userData.value.profile;
      if (profile?.userId != null) {
        final account = await UserApi.getUserAccount(profile!.userId!);
        if (!_isDisposed) {
          userAccount.value = account;
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      if (!_isDisposed) {
        loading.value = false;
      }
    }
  }

  Future<void> refreshLoginStatus(BuildContext? context) async {
    if (_isDisposed) return;

    try {
      await UserApi.loginRefresh();
    } catch (e) {
      if (context != null && !_isDisposed) {
        DialogUtils.showModal(
          context,
          "登录信息已过期，请重新登录",
          () => logout(),
          () {},
        );
      }
    }
  }

  Future<void> _getOwnEvent() async {
    if (_isDisposed) return;

    try {
      loading.value = true;
      final userId = HomeController.to.userData.value.profile?.userId;
      if (userId != null) {
        final events = await TimelineApi.getUserEvent(userId);
        if (!_isDisposed) {
          ownEvent.value = events;
        }
      }
    } catch (e) {
      LogBox.error(e);
    } finally {
      if (!_isDisposed) {
        loading.value = false;
      }
    }
  }
}
