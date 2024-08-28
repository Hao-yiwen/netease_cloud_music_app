import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../http/api/login/login_api.dart';
import '../../user/user_controller.dart';
import 'drawer_item.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  var _listTop = [
    DrawerItem(icon: TablerIcons.mail, text: "我的消息", badge: "99"),
    DrawerItem(
        icon: TablerIcons.currency_ethereum, text: "云贝中心", badge: ""),
    DrawerItem(icon: TablerIcons.shirt, text: "装扮中心", badge: ""),
    DrawerItem(icon: TablerIcons.rosette, text: "徽章中心", badge: ""),
    DrawerItem(icon: TablerIcons.bulb, text: "创作者中心", badge: ""),
  ];

  var _listMusicService = [
    DrawerItem(icon: TablerIcons.sparkles, text: "音乐服务", badge: ""),
    DrawerItem(icon: TablerIcons.sparkles, text: "趣测", badge: ""),
    DrawerItem(icon: TablerIcons.ticket, text: "云村有票", badge: ""),
    DrawerItem(icon: TablerIcons.brand_shopee, text: "商城", badge: ""),
    DrawerItem(icon: TablerIcons.microphone_2, text: "歌房", badge: ""),
    DrawerItem(icon: TablerIcons.flame, text: "云推歌", badge: ""),
    DrawerItem(icon: TablerIcons.brand_tiktok, text: "彩铃专区", badge: ""),
    DrawerItem(
        icon: TablerIcons.building_broadcast_tower,
        text: "免流量听歌",
        badge: ""),
  ];

  var _listSettings = [
    DrawerItem(icon: TablerIcons.settings, text: "设置", badge: ""),
    DrawerItem(icon: TablerIcons.moon_stars, text: "深色模式", badge: ""),
    DrawerItem(icon: TablerIcons.stopwatch, text: "定时关闭", badge: ""),
    DrawerItem(icon: TablerIcons.headphones, text: "边听边存", badge: ""),
    DrawerItem(icon: TablerIcons.gavel, text: "音乐收藏家", badge: ""),
    DrawerItem(icon: TablerIcons.shield, text: "青少年模式", badge: ""),
    DrawerItem(icon: TablerIcons.alarm, text: "音乐闹钟", badge: ""),
    DrawerItem(
        icon: TablerIcons.file_invoice,
        text: "个人信息收集与使用清单",
        badge: ""),
    DrawerItem(
        icon: TablerIcons.notes,
        text: "个人信息收集与第三方共享清单",
        badge: ""),
    DrawerItem(
        icon: TablerIcons.shield_check,
        text: "个人信息与隐私保护",
        badge: ""),
    DrawerItem(
        icon: TablerIcons.info_circle, text: "关于", badge: ""),
  ];

  var _listBottomInfo = [
    DrawerItem(
        icon: TablerIcons.switch_horizontal,
        text: "切换账号",
        badge: ""),
    DrawerItem(
        icon: TablerIcons.logout,
        text: "退出登录",
        badge: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [_buildHeader(), _buildContent()],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await LoginApi.logout();
    UserController.to.logout();
    AutoRouter.of(context).replaceNamed('/login');
  }

  _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          // 头像
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.w),
              border: Border.all(
                color: Colors.white,
                width: 2.w,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                "http://g.hiphotos.baidu.com/image/pic/item/55e736d12f2eb938d5277fd5d0628535e5dd6f4a.jpg",
                fit: BoxFit.cover,
                height: 60.w, // 图片的尺寸比外层的Container略小
                width: 60.w,
              ),
            ),
          ),
          // 用户名
          SizedBox(width: 20.w),
          GestureDetector(
            child: Row(
              children: [
                Text(
                  "老死在撒哈拉",
                  style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  TablerIcons.chevron_right,
                  size: 40.w,
                  color: Colors.black54,
                )
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            child: Icon(
              TablerIcons.scan,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
      child: Container(
        color: Color(0xfff3f4f7),
        child: CustomScrollView(
          slivers: [
            _buildCardContent(list: _listTop),
            _buildCardContent(list: _listMusicService),
            _buildCardContent(list: _listSettings),
            _buildCardContent(list: _listBottomInfo)
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required IconData icon,
        required String text,
        Widget? trailing,
        Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 35.w),
            SizedBox(width: 30.w),
            Text(text,
                style: TextStyle(
                    fontSize: 28.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w200)),
            Spacer(),
            trailing != null
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                trailing!,
                SizedBox(width: 10.w),
                Icon(Icons.chevron_right, color: Colors.grey[300])
              ],
            )
                : Icon(Icons.chevron_right, color: Colors.grey[300]),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[100]);
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
    );
  }

  _buildCardContent({required List<DrawerItem> list}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              children: [
                ...list.map((item) {
                  return Column(children: [
                    _buildListItem(
                      context,
                      icon: item.icon,
                      text: item.text,
                      trailing: item.badge != null && item.badge != ''
                          ? _buildBadge(item.badge as String)
                          : null,
                    ),
                    if (list.indexOf(item) != list.length - 1) _buildDivider(),
                  ]);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
