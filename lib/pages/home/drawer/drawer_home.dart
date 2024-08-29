import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/routes/routes.gr.dart';
import '../../../common/constants/url.dart';
import '../../../http/api/login/login_api.dart';
import '../../../routes/routes.dart';
import '../../user/user_controller.dart';
import 'drawer_item.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  late List<DrawerItem> _listTop;
  late List<DrawerItem> _listMusicService;
  late List<DrawerItem> _listSettings;
  late List<DrawerItem> _listBottomInfo;
  final TextStyle listItemTextStyle = TextStyle(
    fontSize: 28.w, // 使用你定义的屏幕适配工具，如 ScreenUtil
    color: Colors.black,
    fontWeight: FontWeight.w200,
  );

  @override
  void initState() {
    super.initState();

    _listTop = [
      DrawerItem(icon: TablerIcons.mail, text: "我的消息", badge: "99"),
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

    _listMusicService = [
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

    _listSettings = [
      DrawerItem(
        icon: TablerIcons.settings,
        text: "设置",
      ),
      DrawerItem(
        icon: TablerIcons.moon_stars,
        text: "深色模式",
      ),
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
            GetIt.instance<AppRouter>().push(WebViewRoute(
                url: netease_info_list, title: "网易云音乐个人信息第三方共享清单"));
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

    _listBottomInfo = [
      DrawerItem(
          icon: TablerIcons.switch_horizontal, text: "切换账号", onTap: () {}),
      DrawerItem(
          icon: TablerIcons.logout,
          text: "退出登录",
          color: Colors.red,
          onTap: _logout),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // 如果有 borderRadius，需要移除或设置为 zero
        borderRadius: BorderRadius.zero,
      ),
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
        color: const Color(0xfff3f4f7),
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
      String? badge,
      Color? color,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.black, size: 35.w),
            SizedBox(width: 30.w),
            Text(text,
                style:
                    listItemTextStyle.copyWith(color: color ?? Colors.black)),
            const Spacer(),
            if (trailing != null)
              Row(
                children: [
                  trailing,
                  SizedBox(width: 10.w),
                ],
              )
            else if (badge != null && badge.isNotEmpty)
              Row(
                children: [
                  _buildBadge(badge),
                  SizedBox(width: 10.w),
                  Icon(Icons.chevron_right, color: Colors.grey[300])
                ],
              )
            else
              Icon(Icons.chevron_right, color: Colors.grey[300]),
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
                    _buildListItem(context,
                        icon: item.icon,
                        text: item.text,
                        color: item.color,
                        trailing: item.trailing,
                        badge: item.badge,
                        onTap: item.onTap),
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
