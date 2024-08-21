import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  ScrollController _scrollController = ScrollController();
  Color _appBarBackgroundColor = Colors.transparent;
  Color _iconColor = Colors.white;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double opacity = (offset / 30).clamp(0, 1).toDouble();
      setState(() {
        _appBarBackgroundColor = Colors.white.withOpacity(opacity);
        _iconColor = Colors.black.withOpacity(opacity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(), // 允许弹性效果
      slivers: [
        SliverAppBar(
          expandedHeight: 400.0,
          collapsedHeight: statusBarHeight,
          pinned: true,
          stretch: true,
          // 启用下拉拉伸效果
          onStretchTrigger: () async {
            // 你可以在这里处理拉伸到一定程度的触发事件
          },
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'http://b.hiphotos.baidu.com/image/pic/item/e824b899a9014c08878b2c4c0e7b02087af4f4a3.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.colorBurn,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: Offset(0, -60.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
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
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60.0,
        color: _appBarBackgroundColor,
        child: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(Icons.menu, color: _iconColor),
              onTap: () {
                // Open settings page
              },
            ),
            Expanded(child: Container()),
            GestureDetector(
              child: Icon(Icons.search, color: _iconColor),
              onTap: () {
                // Open settings page
              },
            ),
            SizedBox(width: 15),
            GestureDetector(
              child: Icon(Icons.more_vert, color: _iconColor),
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
