import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/personalized_djprogram_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/playlist_dto.dart';
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_resource_dto.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
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
      child: (Column(
        children: [_buildHeader(context), _buildContent(context)],
      )),
    );
  }

  _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
      child: SizedBox(
        height: 70.w,
        child: (Row(
          children: [
            GestureDetector(
              child: Icon(
                TablerIcons.menu_2,
                size: 40.w,
              ),
              onTap: () {
                HomeController.to.scaffoldKey.value.currentState?.openDrawer();
              },
            ),
            SizedBox(width: 10),
            Expanded(child: _buildSearchBar(context)),
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(
                TablerIcons.microphone,
                size: 40.w,
              ),
            ),
          ],
        )),
      ),
    );
  }

  _buildSearchBar(BuildContext context) {
    return Container(
      height: 70.w,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                AutoRouter.of(context).pushNamed(Routes.search);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 40.w,
                  ),
                  const SizedBox(width: 10),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '搜索歌曲、歌手、专辑',
                        style: TextStyle(fontSize: 25.sp),
                      )),
                ],
              ),
            ),
          ),
          Icon(
            TablerIcons.scan,
            size: 40.w,
          )
        ],
      ),
    );
  }

  _buildContent(BuildContext context) {
    return Obx(() {
      return controller.loading.value
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: EasyRefresh.builder(
                    header: const ClassicHeader(
                      dragText: "下拉刷新",
                      armedText: "释放刷新",
                      processedText: "刷新完成",
                      failedText: "刷新失败",
                      noMoreText: "没有更多数据",
                      readyText: "正在刷新...",
                      messageText: "上次刷新时间 %T",
                    ),
                    onRefresh: () async {
                      // 控制刷新频率

                      await controller.refreshMainPage();
                    },
                    childBuilder: (context, physics) {
                      return Obx(() {
                        return CustomScrollView(
                          physics: physics,
                          slivers: [
                            _buildEveryDayRecommendCards(context),
                            if (controller.similarSongs.value.isNotEmpty &&
                                controller.personalFmSongs.value.isNotEmpty)
                              _buildSongsList(context, '你的红心歌曲相似推荐',
                                  controller.similarSongs.value),
                            if (controller.personalFmSongs.value.isNotEmpty &&
                                controller.privateRadarSongs.value.isNotEmpty)
                              _buildSongsList(
                                  context,
                                  controller.randomPlaylist.value.name ?? '',
                                  controller.randomPlaylistSongs.value),
                            if (controller.personalFmSongs.value.isNotEmpty &&
                                controller.privateRadarSongs.value.isNotEmpty)
                              _buildProgramsList(
                                  context,
                                  '为你精选的音乐播客',
                                  controller
                                      .personalizedDjprogramDto.value.result!),
                            if (controller.recommendResourceDto.value != null &&
                                controller.recommendResourceDto.value!
                                        .recommend !=
                                    null)
                              _buildRecommendPlayList(
                                  context,
                                  '${HomeController.to.userData.value.profile!.nickname ?? ""}的雷达歌单',
                                  controller
                                      .recommendResourceDto.value!.recommend!),
                            if (controller.personalizedPlayLists.value !=
                                    null &&
                                controller
                                    .personalizedPlayLists.value.isNotEmpty)
                              _buildRecommendPlayList(context, '推荐歌单',
                                  controller.personalizedPlayLists.value),
                            if (controller.ownPlayList.value.isNotEmpty)
                              _buildPlayList(context, '我的歌单',
                                  controller.ownPlayList.value),

                            // 占位 底部100.w
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: 100.w,
                              ),
                            )
                          ],
                        );
                      });
                    }),
              ),
            );
    });
  }

  _buildEveryDayRecommendCards(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(_getCurrentTime(),
                  style:
                      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 280.w,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                if (controller.recommendSongsDto.value.dailySongs != null &&
                    controller.recommendSongsDto.value.dailySongs!.isNotEmpty)
                  Row(
                    children: [
                      MusicCard(
                        title: "每日推荐",
                        subTitle: "符合你口味的新鲜好歌",
                        icon: TablerIcons.calendar,
                        cardPic:
                            controller.dailySongs[0].extras?['image'] ?? '',
                        onTapHandle: () {
                          GetIt.instance<AppRouter>().push(SongsList(
                              songs: controller.dailySongs,
                              title: '每日推荐',
                              picUrl:
                                  controller.dailySongs[0].extras?['image'] ??
                                      ''));
                        },
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                if (controller.personalFmSongs.value.isNotEmpty)
                  Row(
                    children: [
                      MusicCard(
                        title: "私人漫游",
                        subTitle: "多种听歌模式随心播放",
                        icon: TablerIcons.radio,
                        cardPic: controller
                                .personalFmSongs.value[0].extras?['image'] ??
                            '',
                        onTapHandle: () {
                          Roaming.showBottomPlayer(context);
                        },
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                if (controller.privateRadarSongs.value.isNotEmpty)
                  Row(
                    children: [
                      MusicCard(
                        title: "私人雷达",
                        subTitle: "你爱的歌值得反复聆听",
                        icon: TablerIcons.radio,
                        cardPic: controller
                                .privateRadarSongs.value[0].extras?['image'] ??
                            '',
                        onTapHandle: () {
                          GetIt.instance<AppRouter>().push(SongsList(
                              songs: controller.privateRadarSongs.value,
                              title: '私人雷达',
                              picUrl: controller.privateRadarSongs.value[0]
                                      .extras?['image'] ??
                                  ''));
                        },
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                if (controller.similarSongs.value.isNotEmpty)
                  Row(
                    children: [
                      MusicCard(
                        title: "相似歌曲",
                        subTitle: "从你喜欢的歌听起",
                        cardPic:
                            controller.similarSongs.value[0].extras?['image'] ??
                                '',
                        onTapHandle: () {
                          Roaming.showBottomPlayer(context);
                        },
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                if (controller.personalizedDjprogramDto.value != null &&
                    controller.personalizedDjprogramDto.value!.result != null)
                  MusicCard(
                    title: "音乐播客",
                    subTitle: controller
                            .personalizedDjprogramDto.value!.result![0].name ??
                        "",
                    cardPic: controller
                        .personalizedDjprogramDto.value!.result![0].picUrl,
                    onTapHandle: () {
                      Roaming.showBottomPlayer(context);
                    },
                  ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    if (now.hour >= 6 && now.hour < 12) {
      return '早上好';
    } else if (now.hour >= 12 && now.hour < 18) {
      return '下午好';
    } else if (now.hour >= 18 && now.hour < 24) {
      return '晚上好';
    } else {
      return '夜深了';
    }
  }

  _buildProgramsList(
      BuildContext context, String title, List<DjProgram> programs) {
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
          PodcastListWidget(
            programs: programs,
          ),
        ],
      ),
    );
  }

  _buildSongsList(BuildContext context, String title, List<MediaItem> songs) {
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
          SongsListWidget(
            songs: songs,
          ),
        ],
      ),
    );
  }

  _buildRecommendPlayList(BuildContext context, String title,
      List<RecommendPlaylist> recommendPlayList) {
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
          RecommendPlayListCard(
            recommendPlayList: recommendPlayList,
            onTapItemIndex: (index) async {
              final mediaItems = await controller
                  .getPlayListDetail(recommendPlayList[index].id!);
              GetIt.instance<AppRouter>().push(SongsList(
                  songs: mediaItems,
                  title: recommendPlayList[index].name!,
                  picUrl: recommendPlayList[index].picUrl!));
            },
          )
        ],
      ),
    );
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
              final lists =
                  await controller.getPlayListDetail(playLists[index].id!);
              GetIt.instance<AppRouter>().push(SongsList(
                  songs: lists,
                  title: playLists[index].name!,
                  picUrl: playLists[index].coverImgUrl!));
            },
          )
        ],
      ),
    );
  }
}
