import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants/other.dart';
import '../../common/utils/log_box.dart';
import '../../http/api/login/login_api.dart';
import '../user/user_controller.dart';

class LoginController extends GetxController{
  //上下文
  late BuildContext buildContext;

  bool get _canUseContext => !isClosed && buildContext.mounted;

  void _closeLoading() {
    if (_canUseContext) {
      WidgetUtil.closeLoadingDialog(buildContext);
    }
  }

  Future<void> loginCallPhone(String phone, String captcha) async {
    if (phone.isEmpty || captcha.isEmpty) {
      WidgetUtil.showToast('账号和密码为必填项，请检查');
      return;
    }
    if (!_canUseContext) return;
    WidgetUtil.showLoadingDialog(buildContext);
    try {
      final res =
          await LoginApi.loginWithPhone(phone: phone, captcha: captcha);
      _closeLoading();
      if (res.code != 200) {
        WidgetUtil.showToast(res.message ?? '未知错误');
        return;
      }
      UserController.to.getUserState();
      if (_canUseContext) {
        AutoRouter.of(buildContext).pushPath('/home');
      }
    } catch (e) {
      LogBox.error(e, msg: '手机号登录失败');
      _closeLoading();
      WidgetUtil.showToast('登录失败，请检查网络');
    }
  }

  Future<void> loginEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      WidgetUtil.showToast('账号和密码为必填项，请检查');
      return;
    }
    if (!_canUseContext) return;
    WidgetUtil.showLoadingDialog(buildContext);
    try {
      final res =
          await LoginApi.loginWithEmail(email: email, password: password);
      _closeLoading();
      LogBox.info('邮箱登录返回码: ${res.code}');
      if (res.code != 200) {
        WidgetUtil.showToast(res.message ?? '未知错误');
        return;
      }
      UserController.to.getUserState();
      if (_canUseContext) {
        AutoRouter.of(buildContext).pushPath('/home');
      }
    } on Exception catch (e) {
      LogBox.error(e, msg: '邮箱登录失败');
      _closeLoading();
      WidgetUtil.showToast('登录失败，请检查网络');
    }
  }

  Future<void> sendCaptcha(String phone) async {
    if (phone.isEmpty) {
      WidgetUtil.showToast('手机号为必填项，请检查');
      return;
    }
    if (!_canUseContext) return;
    WidgetUtil.showLoadingDialog(buildContext);
    try {
      final res = await LoginApi.captcha(phone);
      _closeLoading();
      if (res.code != 200) {
        WidgetUtil.showToast(res.message ?? '未知错误');
        return;
      }
      WidgetUtil.showToast('验证码发送成功');
    } catch (e) {
      LogBox.error(e, msg: '验证码发送失败');
      _closeLoading();
      WidgetUtil.showToast('验证码发送失败，请检查网络');
    }
  }

  Future<void> checkQrLoginStatus(String key, ValueNotifier<int> flag) async {
    final myValue = _readSignal(flag);
    if (myValue == null) return;
    var attempts = 0;
    while (!isClosed && attempts < 90) {
      final current = _readSignal(flag);
      if (current == null || current != myValue) return;
      attempts++;
      try {
        final res = await LoginApi.checkQrLoginStatus(key);
        if (isClosed) return;
        final after = _readSignal(flag);
        if (after == null || after != myValue) return;
        if (res != null) {
          if (res) {
            UserController.to.getUserState();
            if (_canUseContext) {
              AutoRouter.of(buildContext).pushPath('/home');
            }
          } else {
            WidgetUtil.showToast('二维码已失效，请刷新后重试');
          }
          return;
        }
      } catch (e) {
        LogBox.error(e, msg: '轮询扫码登录失败');
      }
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  int? _readSignal(ValueNotifier<int> flag) {
    try {
      return flag.value;
    } catch (_) {
      return null;
    }
  }


  static LoginController get to => Get.find();
}