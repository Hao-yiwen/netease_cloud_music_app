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
        // avatar
        Container(
          height: 80, // 这里的高度和宽度比图片的尺寸略大，以确保边框显示在外面
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2), // 边框
          ),
          child: ClipOval(
            child: NeteaseCacheImage(
                picUrl: userInfo.profile?.avatarUrl ?? "",
                size: const Size(80, 80)),
          ),
        ),
        // nickname
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
            SizedBox(
              width: 6,
            ),
            Image.asset(ImageUtils.getImagePath('vip_tag'), width: 60),
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Text(
          userInfo.profile?.signature ?? "",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(
          height: 15.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              TablerIcons.medal,
              color: Colors.grey[200],
              size: 30.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "12枚徽章",
              style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              "|",
              style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            if (userInfo.profile?.province != null &&
                provinceMap[userInfo.profile?.province.toString()] != null)
              Row(
                children: [
                  Text(
                    provinceMap[userInfo.profile?.province.toString()]!,
                    style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "·",
                    style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
                  ),
                ],
              ),
            if (userInfo.profile?.gender != null &&
                userInfo.profile?.birthday != null)
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
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
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
          ],
        ),
        Obx(() {
          return Visibility(
            visible: controller.loding.value == false &&
                controller.userAccount.value.profile != null,
            child: Column(
              children: [
                SizedBox(
                  height: 25.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.userAccount.value.profile?.follows} 关注",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "${controller.userAccount.value.profile?.followeds} 粉丝",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Lv.${controller.userAccount.value.level}等级",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "听过 ${controller.userAccount.value.listenSongs} 首歌",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        SizedBox(
          height: 40.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ["动态", "本地", "云盘", "已购"].map<Widget>((e) {
            return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: _buildBoxInfo(
                    title: e, icon: TablerIcons.clock_hour_3_filled));
          }).toList(),
        )
      ],
    );
  }

  _buildBoxInfo({required String title, required IconData icon}) {
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
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 26.sp),
          )
        ],
      ),
    );
  }
}
