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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    _initDependencies();
  }

  void _initDependencies() {
    HomeController.to.setScaffoldKey(_scaffoldKey);
    MainBinding().dependencies();
    RoamingBinding().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    RoamingController.to.buildContext = context;

    return AutoTabsRouter(
      transitionBuilder: _buildTransition,
      builder: _buildScaffold,
      routes: const [Main(), Found(), EmptyRoute(), Timeline(), User()],
    );
  }

  Widget _buildTransition(context, child, animation) =>
      FadeTransition(opacity: animation, child: child);

  Widget _buildScaffold(BuildContext context, Widget child) {
    final tabsRouter = AutoTabsRouter.of(context);
    HomeController.to.setTabsRouter(tabsRouter);

    return Scaffold(
      key: _scaffoldKey,
      body: child,
      drawer: _buildDrawer(),
      bottomSheet: _buildBottomSheet(),
      bottomNavigationBar: _buildBottomNav(tabsRouter),
    );
  }

  Widget _buildDrawer() => Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        width: ScreenUtil().screenWidth * 0.85,
        child: const DrawerHome(),
      );

  Widget _buildBottomSheet() => RoamingController.to.mediaItem.value.id == null
      ? const SizedBox()
      : const BottomPlayerBar();

  Widget _buildBottomNav(TabsRouter tabsRouter) => Obx(() {
        return BottomNavigationBar(
          currentIndex: HomeController.to.tabsRouter.value?.activeIndex ?? 0,
          onTap: (index) => _handleTabChange(index, tabsRouter),
          backgroundColor: Theme.of(_context).scaffoldBackgroundColor,
          selectedItemColor: Colours.app_main_light,
          unselectedItemColor: Theme.of(_context).colorScheme.onPrimary,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(fontSize: 9.0),
          unselectedLabelStyle: const TextStyle(fontSize: 9.0),
          items: _buildNavItems(tabsRouter),
        );
      });

  List<BottomNavigationBarItem> _buildNavItems(TabsRouter tabsRouter) {
    final items = [
      (TablerIcons.brand_netease_music, '推荐'),
      (TablerIcons.brand_safari, '发现'),
      (TablerIcons.radio, '漫游'),
      (TablerIcons.message_circle_user, '动态'),
      (TablerIcons.user, AppStrings.my),
    ];

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final (icon, label) = entry.value;
      final isSelected = tabsRouter.activeIndex == index;

      return _buildNavItem(icon, label, isSelected);
    }).toList();
  }

  BottomNavigationBarItem _buildNavItem(
          IconData icon, String label, bool isSelected) =>
      BottomNavigationBarItem(
        icon: ClipOval(
          child: Container(
            width: 25,
            height: 25,
            decoration: isSelected
                ? const BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                : null,
            child: Icon(icon,
                size: 22,
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 103, 110, 125)),
          ),
        ),
        label: label,
      );

  void _handleTabChange(int index, TabsRouter tabsRouter) {
    if (tabsRouter.activeIndex != index) {
      _removeCurrentController(tabsRouter.activeIndex);
      _initNewController(index);
    }

    if (index == TAB_ENUM.roaming.value) {
      Roaming.showBottomPlayer(_context);
    } else {
      tabsRouter.setActiveIndex(index);
    }
  }

  void _removeCurrentController(int currentIndex) {
    final tab = TAB_ENUM.fromValue(currentIndex);
    switch (tab) {
      case TAB_ENUM.found:
        Get.delete<FoundController>();
      case TAB_ENUM.timeline:
        Get.delete<TimelineController>();
      case TAB_ENUM.user:
        // 不要删除UserController,因为它需要保持登录状态
        break;
      default:
        break;
    }
  }

  void _initNewController(int newIndex) {
    final tab = TAB_ENUM.fromValue(newIndex);
    switch (tab) {
      case TAB_ENUM.main:
        if (!Get.isRegistered<MainController>()) {
          Get.lazyPut(() => MainController());
        }
      case TAB_ENUM.found:
        if (!Get.isRegistered<FoundController>()) {
          Get.lazyPut(() => FoundController());
        }
      case TAB_ENUM.timeline:
        if (!Get.isRegistered<TimelineController>()) {
          Get.lazyPut(() => TimelineController());
        }
      case TAB_ENUM.user:
        if (!Get.isRegistered<UserController>()) {
          Get.lazyPut(() => UserController());
        }
      default:
        break;
    }
  }
}
