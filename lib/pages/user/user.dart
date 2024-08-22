import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

@RoutePage()
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _MineState();
}

class _MineState extends State<User> {
  ScrollController _scrollController = ScrollController();
  Color _appBarBackgroundColor = Colors.transparent;
  Color _iconColor = Colors.white;
  double imageHeight = 400.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double opacity = (offset / 30).clamp(0, 1).toDouble();

      if (offset < 0) {
        // 当向下拉动时，增加图片高度
        setState(() {
          imageHeight = 400.0 - offset; // offset 为负值，所以这里是增加高度
        });
      }

      setState(() {
        _appBarBackgroundColor = Colors.white.withOpacity(opacity);
        if(opacity > 0.5) {
          _iconColor = Colors.black.withOpacity(opacity);
        } else {
          _iconColor = Colors.white;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取安全区的顶部高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double headerHeight = statusBarHeight + 60.0; // 保证header的高度考虑了状态栏的高度

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverHeaderDelegate(
              minHeight: headerHeight, // 最小高度包含状态栏高度
              maxHeight: headerHeight, // 最大高度同样包含状态栏高度
              child: _buildHeader(context, headerHeight: headerHeight, statusBarHeight: statusBarHeight)),
        ),
        SliverToBoxAdapter(
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -((imageHeight - 400) + headerHeight)),
                  child: SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: Image.network(
                      'http://b.hiphotos.baidu.com/image/pic/item/e824b899a9014c08878b2c4c0e7b02087af4f4a3.jpg',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.2),
                      colorBlendMode: BlendMode.colorBurn,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 330,
                    ),
                    Transform.translate(
                      offset: Offset(0, -80),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: List.generate(
                            20,
                                (index) => ListTile(
                              title: Text('Item $index'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, {required double headerHeight, required double statusBarHeight}) {
    return Container(
        height: headerHeight, // Header 本身的高度，已经由 SliverPersistentHeader 的 minHeight 和 maxHeight 控制
        color: _appBarBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Row(
            children: [
              SizedBox(width: 10),
              GestureDetector(
                child: Icon(TablerIcons.menu_2, color: _iconColor),
                onTap: () {
                  // Open settings page
                },
              ),
              Expanded(child: Container()),
              GestureDetector(
                child: Icon(TablerIcons.search, color: _iconColor),
                onTap: () {
                  // Open settings page
                },
              ),
              SizedBox(width: 15),
              GestureDetector(
                child: Icon(TablerIcons.dots_vertical, color: _iconColor),
                onTap: () {
                  // Open settings page
                },
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
      );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        child != oldDelegate.child;
  }
}