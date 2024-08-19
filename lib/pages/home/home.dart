import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';

import '../../routes/routes.gr.dart';

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
    var scaffoldKey = GetIt.instance.registerSingleton<GlobalKey<ScaffoldState>>(GlobalKey<ScaffoldState>());
    return AutoTabsScaffold(
      scaffoldKey: scaffoldKey,
      drawer: Drawer(
        width: ScreenUtil().screenWidth * 0.8,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      routes: const [
        Main(),
        Found(),
        Roaming(),
        Timeline(),
        User(),
      ],
      bottomSheet: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            // bottom border
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 0.5,
              ),
            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20.w),
              Icon(
                TablerIcons.brand_netease_music,
                size: 40,
              ),
              SizedBox(width: 10),
              Text('播放条占位~',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(TablerIcons.player_play, size: 20),
              SizedBox(width: 10),
              Icon(TablerIcons.music, size: 20),
              SizedBox(width: 20),
            ],
          )),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
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
              icon: TablerIcons.brand_netease_music,
              label: '推荐',
              isSelected: tabsRouter.activeIndex == 0,
            ),
            _buildBottomNavigationBarItem(
              icon: TablerIcons.brand_safari,
              label: '发现',
              isSelected: tabsRouter.activeIndex == 1,
            ),
            _buildBottomNavigationBarItem(
              icon: TablerIcons.radio,
              label: '漫游',
              isSelected: tabsRouter.activeIndex == 2,
            ),
            _buildBottomNavigationBarItem(
              icon: TablerIcons.message_circle_user,
              label: '动态',
              isSelected: tabsRouter.activeIndex == 3,
            ),
            _buildBottomNavigationBarItem(
              icon: TablerIcons.user,
              label: '我的',
              isSelected: tabsRouter.activeIndex == 4,
            ),
          ],
        );
      },
    );
  }
}

BottomNavigationBarItem _buildBottomNavigationBarItem({
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
