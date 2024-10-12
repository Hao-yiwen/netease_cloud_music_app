import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/service/theme_service.dart';

import '../../../common/constants/url.dart';
import '../../../http/api/login/login_api.dart';
import '../../../routes/routes.dart';
import '../../../routes/routes.gr.dart';
import '../../user/user_controller.dart';
import 'drawer_item.dart';

List<DrawerItem> getTopItem(BuildContext context, {int? messageCount}) {
  return [
    DrawerItem(icon: TablerIcons.mail, text: "我的消息", badge: (messageCount ?? 0).toString(), onTap: (){
      GetIt.instance<AppRouter>().pushNamed(Routes.message);
    }),
    DrawerItem(
      icon: TablerIcons.currency_ethereum,
      text: "云贝中心",
    ),
    DrawerItem(
      icon: TablerIcons.shirt,
      text: "装扮中心",
    ),
    DrawerItem(
      icon: TablerIcons.rosette,
      text: "徽章中心",
    ),
    DrawerItem(
      icon: TablerIcons.bulb,
      text: "创作者中心",
    ),
  ];
}

List<DrawerItem> getListMusicService(BuildContext context) {
  return [
    DrawerItem(
      icon: TablerIcons.sparkles,
      text: "音乐服务",
    ),
    DrawerItem(
      icon: TablerIcons.sparkles,
      text: "趣测",
    ),
    DrawerItem(
      icon: TablerIcons.ticket,
      text: "云村有票",
    ),
    DrawerItem(
      icon: TablerIcons.brand_shopee,
      text: "商城",
    ),
    DrawerItem(
      icon: TablerIcons.microphone_2,
      text: "歌房",
    ),
    DrawerItem(
      icon: TablerIcons.flame,
      text: "云推歌",
    ),
    DrawerItem(
      icon: TablerIcons.brand_tiktok,
      text: "彩铃专区",
    ),
    DrawerItem(
      icon: TablerIcons.building_broadcast_tower,
      text: "免流量听歌",
    ),
  ];
}

List<DrawerItem> getListSettings(BuildContext context) {
  return [
    DrawerItem(
      icon: TablerIcons.settings,
      text: "设置",
    ),
    DrawerItem(
        icon: TablerIcons.moon_stars,
        text: "深色模式",
        trailing: SizedBox(
            height: 60.w,
            width: 120.w,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Obx(() {
                  return Switch(
                      trackOutlineColor: MaterialStateProperty.resolveWith(
                        (final Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return null;
                          }
                          return Colors.transparent;
                        },
                      ),
                      activeTrackColor: Colors.red,
                      // 当开关关闭时的轨道颜色
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[200],
                      value: ThemeService.to.currentThemeMode == ThemeMode.dark,
                      onChanged: (value) {
                        ThemeService.to.switchThemeMode(
                            value ? ThemeMode.dark : ThemeMode.light);
                      });
                })))),
    DrawerItem(
      icon: TablerIcons.stopwatch,
      text: "定时关闭",
    ),
    DrawerItem(
      icon: TablerIcons.headphones,
      text: "边听边存",
    ),
    DrawerItem(
      icon: TablerIcons.gavel,
      text: "音乐收藏家",
    ),
    DrawerItem(
      icon: TablerIcons.shield,
      text: "青少年模式",
    ),
    DrawerItem(
      icon: TablerIcons.alarm,
      text: "音乐闹钟",
    ),
    DrawerItem(
        icon: TablerIcons.file_invoice,
        text: "个人信息收集与使用清单",
        onTap: () {
          GetIt.instance<AppRouter>().push(
              WebViewRoute(url: NETEASE_INFO_LIST, title: "网易云音乐个人信息第三方共享清单"));
        }),
    DrawerItem(
      icon: TablerIcons.notes,
      text: "个人信息收集与第三方共享清单",
    ),
    DrawerItem(icon: TablerIcons.shield_check, text: "个人信息与隐私保护"),
    DrawerItem(
        icon: TablerIcons.info_circle,
        text: "关于",
        onTap: () {
          GetIt.instance<AppRouter>().pushNamed(Routes.about);
        }),
  ];
}

List<DrawerItem> getListBottomInfo(BuildContext context) {
  return [
    DrawerItem(icon: TablerIcons.switch_horizontal, text: "切换账号", onTap: () {}),
    DrawerItem(
        icon: TablerIcons.logout,
        text: "退出登录",
        color: Colors.red,
        onTap: () {
          UserController.to.logout();
        }),
  ];
}
