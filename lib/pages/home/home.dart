import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../routes/routes.gr.dart';

@RoutePage()
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Navigation'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Star'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
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
