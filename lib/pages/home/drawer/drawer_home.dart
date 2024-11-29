import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/message/message_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';
import 'drawer_item.dart';
import 'item_settings.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  final MessageController messageController = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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

  Widget _buildHeader() {
    final userData = HomeController.to.userData.value;
    final profile = userData.profile;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HomeController.to.switchTab(TAB_ENUM.user.value);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.w),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.w,
                    ),
                  ),
                  child: ClipOval(
                    child: NeteaseCacheImage(
                      picUrl: profile?.avatarUrl ?? "",
                      size: Size(60.w, 60.w),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  profile?.nickname ?? "",
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
          const Spacer(),
          GestureDetector(
            child: const Icon(
              TablerIcons.scan,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          _buildCardContent(
            list: getTopItem(
              context,
              messageCount: messageController.privateMessage.value.newMsgCount,
            ),
          ),
          _buildCardContent(list: getListMusicService(context)),
          _buildCardContent(list: getListSettings(context)),
          _buildCardContent(list: getListBottomInfo(context)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    Widget? trailing,
    String? badge,
    Color? color,
    VoidCallback? onTap,
  }) {
    final itemColor = color ?? Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(icon, color: itemColor, size: 35.w),
            SizedBox(width: 30.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 28.w,
                color: itemColor,
                fontWeight: FontWeight.w200,
              ),
            ),
            const Spacer(),
            if (trailing != null) ...[
              trailing,
              SizedBox(width: 10.w),
            ] else if (badge?.isNotEmpty ?? false) ...[
              _buildBadge(badge!),
              SizedBox(width: 10.w),
              Icon(Icons.chevron_right, color: Colors.grey[300]),
            ] else
              Icon(Icons.chevron_right, color: Colors.grey[300]),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : Colors.grey[100],
    );
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

  Widget _buildCardContent({required List<DrawerItem> list}) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(24.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              children: [
                for (var i = 0; i < list.length; i++) ...[
                  _buildListItem(
                    context,
                    icon: list[i].icon,
                    text: list[i].text,
                    color: list[i].color,
                    trailing: list[i].trailing,
                    badge: list[i].badge,
                    onTap: list[i].onTap,
                  ),
                  if (i < list.length - 1) _buildDivider(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
