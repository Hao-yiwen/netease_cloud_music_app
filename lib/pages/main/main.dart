import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/app_strings.dart';
import 'package:netease_cloud_music_app/pages/main/constants.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/widgets/shimmer_loading.dart';
import 'package:netease_cloud_music_app/pages/main/widgets/custom_refresh_header.dart';
import 'package:netease_cloud_music_app/pages/main/widgets/search_bar_widget.dart';
import 'package:netease_cloud_music_app/routes/routes.gr.dart';

import '../../routes/routes.dart';
import '../../widgets/song_card.dart';
import '../../widgets/songs_list_widget.dart';
import '../../widgets/play_list_card.dart';
import '../home/home_controller.dart';
import '../roaming/roaming.dart';

@RoutePage()
class Main extends GetView<MainController> {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(context),
          _buildMainContent(context),
        ],
      ),
    );
  }

  Widget _buildSongsListSection(String title, List<MediaItem> songs) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionTitle(title),
          SongsListWidget(songs: songs),
        ],
      ),
    );
  }

  Widget _buildProgramsListSection() {
    final programs = controller.personalizedDjprogramDto.value?.result ?? [];
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionTitle(AppStrings.selectedPodcastsForYou),
          PodcastListWidget(programs: programs),
        ],
      ),
    );
  }

  Widget _buildRecommendPlayListSection() {
    final playlists = controller.recommendResourceDto.value?.recommend ?? [];
    final title =
        '${HomeController.to.userData.value.profile?.nickname ?? ""}${AppStrings.radarPlaylist}';

    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionTitle(title),
          RecommendPlayListCard(
            recommendPlayList: playlists,
            onTapItemIndex: _handlePlaylistTap,
          ),
        ],
      ),
    );
  }

  Widget _buildPlayListSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionTitle(AppStrings.myPlaylist),
          PlayListCard(
            playList: controller.ownPlayList.value,
            onTapItemIndex: _handleOwnPlaylistTap,
          ),
        ],
      ),
    );
  }

  Future<void> _handlePlaylistTap(int index) async {
    final playlist = controller.recommendResourceDto.value?.recommend?[index];
    if (playlist == null) return;
    _navigateToSongsList(playlist.id!);
  }

  Future<void> _handleOwnPlaylistTap(int index) async {
    final playlist = controller.ownPlayList.value[index];
    _navigateToSongsList(playlist.id!);
  }

  void _navigateToSongsList(int id) {
    GetIt.instance<AppRouter>().push(SongsList(id: id));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      height: MainConstants.headerHeight.w,
      child: Row(
        children: [
          _buildMenuButton(),
          const SizedBox(width: 10),
          Expanded(child: _buildSearchBar(context)),
          const SizedBox(width: 10),
          _buildMicButton(),
        ],
      ),
    );
  }

  Widget _buildMenuButton() => GestureDetector(
        onTap: () =>
            HomeController.to.scaffoldKey.value.currentState?.openDrawer(),
        child: Icon(TablerIcons.menu_2, size: 40.w),
      );

  Widget _buildMicButton() => Icon(TablerIcons.microphone, size: 40.w);

  Widget _buildSearchBar(BuildContext context) => SearchBarWidget(
        onTap: () => AutoRouter.of(context).pushNamed(Routes.search),
      );

  Widget _buildSkeletonEveryDayRecommendSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonSectionTitle(context),
          SizedBox(
            height: MainConstants.cardHeight.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: _buildSkeletonCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

// 修改现有骨架屏组件，添加ShimmerLoading
  Widget _buildSkeletonCard() {
    return ShimmerLoading(
      child: Container(
        width: 250.w,
        height: MainConstants.cardHeight.w,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 120.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Container(
                width: 180.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonSongsListSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonSectionTitle(context),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 15,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 15.w),
                child: ShimmerLoading(
                  child: Container(
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonSectionTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Container(
        width: 160.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return Expanded(
          child: CustomScrollView(
            slivers: [
              _buildSkeletonEveryDayRecommendSection(context), // 水平滚动卡片骨架屏
              _buildSkeletonSongsListSection(context), // 垂直列表骨架屏
              SliverPadding(padding: EdgeInsets.only(bottom: 100.w)),
            ],
          ),
        );
      }
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: _buildRefreshableContent(context),
        ),
      );
    });
  }

  Widget _buildRefreshableContent(BuildContext context) {
    return EasyRefresh.builder(
      header: const CustomRefreshHeader(),
      onRefresh: () => controller.refreshMainPage(),
      childBuilder: (context, physics) {
        return Obx(() => _buildSliverList(context, physics));
      },
    );
  }

  Widget _buildSliverList(BuildContext context, ScrollPhysics physics) {
    return CustomScrollView(
      physics: physics,
      slivers: [
        _buildEveryDayRecommendSection(context),
        if (_shouldShowSimilarSongs())
          _buildSongsListSection(AppStrings.similarSongsRecommendation,
              controller.similarSongs.value),
        if (_shouldShowRandomPlaylist())
          _buildSongsListSection(controller.randomPlaylist.value.name ?? '',
              controller.randomPlaylistSongs.value),
        if (_shouldShowPrograms()) _buildProgramsListSection(),
        if (_shouldShowRecommendedPlaylists()) _buildRecommendPlayListSection(),
        if (controller.ownPlayList.value.isNotEmpty) _buildPlayListSection(),
        SliverPadding(padding: EdgeInsets.only(bottom: 100.w)),
      ],
    );
  }

  bool _shouldShowSimilarSongs() {
    return controller.similarSongs.value.isNotEmpty &&
        controller.personalFmSongs.value.isNotEmpty;
  }

  bool _shouldShowRandomPlaylist() {
    return controller.personalFmSongs.value.isNotEmpty &&
        controller.privateRadarSongs.value.isNotEmpty;
  }

  bool _shouldShowPrograms() {
    return controller.personalFmSongs.value.isNotEmpty &&
        controller.privateRadarSongs.value.isNotEmpty;
  }

  bool _shouldShowRecommendedPlaylists() {
    return controller.recommendResourceDto.value?.recommend != null;
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: MainConstants.sectionPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: MainConstants.titleStyle),
      ),
    );
  }

  Widget _buildEveryDayRecommendSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(_getCurrentTime()),
          SizedBox(
            height: MainConstants.cardHeight.w,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (_hasRecommendSongs()) _buildDailyRecommendCard(),
                if (controller.personalFmSongs.value.isNotEmpty)
                  _buildPersonalFmCard(context),
                if (controller.privateRadarSongs.value.isNotEmpty)
                  _buildPrivateRadarCard(),
                if (controller.similarSongs.value.isNotEmpty)
                  _buildSimilarSongsCard(context),
                if (_hasPrograms()) _buildProgramsCard(context),
              ]
                  .map((card) => Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: card,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  bool _hasRecommendSongs() {
    return controller.recommendSongsDto.value.dailySongs?.isNotEmpty ?? false;
  }

  bool _hasPrograms() {
    return controller.personalizedDjprogramDto.value?.result?.isNotEmpty ??
        false;
  }

  Widget _buildDailyRecommendCard() {
    return MusicCard(
      title: AppStrings.dailyRecommend,
      subTitle: AppStrings.freshSongsForYourTaste,
      icon: TablerIcons.calendar,
      cardPic: controller.dailySongs[0].extras?['image'] ?? '',
      onTapHandle: () => _navigateToSongsList(
        controller.dailySongs[0].id! as int,
      ),
    );
  }

  Widget _buildPersonalFmCard(BuildContext context) {
    return MusicCard(
      title: AppStrings.personalRoaming,
      subTitle: AppStrings.multiplePlayModes,
      icon: TablerIcons.radio,
      cardPic: controller.personalFmSongs.value[0].extras?['image'] ?? '',
      onTapHandle: () => Roaming.showBottomPlayer(context),
    );
  }

  Widget _buildPrivateRadarCard() {
    return MusicCard(
      title: AppStrings.privateRadar,
      subTitle: AppStrings.worthRepeatedListening,
      icon: TablerIcons.radio,
      cardPic: controller.privateRadarSongs.value[0].extras?['image'] ?? '',
      onTapHandle: () => _navigateToSongsList(
        controller.privateRadarSongs.value[0].id! as int,
      ),
    );
  }

  Widget _buildSimilarSongsCard(BuildContext context) {
    return MusicCard(
      title: AppStrings.similarSongs,
      subTitle: AppStrings.startFromYourFavorites,
      cardPic: controller.similarSongs.value[0].extras?['image'] ?? '',
      onTapHandle: () => Roaming.showBottomPlayer(context),
    );
  }

  Widget _buildProgramsCard(BuildContext context) {
    final program = controller.personalizedDjprogramDto.value?.result?.first;
    return MusicCard(
      title: AppStrings.musicPodcast,
      subTitle: program?.name ?? "",
      cardPic: program?.picUrl ?? "",
      onTapHandle: () => Roaming.showBottomPlayer(context),
    );
  }

  String _getCurrentTime() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) return AppStrings.goodMorning;
    if (hour >= 12 && hour < 18) return AppStrings.goodAfternoon;
    if (hour >= 18 && hour < 24) return AppStrings.goodEvening;
    return AppStrings.lateNight;
  }
}
