import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';

import '../../../common/constants/location_map.dart';
import '../../../common/utils/birthday.dart';
import '../../../common/utils/image_utils.dart';
import '../../../http/api/login/dto/login_status_dto.dart';
import '../../../widgets/netease_cache_image.dart';

class HeaderUserInfo extends GetView<UserController> {
  const HeaderUserInfo({super.key, required this.userInfo});

  final LoginStatusDto userInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        _buildNickname(),
        _buildSignature(),
        _buildUserInfo(),
        _buildStats(),
        SizedBox(height: 40.w),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: NeteaseCacheImage(
          picUrl: userInfo.profile?.avatarUrl ?? "",
          size: const Size(80, 80),
        ),
      ),
    );
  }

  Widget _buildNickname() {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userInfo.profile?.nickname ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 6),
            Image.asset(ImageUtils.getImagePath('vip_tag'), width: 60),
          ],
        ),
      ],
    );
  }

  Widget _buildSignature() {
    return Column(
      children: [
        SizedBox(height: 10.w),
        Text(
          userInfo.profile?.signature ?? "",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(height: 15.w),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMedalInfo(),
        _buildDivider(),
        if (userInfo.profile?.province != null &&
            provinceMap[userInfo.profile?.province.toString()] != null)
          _buildLocationInfo(),
        if (userInfo.profile?.gender != null &&
            userInfo.profile?.birthday != null)
          _buildGenderAndBirthInfo(),
      ],
    );
  }

  Widget _buildMedalInfo() {
    return Row(
      children: [
        Icon(
          TablerIcons.medal,
          color: Colors.grey[200],
          size: 30.w,
        ),
        SizedBox(width: 5.w),
        Text(
          "12枚徽章",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        SizedBox(width: 20.w),
        Text(
          "|",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Text(
          provinceMap[userInfo.profile?.province.toString()]!,
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(width: 20.w),
        Text(
          "·",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
      ],
    );
  }

  Widget _buildGenderAndBirthInfo() {
    return Row(
      children: [
        SizedBox(width: 20.w),
        Icon(
          userInfo.profile!.gender == GENDER_STATUS.MEAL.value
              ? TablerIcons.gender_male
              : TablerIcons.gender_female,
          color: userInfo.profile!.gender == GENDER_STATUS.MEAL.value
              ? Colors.blue[200]
              : Colors.pink[200],
          size: 30.w,
        ),
        Text(
          "${getGenerationLabel(calculateBirthYear(userInfo.profile!.birthday.toString()))} ${calculateZodiacSign(userInfo.profile!.birthday.toString())}",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildStats() {
    return Obx(() {
      return Visibility(
        visible: controller.loading.value == false &&
            controller.userAccount.value.profile != null,
        child: Column(
          children: [
            SizedBox(height: 25.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem(
                    "${controller.userAccount.value.profile?.follows} 关注"),
                _buildStatItem(
                    "${controller.userAccount.value.profile?.followeds} 粉丝"),
                _buildStatItem("Lv.${controller.userAccount.value.level}等级"),
                _buildStatItem(
                    "听过 ${controller.userAccount.value.listenSongs} 首歌"),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey[200], fontSize: 24.sp),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ["动态", "本地", "云盘", "已购"].map<Widget>((e) {
        return Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: _buildBoxInfo(title: e, icon: TablerIcons.clock_hour_3_filled),
        );
      }).toList(),
    );
  }

  Widget _buildBoxInfo({required String title, required IconData icon}) {
    return Container(
      height: 65.w,
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 34.w,
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 26.sp),
          )
        ],
      ),
    );
  }
}
