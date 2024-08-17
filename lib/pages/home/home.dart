import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.gr.dart';

@RoutePage()
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        Main(),
        Timeline(),
        Found(),
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
            fontSize: 11.0, // 选中时的字体大小
          ),
          unselectedLabelStyle: const TextStyle(
            // fontWeight: FontWeight.bold, // 未选中时的字体粗细
            fontSize: 11.0, // 未选中时的字体大小
          ),
          items: [
            _buildBottomNavigationBarItem(
              icon: Icons.home,
              label: '推荐',
              isSelected: tabsRouter.activeIndex == 0,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.search,
              label: '发现',
              isSelected: tabsRouter.activeIndex == 1,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.timeline,
              label: '社区',
              isSelected: tabsRouter.activeIndex == 2,
            ),
            _buildBottomNavigationBarItem(
              icon: Icons.person,
              label: '我的',
              isSelected: tabsRouter.activeIndex == 3,
            ),
          ],
        );
      },
    );
  }
}

BottomNavigationBarItem _buildBottomNavigationBarItem({
  required IconData icon,
  required String label,
  required bool isSelected,
  double iconSize = 20.0, // 默认图标大小为 24
}) {
  return BottomNavigationBarItem(
    icon: Container(
      height: 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red, // 圆形背景颜色
              ),
            ),
          Icon(
            icon,
            size: iconSize,
            color: isSelected ? Colors.white : Colors.grey, // 选中时图标颜色为白色
          ),
        ],
      ),
    ),
    label: label,
  );
}
