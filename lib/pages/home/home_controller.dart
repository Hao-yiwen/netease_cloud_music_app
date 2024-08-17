import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';

import '../../http/api/login/dto/login_status_dto.dart';

class HomeController extends SuperController {
  static HomeController get to => Get.find();

  Box box = GetIt.instance<Box>();

  Rx<LoginStatusDto> userData = LoginStatusDto().obs;
  Rx<LoginStatus> loginStatus = LoginStatus.noLogin.obs;

  initUserData() {
    String userDataStr = box.get(loginData) ?? '';
    if (userDataStr.isNotEmpty) {
      loginStatus.value = LoginStatus.login;
      userData.value = LoginStatusDto.fromJson(jsonDecode(userDataStr));
    }
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
}
