import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import '../../widgets/custom_field.dart';
import 'login_controller.dart';

@RoutePage()
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = LoginController.to;
  final TextEditingController phone = TextEditingController();
  final TextEditingController captcha = TextEditingController();
  int time = 60;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Image.asset(
                  ImageUtils.getImagePath('erq'),
                  height: 150.w,
                  width: 150.w,
                ),
              ),
              SizedBox(height: 330.w),
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
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => controller.sendCaptcha(phone.text),
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
                      borderRadius: BorderRadius.circular(50.w)),
                  child: Text(
                    '立即登录',
                    style: TextStyle(
                        fontSize: 32.w,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () => controller.loginCallPhone(phone.text, captcha.text),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
