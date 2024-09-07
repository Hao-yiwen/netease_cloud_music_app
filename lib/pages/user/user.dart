import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/user/user_controller.dart';

import '../../common/constants/location_map.dart';
import '../../common/utils/birthday.dart';
import '../../http/api/login/dto/login_status_dto.dart';
import '../../widgets/netease_cache_image.dart';

@RoutePage()
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _MineState();
}

class _MineState extends State<User> with TickerProviderStateMixin {
  final UserController controller = UserController.to;
  ScrollController _scrollController = ScrollController();
  Color _appBarBackgroundColor = Colors.transparent;
  Color _iconColor = Colors.white;
  double imageHeight = 850.w;

  // tabcontroller
  late TabController _tabController;
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageViewController = PageController();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double opacity = (offset / 30).clamp(0, 1).toDouble();

      if (offset < 0) {
        // 当向下拉动时，增加图片高度
        setState(() {
          imageHeight = 850.w - offset; // offset 为负值，所以这里是增加高度
        });
      }

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

    return NestedScrollView(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverHeaderDelegate(
                minHeight: headerHeight, // 最小高度包含状态栏高度
                maxHeight: headerHeight, // 最大高度同样包含状态栏高度
                child: _buildHeader(context,
                    headerHeight: headerHeight,
                    statusBarHeight: statusBarHeight)),
          ),
          SliverToBoxAdapter(
              child: Stack(
            children: [
              Transform.translate(
                offset: Offset(0, -((imageHeight - 850.w) + headerHeight)),
                child: SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: NeteaseCacheImage(
                      picUrl: useData.profile?.backgroundUrl ?? "",
                    )),
              ),
              Column(
                children: [
                  Container(
                    height: 700.w,
                    child: _buildUserInfo(context, useData),
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
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: '音乐'),
                              Tab(text: '博客'),
                              Tab(text: '直播'),
                            ],
                            controller: _tabController,
                            dividerHeight: 0,
                            labelStyle: TextStyle(
                              fontSize: 32.sp, // 选中的字体大小
                              fontWeight: FontWeight.normal, // 选中的字体加粗
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 32.sp, // 未选中的字体大小
                              fontWeight: FontWeight.normal, // 未选中的字体常规
                            ),
                            labelColor: Colors.black,
                            unselectedLabelColor:
                                Color.fromARGB(255, 145, 150, 162),
                            indicator: UnderlineTabIndicator(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                              insets: EdgeInsets.symmetric(
                                  horizontal: 22), // 控制指示器的宽度
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(
              title: Text('Item $index'),
            ),
          ),
          Center(child: Text('Tab 2 Content')),
          Center(child: Text('Tab 3 Content')),
        ],
      ),
    );
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
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(TablerIcons.menu_2, color: _iconColor),
              onTap: () {
                HomeController.to.scaffoldKey.value.currentState!.openDrawer();
              },
            ),
            Expanded(child: Container()),
            GestureDetector(
              child: Icon(TablerIcons.search, color: _iconColor),
              onTap: () {
                // Open settings page
              },
            ),
            SizedBox(width: 22),
            GestureDetector(
              child: Icon(TablerIcons.dots_vertical, color: _iconColor),
              onTap: () {
                // Open settings page
              },
            ),
            SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _buildUserInfo(BuildContext context, LoginStatusDto userInfo) {
    return Column(
      children: [
        // avatar
        Container(
          height: 80, // 这里的高度和宽度比图片的尺寸略大，以确保边框显示在外面
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2), // 边框
          ),
          child: ClipOval(
            child: NeteaseCacheImage(
                picUrl: userInfo.profile?.avatarUrl ?? "", size: const Size(80, 80)),
          ),
        ),
        // nickname
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userInfo.profile?.nickname ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Image.asset(ImageUtils.getImagePath('vip_tag'), width: 60),
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Text(
          userInfo.profile?.signature ?? "",
          style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
        ),
        SizedBox(
          height: 15.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              TablerIcons.medal,
              color: Colors.grey[200],
              size: 30.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "12枚徽章",
              style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              "|",
              style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            if (userInfo.profile?.province != null &&
                provinceMap[userInfo.profile?.province.toString()] != null)
              Row(
                children: [
                  Text(
                    provinceMap[userInfo.profile?.province.toString()]!,
                    style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "·",
                    style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
                  ),
                ],
              ),
            if (userInfo.profile?.gender != null &&
                userInfo.profile?.birthday != null)
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Icon(
                    userInfo.profile!.gender == GENDER_STATUS.MEAL.value
                        ? TablerIcons.gender_male
                        : TablerIcons.gender_female,
                    color: userInfo.profile!.gender == GENDER_STATUS.MEAL.value
                        ? Colors.blue[200]
                        : Colors.pink[200],
                    size: 30.w,
                  ),
                  Text(
                    "${getGenerationLabel(calculateBirthYear(userInfo.profile!.birthday.toString()))} ${calculateZodiacSign(userInfo.profile!.birthday.toString())}",
                    style: TextStyle(color: Colors.grey[200], fontSize: 22.sp),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
          ],
        ),
        Obx(() {
          return Visibility(
            visible: controller.loding.value == false &&
                controller.userAccount.value.profile != null,
            child: Column(
              children: [
                SizedBox(
                  height: 25.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.userAccount.value.profile?.follows} 关注",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "${controller.userAccount.value.profile?.followeds} 粉丝",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Lv.${controller.userAccount.value.level}等级",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "听过 ${controller.userAccount.value.listenSongs} 首歌",
                      style:
                          TextStyle(color: Colors.grey[200], fontSize: 24.sp),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        SizedBox(
          height: 40.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBoxInfo(
              title: "动态",
              icon: TablerIcons.clock_hour_3_filled,
            ),
            SizedBox(
              width: 10.w,
            ),
            _buildBoxInfo(
              title: "本地",
              icon: TablerIcons.square_arrow_down_filled,
            ),
            SizedBox(
              width: 10.w,
            ),
            _buildBoxInfo(
              title: "云盘",
              icon: TablerIcons.cloud_upload,
            ),
            SizedBox(
              width: 10.w,
            ),
            _buildBoxInfo(
              title: "已购",
              icon: TablerIcons.brand_shopee,
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        )
      ],
    );
  }

  _buildBoxInfo({required String title, required IconData icon}) {
    return Container(
      height: 65.w,
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 34.w,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 26.sp),
          )
        ],
      ),
    );
  }

  _buildPageViewContent() {
    return Container(
      child: Center(
        child: Text('Roaming'),
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
