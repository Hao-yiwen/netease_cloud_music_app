import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';
import 'drawer_item.dart';
import 'item_settings.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  final TextStyle listItemTextStyle = TextStyle(
    fontSize: 28.w, // 使用你定义的屏幕适配工具，如 ScreenUtil
    color: Colors.black,
    fontWeight: FontWeight.w200,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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

  _buildHeader() {
    final useData = HomeController.to.userData.value;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: GestureDetector(
        onTap: () {
          HomeController.to.switchTab(TAB_ENUM.user.value);
          Navigator.of(context).pop();
        },
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
                  useData.profile?.avatarUrl ?? "",
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
                    useData.profile?.nickname ?? "",
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
      ),
    );
  }

  _buildContent() {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          _buildCardContent(list: getTopItem(context)),
          _buildCardContent(list: getListMusicService(context)),
          _buildCardContent(list: getListSettings(context)),
          _buildCardContent(list: getListBottomInfo(context))
        ],
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
            color: Theme.of(context).cardColor,
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
