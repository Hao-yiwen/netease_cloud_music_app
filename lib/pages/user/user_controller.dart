import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/keys.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/http/api/login/dto/login_status_dto.dart';
import 'package:netease_cloud_music_app/http/api/login/login_api.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';

enum LoginStatus { login, noLogin }

class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  static UserController get to => Get.find();

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserState();
    });
  }

  Future<void> getUserState() async {
    try{
      LoginStatusDto loginStatusDto = await LoginApi.loginStatus();
      if (loginStatusDto.code == 200 && loginStatusDto.profile != null) {
        HomeController.to.userData.value = loginStatusDto;
        HomeController.to.loginStatus.value = LoginStatus.login;
        HomeController.to.box.put(loginData, jsonEncode(loginStatusDto.toJson()));
      } else {
        WidgetUtil.showToast('登录失败,请重新登录');
        HomeController.to.loginStatus.value = LoginStatus.noLogin;
      }
    }catch(e){
      HomeController.to.loginStatus.value = LoginStatus.noLogin;
      print(e);
    }
  }
}
