import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants/other.dart';
import '../../http/api/login/login_api.dart';
import '../user/user_controller.dart';

class LoginController extends GetxController{
  //上下文
  late BuildContext buildContext;


  loginCallPhone(String phone, String captcha) async {
    if (phone.isEmpty || captcha.isEmpty) {
      WidgetUtil.showToast('账号和密码为必填项，请检查');
      return;
    }
    WidgetUtil.showLoadingDialog(buildContext);
    try {
      var res = await LoginApi.loginWithPhone(
          phone: phone, captcha: captcha);
      WidgetUtil.closeLoadingDialog(buildContext);
      if (res.code != 200) {
        WidgetUtil.showToast(res.message ?? '未知错误');
        return;
      } else {
        UserController.to.getUserState();
        AutoRouter.of(buildContext).pushNamed('/home');
      }
    } catch (e) {
      WidgetUtil.closeLoadingDialog(buildContext);
      WidgetUtil.showToast('登录失败，请检查网络');
    }
  }

  sendCaptcha(String phone ) async {
    if (phone.isEmpty) {
      WidgetUtil.showToast('手机号为必填项，请检查');
      return;
    }
    WidgetUtil.showLoadingDialog(buildContext);
    try{
      var res = await LoginApi.captcha(phone);
      WidgetUtil.closeLoadingDialog(buildContext);
      if (res.code != 200) {
        WidgetUtil.showToast(res.message ?? '未知错误');
        return;
      } else {
        WidgetUtil.showToast('验证码发送成功');
      }
    }catch(e){
      WidgetUtil.closeLoadingDialog(buildContext);
      WidgetUtil.showToast('验证码发送失败，请检查网络');
    }
  }


  static LoginController get to => Get.find();
}