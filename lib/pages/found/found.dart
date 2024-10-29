import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/http/api/found/dto/home_block.dart';
import 'package:netease_cloud_music_app/pages/found/found_controller.dart';
import 'package:netease_cloud_music_app/pages/found/item_type.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';
import 'package:netease_cloud_music_app/widgets/songs_list_widget.dart';
import 'package:netease_cloud_music_app/widgets/play_list_card.dart';

import '../../common/constants/app_strings.dart';
import '../../http/api/main/dto/playlist_dto.dart';
import '../../routes/routes.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/custom_tag.dart';

@RoutePage()
class Found extends StatefulWidget {
  const Found({super.key});

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentCarouselIndex = 0;
  final FoundController controller = FoundController.to;
  late TabController _albumTabController;
  final EasyRefreshController _refreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 5, vsync: this);
    _albumTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
    _albumTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildPageView(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 70.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                HomeController.to.scaffoldKey.value.currentState!.openDrawer();
              },
              child: Icon(
                TablerIcons.menu_2,
                size: 40.w,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              // 明确设置SingleChildScrollView的高度
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 300,
                  child: TabBar(
                    controller: _tabController,
                    dividerHeight: 0,
                    labelPadding: EdgeInsets.zero,
                    tabs: const [
                      Tab(text: '音乐'),
                      Tab(text: 'MV'),
                      Tab(text: '直播'),
                      Tab(text: '听书'),
                      Tab(text: '派对'),
                    ],
                    labelStyle: TextStyle(
                      fontSize: 32.sp, // 选中的字体大小
                      fontWeight: FontWeight.normal, // 选中的字体加粗
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 32.sp, // 未选中的字体大小
                      fontWeight: FontWeight.normal, // 未选中的字体常规
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Color.fromARGB(255, 145, 150, 162),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 22), // 控制指示器的宽度
                    ),
                    onTap: (index) {
                      _pageViewController.animateToPage(index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                AutoRouter.of(context).pushNamed(Routes.search);
              },
              child: Icon(
                TablerIcons.search,
                size: 40.w,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _tabController.animateTo(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          _buildMusicFound(context),
          _buildMvList(context),
          const Center(
            child: Text('Timeline'),
          ),
          const Center(
            child: Text('Timeline'),
          ),
          const Center(
            child: Text('Timeline'),
          ),
        ],
      ),
    );
  }

  Widget _buildFixTag(BuildContext context) {
    return Container(
      height: 70.w,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                "推荐",
                "歌单",
                "排行榜",
                "电台",
                "直播",
                "数字专辑",
                "歌手",
                "新碟上架",
                "MV"
              ].map((e) => CustomTag(label: e)).toList(),
            ),
          )),
          const SizedBox(
            width: 10,
          ),
          Icon(
            TablerIcons.chevron_down,
            size: 30.w,
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Widget _buildMusicFound(BuildContext context) {
    return Column(
      children: [
        _buildFixTag(context),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          // 嵌套滚动要用EasyRefresh.builder
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: EasyRefresh.builder(
              footer: null,
              key: const Key('found'),
              triggerAxis: Axis.vertical,
              header: const ClassicHeader(
                dragText: "下拉刷新",
                armedText: "释放刷新",
                processedText: "刷新完成",
                failedText: "刷新失败",
                noMoreText: "没有更多数据",
                readyText: "正在刷新...",
                messageText: "上次刷新时间 %T",
              ),
              controller: _refreshController,
              onRefresh: () async {
                controller.refreshHome();
              },
              onLoad: () async {},
              childBuilder: (BuildContext context, ScrollPhysics physics) {
                return Obx(() {
                  return CustomScrollView(
                    scrollDirection: Axis.vertical,
                    physics: physics,
                    slivers: [
                      if (controller.banner.value != null &&
                          controller.banner.value!.banners != null)
                        _buildCarousel(context),
                      if (controller.homeBlock.value.blocks != null &&
                          controller.homeBlock.value.blocks!.isNotEmpty)
                        _buildFoundContent(
                            controller.homeBlock.value.blocks!, context),
                      if (MainController.to.topPlayList.value.isNotEmpty)
                        _buildPlayList(context, '甄选歌单',
                            MainController.to.topPlayList.value),
                    ],
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildCarousel(BuildContext context) {
    return SliverToBoxAdapter(
        child: CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
          height: 150.0,
          viewportFraction: 1.0,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              _currentCarouselIndex = index;
            });
          }),
      items: controller.banner.value.banners!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                WidgetUtil.showToast(AppStrings.waitDevelop);
              },
              child: Container(
                  width: ScreenUtil().screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NeteaseCacheImage(picUrl: i.pic!)
                                  .getImageProvider(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2, left: 4),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: DotsIndicator(
                              dotsCount:
                                  controller.banner.value.banners!.length,
                              position: _currentCarouselIndex,
                              decorator: DotsDecorator(
                                activeColor: Colors.red,
                                size: const Size.square(6.0),
                                activeSize: const Size.square(6.0),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      }).toList(),
    ));
  }

  _buildPlayList(BuildContext context, String title, List<Playlist> playLists) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
            ),
          ),
          PlayListCard(
              playList: playLists,
              onTapItemIndex: (index) async {
                final lists = await MainController.to
                    .getPlayListDetail(playLists[index].id!);
                GetIt.instance<AppRouter>().push(SongsList(
                    songs: lists,
                    title: playLists[index].name!,
                    picUrl: playLists[index].coverImgUrl!));
              })
        ],
      ),
    );
  }

  _buildFoundContent(List<BlockItem> items, BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
          children: items.map((item) {
        if (item.showType == ItemTypeEnum.HOMEPAGE_NEW_SONG_NEW_ALBUM.value) {
          return _buildNewSongNewAlbum(item, context);
        } else if (item.showType ==
            ItemTypeEnum.HOMEPAGE_SLIDE_LISTEN_LIVE.value) {
          return _buildListenLive(item, context);
        } else if (item.showType ==
            ItemTypeEnum.HOMEPAGE_SLIDE_PLAYLIST.value) {
          return _buildPlayListSlide(item, context);
        } else if (item.showType ==
            ItemTypeEnum.HOMEPAGE_SLIDE_SONGLIST_ALIGN.value) {
          return _buildSongListAlign(item, context);
        } else if (item.showType == ItemTypeEnum.SHUFFLE_MUSIC_CALENDAR.value) {
          return _buildShuffleMusicCalendar(item, context);
        } else {
          return Container();
        }
      }).toList()),
    );
  }

  Widget _buildNewSongNewAlbum(BlockItem item, BuildContext context) {
    return Container(
      height: 450.w,
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              controller: _albumTabController,
              dividerHeight: 0,
              labelPadding: EdgeInsets.only(left: 0.w, right: 20.w),
              // 移除左侧的额外padding
              labelStyle: TextStyle(
                fontSize: 32.sp, // 选中的字体大小
                fontWeight: FontWeight.normal, // 选中的字体加粗
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 30.sp, // 未选中的字体大小
                fontWeight: FontWeight.normal, // 未选中的字体常规
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Color.fromARGB(255, 145, 150, 162),
              indicatorColor: Colors.transparent,
              // 取消进度条
              isScrollable: true,
              // 允许Tab根据内容自适应宽度
              tabs: const [
                Text("新歌"), // 直接使用Text即可，IntrinsicWidth不再必要
                Text("新碟"),
              ],
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Expanded(
            child: TabBarView(
              controller: _albumTabController,
              children: [
                SongsListWidget(
                  songs: controller.newSong.value,
                ),
                SongsListWidget(songs: controller.newAlbum)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListenLive(BlockItem item, BuildContext context) {
    return Container();
  }

  Widget _buildPlayListSlide(BlockItem item, BuildContext context) {
    return Container(
      height: 360.w,
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreativeTitle(item, context),
          SizedBox(
            height: 20.w,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: SongCard(
                    picUrl: item.creatives![index].uiElement!.image!.imageUrl!,
                    title: item.creatives![index].uiElement!.mainTitle!.title!,
                    onTapItem: () async {
                      final lists = await MainController.to.getPlayListDetail(
                          int.parse(item
                              .creatives![index].resources![0]!.resourceId!));
                      GetIt.instance<AppRouter>().push(SongsList(
                          songs: lists,
                          title: item
                              .creatives![index].uiElement!.mainTitle!.title!,
                          picUrl: item
                              .creatives![index].uiElement!.image!.imageUrl!));
                    },
                  ),
                );
              },
              itemCount: item.creatives!.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongListAlign(BlockItem item, BuildContext context) {
    return Container(
      height: 450.w,
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreativeTitle(item, context),
          SizedBox(
            height: 10.w,
          ),
          SongsListWidget(songs: controller.slideSongListAlign.value),
        ],
      ),
    );
  }

  _buildCreativeTitle(BlockItem item, BuildContext context) {
    return Text(
      item.uiElement!.mainTitle!.title!.isNotEmpty
          ? item.uiElement!.mainTitle!.title!
          : (item.uiElement!.subTitle!.title!.isNotEmpty
              ? item.uiElement!.subTitle!.title!
              : ""),
      style: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildShuffleMusicCalendar(BlockItem item, BuildContext context) {
    final creatives = item.creatives!;
    var res = [];
    for (var el in creatives) {
      for (var al in el.resources!) {
        res.add(al);
      }
    }
    return Container(
      padding: EdgeInsets.only(top: 20.w),
      height: 230.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreativeTitle(item, context),
          SizedBox(
            height: 10.w,
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 20.w),
                  height: 120.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          res[index].uiElement!.mainTitle!.title!,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: NeteaseCacheImage(
                          picUrl: res[index].uiElement!.image!.imageUrl!,
                          size: Size(100.w, 100.w),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: res.length,
            ),
          ),
        ],
      ),
    );
  }

  _buildMvList(BuildContext context) {
    return EasyRefresh.builder(
        footer: null,
        key: const Key('found'),
        triggerAxis: Axis.vertical,
        header: const ClassicHeader(
          dragText: "下拉刷新",
          armedText: "释放刷新",
          processedText: "刷新完成",
          failedText: "刷新失败",
          noMoreText: "没有更多数据",
          readyText: "正在刷新...",
          messageText: "上次刷新时间 %T",
        ),
        controller: _refreshController,
        onRefresh: () async {
          controller.refreshMv();
        },
        onLoad: () async {},
        childBuilder: (BuildContext context, ScrollPhysics physics) {
          return ListView.builder(
            physics: physics,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 20.w),
                child: GestureDetector(
                  onTap: () {
                    GetIt.instance<AppRouter>().push(MvPlayer(
                      title: controller.mvList.value.data![index].name!,
                      id: controller.mvList.value.data![index].id!,
                      artist: controller.mvList.value.data![index].artistName!,
                    ));
                  },
                  child: ListTile(
                    leading: NeteaseCacheImage(
                        picUrl: controller.mvList.value.data![index].cover!),
                    title: Text(
                      controller.mvList.value.data![index].name!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    subtitle: Text(
                      controller.mvList.value.data![index].artistName!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.mvList.value.data?.length ?? 0,
          );
        });
  }
}
