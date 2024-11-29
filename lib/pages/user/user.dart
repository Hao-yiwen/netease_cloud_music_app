import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';
import 'package:netease_cloud_music_app/pages/user/widgets/header_user_info.dart';
import 'package:netease_cloud_music_app/pages/user/widgets/sliver_header_delegate.dart';
import 'package:netease_cloud_music_app/widgets/songs_list_widget.dart';

import '../../routes/routes.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/netease_cache_image.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/user_event_widget.dart';
import 'constrants.dart';

@RoutePage()
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with TickerProviderStateMixin {
  final UserController _controller = UserController.to;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _stickyKey = GlobalKey();

  late TabController _tabController;
  late PageController _pageViewController;

  Color _appBarBackgroundColor = Colors.transparent;
  Color _iconColor = Colors.white;
  double _imageHeight = 850.w;
  bool _isPinned = false;

  String _formatNumber(int number) {
    if (number < 10000) {
      return number.toString();
    } else if (number < 100000000) {
      final result = number / 10000;
      return '${result.toStringAsFixed(1)}万';
    } else {
      final result = number / 100000000;
      return '${result.toStringAsFixed(1)}亿';
    }
  }

  void _checkSticky() {
    final renderBox =
        _stickyKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero).dy;
      final statusBarHeight = MediaQuery.of(context).padding.top;
      final headerHeight = statusBarHeight + 120.w;

      setState(() {
        _isPinned = position <= headerHeight;
      });
    }
  }

  void _handleScroll() {
    final offset = _scrollController.offset;
    final opacity = (offset / 30).clamp(0, 1).toDouble();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    _checkSticky();

    setState(() {
      _appBarBackgroundColor =
          (isDark ? Colors.grey[900]! : Colors.white).withOpacity(opacity);
      _iconColor = opacity > 0.5
          ? (isDark ? Colors.white : Colors.black).withOpacity(opacity)
          : Colors.white;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TABS.length, vsync: this);
    _pageViewController = PageController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final headerHeight = statusBarHeight + 120.w;
    final userData = HomeController.to.userData.value!;
    final events = _controller.ownEvent.value.events;

    return Stack(
      children: [
        NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                minHeight: headerHeight,
                maxHeight: headerHeight,
                child: _buildHeader(
                  headerHeight: headerHeight,
                  statusBarHeight: statusBarHeight,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -headerHeight,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: _imageHeight,
                      width: double.infinity,
                      child: NeteaseCacheImage(
                        picUrl: userData.profile?.backgroundUrl ?? "",
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 851.w - headerHeight,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 530.w,
                            child: HeaderUserInfo(userInfo: userData),
                          ),
                        ),
                        Container(
                          height: 100.w,
                          key: _stickyKey,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: _buildTabHeader(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildOwnPlayList(),
              UserEventWidget(events: events),
            ],
          ),
        ),
        if (_isPinned)
          Positioned(
            top: 200.w,
            left: 0,
            right: 0,
            child: Container(
              height: 100.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: _buildTabHeader(),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader({
    required double headerHeight,
    required double statusBarHeight,
  }) {
    return Container(
      height: headerHeight,
      color: _appBarBackgroundColor,
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: GestureDetector(
              onTap: () => HomeController.to.scaffoldKey.value.currentState!
                  .openDrawer(),
              child: Icon(TablerIcons.menu_2, color: _iconColor),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => AutoRouter.of(context).pushNamed(Routes.search),
            child: Icon(TablerIcons.search, color: _iconColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Icon(TablerIcons.dots_vertical, color: _iconColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTabHeader() {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: 20.w),
        child: TabBar(
          tabs: TABS.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
          labelStyle: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.normal,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.normal,
          ),
          labelColor: theme.colorScheme.onPrimary,
          dividerHeight: 0,
          unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(0.5),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.red, width: 2),
            insets: EdgeInsets.symmetric(horizontal: 22),
          ),
        ),
      ),
    );
  }

  Widget _buildOwnPlayList() {
    return Obx(() {
      final myOwnPlayList = MainController.to.ownPlayList.value;

      if (myOwnPlayList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 100.w),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: ShimmerLoading(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30.w,
                              width: 300.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                            ),
                            SizedBox(height: 10.w),
                            Container(
                              height: 24.w,
                              width: 250.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myOwnPlayList.length,
          itemBuilder: (context, index) {
            final playlist = myOwnPlayList[index];
            return PodcastCell(
              title: playlist.name ?? "",
              artist:
                  '${_formatNumber(playlist.playCount ?? 0)}次播放 · ${playlist.creator?.nickname ?? ""}首',
              picUrl: playlist.coverImgUrl ?? "",
              onTapItem: () async {
                GetIt.instance<AppRouter>().push(SongsList(id: playlist.id!));
              },
            );
          },
        ),
      );
    });
  }
}
