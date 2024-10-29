import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/app_strings.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/mian_binding.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_binding.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import '../../routes/routes.dart';
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
    // 设置RoamingController buildcontext
    RoamingController.to.buildContext = context;
    return AutoTabsRouter(
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, chiild) {
        final tabsRouter = AutoTabsRouter.of(context);
        HomeController.to.setTabsRouter(tabsRouter);

        return Scaffold(
            body: chiild,
            key: scaffoldState,
            drawer: Drawer(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              width: ScreenUtil().screenWidth * 0.85,
              child: const DrawerHome(),
            ),
            bottomSheet: RoamingController.to.mediaItem.value.id == null
                ? const SizedBox()
                : const BottomPlayerBar(),
            bottomNavigationBar: Obx(() {
              return BottomNavigationBar(
                currentIndex:
                    HomeController.to.tabsRouter.value?.activeIndex ?? 0,
                onTap: (index) {
                  _changeTabIndex(
                      context, index, HomeController.to.tabsRouter.value!);
                },
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                selectedItemColor: Colours.app_main_light,
                unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
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
                    isSelected:
                        HomeController.to.tabsRouter.value!.activeIndex ==
                            TAB_ENUM.main.value,
                  ),
                  _buildBottomNavigationBarItem(
                    context,
                    icon: TablerIcons.brand_safari,
                    label: '发现',
                    isSelected:
                        HomeController.to.tabsRouter.value!.activeIndex ==
                            TAB_ENUM.found.value,
                  ),
                  _buildBottomNavigationBarItem(
                    context,
                    icon: TablerIcons.radio,
                    label: '漫游',
                    isSelected:
                        HomeController.to.tabsRouter.value!.activeIndex ==
                            TAB_ENUM.roaming.value,
                  ),
                  _buildBottomNavigationBarItem(
                    context,
                    icon: TablerIcons.message_circle_user,
                    label: '动态',
                    isSelected:
                        HomeController.to.tabsRouter.value!.activeIndex ==
                            TAB_ENUM.timeline.value,
                  ),
                  _buildBottomNavigationBarItem(
                    context,
                    icon: TablerIcons.user,
                    label: AppStrings.my,
                    isSelected:
                        HomeController.to.tabsRouter.value!.activeIndex ==
                            TAB_ENUM.user.value,
                  ),
                ],
              );
            }));
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

  _changeTabIndex(BuildContext context, int index, TabsRouter tabsRouter) {
    // 先删除上一个页面的控制器（如果需要）
    if (tabsRouter.activeIndex != index) {
      switch (TAB_ENUM.fromValue(tabsRouter.activeIndex)) {
        // case TAB_ENUM.main:
        //   Get.delete<MainController>();
        //   break;
        case TAB_ENUM.found:
          Get.delete<FoundController>();
          break;
        case TAB_ENUM.timeline:
          Get.delete<TimelineController>();
          break;
        case TAB_ENUM.user:
          Get.delete<UserController>();
          break;
        case TAB_ENUM.roaming:
          break;
        default:
          break;
      }
    }

    // 根据选择的页面懒加载控制器
    switch (TAB_ENUM.fromValue(index)) {
      case TAB_ENUM.main:
        Get.lazyPut<MainController>(() => MainController());
        break;
      case TAB_ENUM.found:
        Get.lazyPut<FoundController>(() => FoundController());
        break;
      case TAB_ENUM.timeline:
        Get.lazyPut<TimelineController>(() => TimelineController());
        break;
      case TAB_ENUM.user:
        Get.lazyPut<UserController>(() => UserController());
        break;
      case TAB_ENUM.roaming:
        break;
    }
    if (index == TAB_ENUM.roaming.value) {
      // 当点击的是“漫游”Tab时，弹出底部页面
      Roaming.showBottomPlayer(context);
    } else {
      // 对于其他 Tabs，正常切换页面
      tabsRouter.setActiveIndex(index);
    }
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
