import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/controllers/auth_controller.dart';

import '../../widgets/custom_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late AuthController authController;
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
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
              CustomField(
                iconData: TablerIcons.phone,
                textEditingController: phone,
                hitText: "输入邮箱/手机号",
              ),
              SizedBox(height: 16),
              CustomField(
                iconData: TablerIcons.lock,
                textEditingController: password,
                hitText: "请输入密码",
                pass: true,
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

  loginCallPhone(BuildContext context) {
    if (phone.text.isEmpty || password.text.isEmpty) {
      // WidgetUtil.showToast('账号和密码为必填项，请检查');
      WidgetUtil.showLoadingDialog(context);
      return;
    }
    if(phone.text.contains("@")){

    } else {

    }
  }
}
