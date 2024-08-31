import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/mian_binding.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_binding.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/bottom_player_bar.dart';
import '../found/found_controller.dart';
import '../main/main_controller.dart';
import '../timeline/timeline_controller.dart';
import '../user/user_controller.dart';
import 'drawer/drawer_home.dart';
import '../roaming/roaming.dart';

@RoutePage()
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // 注册全局drawer key，任何地方都可以通过getit获取打开
    var scaffoldState = GlobalKey<ScaffoldState>();
    HomeController.to.setScaffoldKey(scaffoldState);
    // 首页加载
    MainBinding().dependencies();
    // 播放器加载
    RoamingBinding().dependencies();
    return AutoTabsRouter(
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, chiild) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
            body: chiild,
            key: scaffoldState,
            drawer: Drawer(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              width: ScreenUtil().screenWidth * 0.85,
              child: DrawerHome(),
            ),
            bottomSheet: Hero(
              tag: 'test',
              child: BottomPlayerBar(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                // 先删除上一个页面的控制器（如果需要）
                if (tabsRouter.activeIndex != index) {
                  switch (tabsRouter.activeIndex) {
                    case 0:
                      Get.delete<MainController>();
                      break;
                    case 1:
                      Get.delete<FoundController>();
                      break;
                    case 3:
                      Get.delete<TimelineController>();
                      break;
                    case 4:
                      Get.delete<UserController>();
                      break;
                  }
                }

                // 根据选择的页面懒加载控制器
                switch (index) {
                  case 0:
                    Get.lazyPut<MainController>(() => MainController());
                    break;
                  case 1:
                    Get.lazyPut<FoundController>(() => FoundController());
                    break;
                  case 3:
                    Get.lazyPut<TimelineController>(() => TimelineController());
                    break;
                  case 4:
                    Get.lazyPut<UserController>(() => UserController());
                    break;
                }
                if (index == 2) {
                  // 当点击的是“漫游”Tab时，弹出底部页面
                  Roaming.showBottomPlayer(context);
                } else {
                  // 对于其他 Tabs，正常切换页面
                  tabsRouter.setActiveIndex(index);
                }
              },
              backgroundColor: Colors.white,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                // fontWeight: FontWeight.bold, // 选中时的字体粗细
                fontSize: 9.0, // 选中时的字体大小
              ),
              unselectedLabelStyle: const TextStyle(
                // fontWeight: FontWeight.bold, // 未选中时的字体粗细
                fontSize: 9.0, // 未选中时的字体大小
              ),
              items: [
                _buildBottomNavigationBarItem(
                  context,
                  icon: TablerIcons.brand_netease_music,
                  label: '推荐',
                  isSelected: tabsRouter.activeIndex == 0,
                ),
                _buildBottomNavigationBarItem(
                  context,
                  icon: TablerIcons.brand_safari,
                  label: '发现',
                  isSelected: tabsRouter.activeIndex == 1,
                ),
                _buildBottomNavigationBarItem(
                  context,
                  icon: TablerIcons.radio,
                  label: '漫游',
                  isSelected: tabsRouter.activeIndex == 2,
                ),
                _buildBottomNavigationBarItem(
                  context,
                  icon: TablerIcons.message_circle_user,
                  label: '动态',
                  isSelected: tabsRouter.activeIndex == 3,
                ),
                _buildBottomNavigationBarItem(
                  context,
                  icon: TablerIcons.user,
                  label: '我的',
                  isSelected: tabsRouter.activeIndex == 4,
                ),
              ],
            ));
      },
      routes: const [
        Main(),
        Found(),
        EmptyRoute(), // 这里只是占位
        Timeline(),
        User(),
      ],
    );
  }
}

BottomNavigationBarItem _buildBottomNavigationBarItem(
  BuildContext context, {
  IconData? icon,
  String? imagePath,
  required String label,
  required bool isSelected,
  double iconSize = 22.0, // 默认图标大小为 24
}) {
  return BottomNavigationBarItem(
    icon: ClipOval(
      child: Container(
          width: 25,
          height: 25,
          decoration: isSelected
              ? BoxDecoration(color: Colors.red, shape: BoxShape.circle)
              : null,
          child: Icon(icon,
              size: iconSize,
              color: isSelected
                  ? Colors.white
                  : Color.fromARGB(255, 103, 110, 125))),
    ),
    label: label,
  );
}
