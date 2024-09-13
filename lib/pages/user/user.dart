import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';
import 'package:netease_cloud_music_app/pages/user/widgets/header_user_info.dart';
import 'package:netease_cloud_music_app/pages/user/widgets/sliver_header_delegate.dart';
import 'package:netease_cloud_music_app/widgets/songs_list_widget.dart';

import '../../common/constants/colors.dart';
import '../../widgets/netease_cache_image.dart';
import '../../widgets/play_list_card.dart';
import '../../widgets/user_event_widget.dart';
import 'constrants.dart';

@RoutePage()
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _MineState();
}

class _MineState extends State<User> with TickerProviderStateMixin {
  final UserController controller = UserController.to;
  final ScrollController _scrollController = ScrollController();
  Color _appBarBackgroundColor = Colors.transparent;
  Color _iconColor = Colors.white;
  double imageHeight = 850.w;

  // tabcontroller
  late TabController _tabController;
  late PageController _pageViewController;

  // stickytabheader
  bool _isPinned = false;
  GlobalKey stickyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageViewController = PageController();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double opacity = (offset / 30).clamp(0, 1).toDouble();

      // nestedscrollview中如果list在nestedscrollview中，则无法实现头部弹性放大效果
      // 头部弹性放大效果
      // if (offset < 0) {
      //   // 当向下拉动时，增加图片高度
      //   setState(() {
      //     imageHeight = 850.w - offset; // offset 为负值，所以这里是增加高度
      //   });
      // }

      _checkSticky();

      setState(() {
        _appBarBackgroundColor = Colors.white.withOpacity(opacity);
        if (opacity > 0.5) {
          _iconColor = Colors.black.withOpacity(opacity);
        } else {
          _iconColor = Colors.white;
        }
      });
    });
  }

  _checkSticky() {
    final RenderBox? renderBox =
        stickyKey?.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final postion = renderBox.localToGlobal(Offset.zero).dy;
      // 获取当前状态栏的高度
      final double statusBarHeight = MediaQuery.of(context).padding.top;
      final double headerHeight = statusBarHeight + 120.w;

      if (postion <= headerHeight && !_isPinned) {
        setState(() {
          _isPinned = true;
        });
      } else if (postion > headerHeight && _isPinned) {
        setState(() {
          _isPinned = false;
        });
      }
    }
  }

  @override
  dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取安全区的顶部高度;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double headerHeight = statusBarHeight + 120.w; // 保证header的高度考虑了状态栏的高度
    final useData = HomeController.to.userData.value!;
    final events = controller.ownEvent.value.events;

    return Stack(children: [
      NestedScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                  minHeight: headerHeight,
                  maxHeight: headerHeight,
                  child: _buildHeader(context,
                      headerHeight: headerHeight,
                      statusBarHeight: statusBarHeight)),
            ),
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none, // 确保背景图片超出边界时能正确显示
                children: [
                  // 背景图片
                  Positioned(
                    top: -headerHeight,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: imageHeight,
                      width: double.infinity,
                      child: NeteaseCacheImage(
                          picUrl: useData.profile?.backgroundUrl ?? "",
                          color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                  // 用户信息
                  SizedBox(
                    // 需要覆盖住背景图片的部分
                    height: 851.w - headerHeight,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 530.w,
                            child: HeaderUserInfo(userInfo: useData),
                          ),
                        ),
                        // tabbar view
                        Container(
                          height: 100.w,
                          key: stickyKey,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: _buildTabHeader(context),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [_buildOwnPlayList(context), UserEventWidget(events: events)],
        ),
      ),
      // 吸顶时显示的TabHeader
      if (_isPinned)
        Positioned(
          top: 200.w,
          left: 0,
          right: 0,
          child: Container(
            height: 100.w,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: _buildTabHeader(context), // 你的 TabHeader
          ),
        ),
    ]);
  }

  Widget _buildHeader(BuildContext context,
      {required double headerHeight, required double statusBarHeight}) {
    return Container(
      height: headerHeight,
      // Header 本身的高度，已经由 SliverPersistentHeader 的 minHeight 和 maxHeight 控制
      color: _appBarBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: GestureDetector(
                child: Icon(TablerIcons.menu_2, color: _iconColor),
                onTap: () {
                  HomeController.to.scaffoldKey.value.currentState!
                      .openDrawer();
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: Icon(TablerIcons.search, color: _iconColor),
              onTap: () {
                // Open settings page
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: GestureDetector(
                child: Icon(TablerIcons.dots_vertical, color: _iconColor),
                onTap: () {
                  // Open settings page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: TabBar(
        tabs: TABS.map((e) {
          return Tab(
            text: e,
          );
        }).toList(),
        controller: _tabController,
        labelStyle: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.normal,
        ),
        labelColor: Colors.black,
        dividerHeight: 0,
        unselectedLabelColor: AppTheme.userScrollColor,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.red, width: 2),
          insets: EdgeInsets.symmetric(horizontal: 22),
        ),
      ),
    );
  }

  _buildOwnPlayList(BuildContext context) {
    // 我的歌单
    final myOwnPlayList = MainController.to.ownPlayList.value;
    return myOwnPlayList.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 100.w),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myOwnPlayList.length,
                itemBuilder: (context, index) {
                  return PodcastCell(
                      title: myOwnPlayList[index].name ?? "",
                      artist:
                          '${getFormattedNumber(myOwnPlayList[index].playCount ?? 0)}次播放 · ${myOwnPlayList[index].creator?.nickname ?? ""}首',
                      picUrl: myOwnPlayList[index].coverImgUrl ?? "");
                }));
  }
}
