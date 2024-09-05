import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';

import '../../http/api/login/dto/login_status_dto.dart';

class HomeController extends SuperController {
  Box box = GetIt.instance<Box>();
  // todo 迁移到user模块
  Rx<LoginStatusDto> userData = LoginStatusDto().obs;
  Rx<LoginStatus> loginStatus = LoginStatus.noLogin.obs;
  Rx<GlobalKey<ScaffoldState>> scaffoldKey = GlobalKey<ScaffoldState>().obs;
  Rx<TabsRouter?> tabsRouter = Rx<TabsRouter?>(null);

  initUserData() {
    String userDataStr = box.get(loginData) ?? '';
    if (userDataStr.isNotEmpty) {
      loginStatus.value = LoginStatus.login;
      userData.value = LoginStatusDto.fromJson(jsonDecode(userDataStr));
      // 刷新用户信息 todo
    } else {
      loginStatus.value = LoginStatus.noLogin;
      userData.value = LoginStatusDto();
    }
  }

  setScaffoldKey(GlobalKey<ScaffoldState> key) {
    scaffoldKey.value = key;
  }

  void setTabsRouter(TabsRouter router) {
    tabsRouter.value = router;
  }

  void switchTab(int index) {
    tabsRouter.value?.setActiveIndex(index);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      initUserData();
    });
    super.onReady();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  static HomeController get to => Get.find();
}
