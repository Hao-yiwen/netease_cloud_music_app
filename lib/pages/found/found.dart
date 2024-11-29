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
import 'package:netease_cloud_music_app/pages/main/shimmer_loading.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';
import 'package:netease_cloud_music_app/widgets/songs_list_widget.dart';
import 'package:netease_cloud_music_app/widgets/play_list_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/constants/app_strings.dart';
import '../../http/api/main/dto/playlist_dto.dart';
import '../../routes/routes.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/shimmer_loading.dart';

@RoutePage()
class Found extends StatefulWidget {
  const Found({super.key});

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> with TickerProviderStateMixin {
  // 控制器
  late final PageController _pageViewController;
  late final TabController _tabController;
  late final TabController _albumTabController;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final EasyRefreshController _refreshController = EasyRefreshController();
  final FoundController controller = FoundController.to;

  // 状态变量
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _pageViewController = PageController();
    _tabController =
        TabController(length: AppStrings.tabTitles.length, vsync: this);
    _albumTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _pageViewController.dispose();
    _tabController.dispose();
    _albumTabController.dispose();
    _refreshController.dispose();
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
            const SizedBox(width: 10),
            _buildMenuButton(),
            const SizedBox(width: 10),
            Expanded(child: _buildTabBar()),
            const SizedBox(width: 10),
            _buildSearchButton(context),
            const SizedBox(width: 10)
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return GestureDetector(
      onTap: () =>
          HomeController.to.scaffoldKey.value.currentState!.openDrawer(),
      child: Icon(TablerIcons.menu_2, size: 40.w),
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 300,
        child: TabBar(
          controller: _tabController,
          dividerHeight: 0,
          labelPadding: EdgeInsets.zero,
          tabs: AppStrings.tabTitles.map((title) => Tab(text: title)).toList(),
          labelStyle: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.normal,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.normal,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: const Color.fromARGB(255, 145, 150, 162),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.red, width: 2),
            insets: EdgeInsets.symmetric(horizontal: 22),
          ),
          onTap: (index) {
            _pageViewController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).pushNamed(Routes.search),
      child: Icon(TablerIcons.search, size: 40.w),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: [
          _buildMusicFound(context),
          _buildMvList(context),
          const Center(child: Text('Timeline')),
          const Center(child: Text('Timeline')),
          const Center(child: Text('Timeline')),
        ],
      ),
    );
  }

  Widget _buildFixTag(BuildContext context) {
    return SizedBox(
      height: 70.w,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    AppStrings.fixTags.map((e) => CustomTag(label: e)).toList(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(TablerIcons.chevron_down, size: 30.w),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

  Widget _buildMusicFound(BuildContext context) {
    return Column(
      children: [
        _buildFixTag(context),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildMusicFoundContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return ShimmerLoading(
      child: Column(
        children: [
          // 轮播图骨架
          Container(
            height: 150.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          // 列表骨架
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  height: 80.w,
                  margin: EdgeInsets.only(bottom: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicFoundContent() {
    return EasyRefresh.builder(
      footer: null,
      key: const Key('found'),
      triggerAxis: Axis.vertical,
      header: const ClassicHeader(
        dragText: AppStrings.dragText,
        armedText: AppStrings.armedText,
        processedText: AppStrings.processedText,
        failedText: AppStrings.failedText,
        noMoreText: AppStrings.noMoreText,
        readyText: AppStrings.readyText,
        messageText: AppStrings.messageText,
      ),
      controller: _refreshController,
      onRefresh: () async => controller.refreshHome(),
      onLoad: null,
      childBuilder: (context, physics) {
        return Obx(() {
          if (controller.loading.value) {
            return _buildShimmerLoading();
          }

          return CustomScrollView(
            physics: physics,
            slivers: [
              if (controller.banner.value?.banners != null)
                _buildCarousel(context),
              if (controller.homeBlock.value.blocks?.isNotEmpty ?? false)
                _buildFoundContent(controller.homeBlock.value.blocks!, context),
              if (MainController.to.topPlayList.value.isNotEmpty)
                _buildPlayList(context, AppStrings.selectedPlaylist,
                    MainController.to.topPlayList.value),
            ],
          );
        });
      },
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return SliverToBoxAdapter(
      child: CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
          height: 150.0,
          viewportFraction: 1.0,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, _) {
            setState(() => _currentCarouselIndex = index);
          },
        ),
        items: controller.banner.value.banners!.map((banner) {
          return Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => WidgetUtil.showToast(AppStrings.waitDevelop),
                child: Container(
                  width: ScreenUtil().screenWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(banner.pic!),
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
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlayList(
      BuildContext context, String title, List<Playlist> playLists) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PlayListCard(
            playList: playLists,
            onTapItemIndex: (index) async {
              GetIt.instance<AppRouter>().push(
                SongsList(id: playLists[index].id!),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFoundContent(List<BlockItem> items, BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: items.map((item) {
          final type = ItemTypeEnum.values.firstWhere(
              (e) => e.value == item.showType,
              orElse: () => ItemTypeEnum.HOMEPAGE_SLIDE_PLAYLIST // 默认类型
              );
          switch (type) {
            case ItemTypeEnum.HOMEPAGE_NEW_SONG_NEW_ALBUM:
              return _buildNewSongNewAlbum(item, context);
            case ItemTypeEnum.HOMEPAGE_SLIDE_LISTEN_LIVE:
              return _buildListenLive(item, context);
            case ItemTypeEnum.HOMEPAGE_SLIDE_PLAYLIST:
              return _buildPlayListSlide(item, context);
            case ItemTypeEnum.HOMEPAGE_SLIDE_SONGLIST_ALIGN:
              return _buildSongListAlign(item, context);
            case ItemTypeEnum.SHUFFLE_MUSIC_CALENDAR:
              return _buildShuffleMusicCalendar(item, context);
            default:
              return Container();
          }
        }).toList(),
      ),
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
              labelStyle: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.normal,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: const Color.fromARGB(255, 145, 150, 162),
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: const [Text(AppStrings.newSong), Text(AppStrings.newAlbum)],
            ),
          ),
          SizedBox(height: 10.w),
          Expanded(
            child: TabBarView(
              controller: _albumTabController,
              children: [
                SongsListWidget(songs: controller.newSong.value),
                SongsListWidget(songs: controller.newAlbum),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListenLive(BlockItem item, BuildContext context) {
    return Container();
  }

  Widget _buildPlayListSlide(BlockItem item, BuildContext context) {
    if (item.creatives == null || item.creatives!.isEmpty) {
      return Container();
    }

    return Container(
      height: 360.w,
      padding: EdgeInsets.only(top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreativeTitle(item, context),
          SizedBox(height: 20.w),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.creatives!.length,
              itemBuilder: (context, index) {
                final creative = item.creatives![index];
                if (creative.uiElement?.image?.imageUrl == null ||
                    creative.uiElement?.mainTitle?.title == null ||
                    creative.resources == null ||
                    creative.resources!.isEmpty ||
                    creative.resources![0]?.resourceId == null) {
                  return Container();
                }

                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: SongCard(
                    picUrl: creative.uiElement!.image!.imageUrl!,
                    title: creative.uiElement!.mainTitle!.title!,
                    onTapItem: () async {
                      GetIt.instance<AppRouter>().push(
                        SongsList(
                            id: int.parse(creative.resources![0]!.resourceId!)),
                      );
                    },
                  ),
                );
              },
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
          SizedBox(height: 10.w),
          SongsListWidget(songs: controller.slideSongListAlign.value),
        ],
      ),
    );
  }

  Widget _buildCreativeTitle(BlockItem item, BuildContext context) {
    if (item.uiElement?.mainTitle?.title?.isNotEmpty ?? false) {
      return Text(
        item.uiElement!.mainTitle!.title!,
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (item.uiElement?.subTitle?.title?.isNotEmpty ?? false) {
      return Text(
        item.uiElement!.subTitle!.title!,
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return Container();
  }

  Widget _buildShuffleMusicCalendar(BlockItem item, BuildContext context) {
    if (item.creatives == null) return Container();

    final resources = item.creatives!
        .where((e) => e.resources != null)
        .expand((e) => e.resources!)
        .where((r) => r != null)
        .toList();

    if (resources.isEmpty) return Container();

    return Container(
      padding: EdgeInsets.only(top: 20.w),
      height: 230.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreativeTitle(item, context),
          SizedBox(height: 10.w),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: resources.length,
              itemBuilder: (context, index) {
                final resource = resources[index];
                if (resource.uiElement?.mainTitle?.title == null ||
                    resource.uiElement?.image?.imageUrl == null) {
                  return Container();
                }

                return Container(
                  padding: EdgeInsets.only(bottom: 20.w),
                  height: 120.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          resource.uiElement!.mainTitle!.title!,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.w),
                        child: NeteaseCacheImage(
                          picUrl: resource.uiElement!.image!.imageUrl!,
                          size: Size(100.w, 100.w),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMvList(BuildContext context) {
    return EasyRefresh.builder(
      footer: null,
      key: const Key('found'),
      triggerAxis: Axis.vertical,
      header: const ClassicHeader(
        dragText: AppStrings.dragText,
        armedText: AppStrings.armedText,
        processedText: AppStrings.processedText,
        failedText: AppStrings.failedText,
        noMoreText: AppStrings.noMoreText,
        readyText: AppStrings.readyText,
        messageText: AppStrings.messageText,
      ),
      controller: _refreshController,
      onRefresh: () async => controller.refreshMv(),
      onLoad: null,
      childBuilder: (context, physics) {
        return Obx(() {
          if (controller.loading.value) {
            return ListView.builder(
              physics: physics,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.w),
                  child: ShimmerLoading(
                    child: ListTile(
                      leading: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                      title: Container(
                        height: 32.w,
                        width: 400.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                      subtitle: Container(
                        height: 28.w,
                        width: 3000.w,
                        margin: EdgeInsets.only(top: 8.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return ListView.builder(
            physics: physics,
            itemCount: controller.mvList.value.data?.length ?? 0,
            itemBuilder: (context, index) {
              final mv = controller.mvList.value.data![index];
              return Padding(
                padding: EdgeInsets.only(top: 20.w),
                child: GestureDetector(
                  onTap: () {
                    GetIt.instance<AppRouter>().push(
                      MvPlayer(
                        title: mv.name!,
                        id: mv.id!,
                        artist: mv.artistName!,
                      ),
                    );
                  },
                  child: ListTile(
                    leading: NeteaseCacheImage(picUrl: mv.cover!),
                    title: Text(
                      mv.name!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    subtitle: Text(
                      mv.artistName!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
