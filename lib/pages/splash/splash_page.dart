import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/pages/splash/splash_controller.dart';
import '../../common/constants/colours.dart';

@RoutePage()
class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.app_main,
        body: Container(
          padding: EdgeInsets.only(top: controller.isFirst.value ? 100 : 255),
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            children: [_buildContent()],
          ),
        ));
  }

  _buildContent() {
    if (controller.isFirst.value) {
      return Image.asset(
        'assets/anim/cif.webp',
      );
    } else {
      return Image.asset(
        ImageUtils.getImagePath('erq'),
        height: 200.w,
        width: 200.w,
      );
    }
  }
}
