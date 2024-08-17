import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:netease_cloud_music_app/api/api_response.dart';
import 'package:netease_cloud_music_app/api/src/login_api.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import '../../widgets/custom_field.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController captcha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/login_top.svg',
                fit: BoxFit.contain, // 确保图片填充整个容器
                height: 200,
              ),
              SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomField(
                        padding: EdgeInsets.only(
                            left: 15.w, top: 12.w, bottom: 12.w),
                        iconData: TablerIcons.phone,
                        textEditingController: phone,
                        hitText: "请输入手机号",
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.w),
                          bottomLeft: Radius.circular(50.w),
                        ),
                      ),
                    ),
                    // todo 太丑了 要优化
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => sendCaptcha(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50.w),
                                  bottomRight: Radius.circular(50.w))),
                          margin: EdgeInsets.symmetric(vertical: 10.w),
                          child: Center(
                            child: Text(
                              '发送验证码',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              CustomField(
                iconData: TablerIcons.lock,
                textEditingController: captcha,
                hitText: "请输入验证码",
              ),
              SizedBox(height: 16),
              GestureDetector(
                child: Container(
                  height: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.w)),
                  child: Text(
                    '立即登录',
                    style: TextStyle(fontSize: 28.w, color: Colors.white),
                  ),
                ),
                onTap: () => loginCallPhone(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginCallPhone(BuildContext context) async {
    if (phone.text.isEmpty || captcha.text.isEmpty) {
      WidgetUtil.showToast('账号和密码为必填项，请检查');
      return;
    }
    WidgetUtil.showLoadingDialog(context);
    ApiResponse res =
        await LoginApi.loginWithPhone(phone: phone.text, captcha: captcha.text);
    WidgetUtil.closeLoadingDialog(context);
    if (res.code != 200) {
      WidgetUtil.showToast(res.message ?? '未知错误');
      return;
    } else {
      AutoRouter.of(context).pushNamed('/home');
    }
  }

  sendCaptcha(BuildContext context) async {
    if (phone.text.isEmpty) {
      WidgetUtil.showToast('手机号为必填项，请检查');
      return;
    }
    WidgetUtil.showLoadingDialog(context);
    ApiResponse res = await LoginApi.captcha(phone.text);
    WidgetUtil.closeLoadingDialog(context);
    if (res.code != 200) {
      WidgetUtil.showToast(res.message ?? '未知错误');
      return;
    } else {
      WidgetUtil.showToast('验证码发送成功');
    }
  }
}
