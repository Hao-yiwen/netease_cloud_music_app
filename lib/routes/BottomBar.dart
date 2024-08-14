import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatelessWidget {
  final Widget child;
  final GoRouterState state;
  const BottomBar({super.key, required this.child, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getSelectedIndex(state.matchedLocation),
        onTap: (index) => _onItemTapped(context, index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '推荐',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: '社区',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String matchedLocation) {
    if (matchedLocation.contains('/found')) {
      return 1;
    } else if (matchedLocation.contains('/timeline')) {
      return 2;
    } else if (matchedLocation.contains('/mine')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      context.go('/home');
    } else if (index == 1) {
      context.go('/found');
    } else if (index == 2) {
      context.go('/timeline');
    } else if (index == 3) {
      context.go('/mine');
    }
  }
}
