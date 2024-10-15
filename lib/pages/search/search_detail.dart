import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';
import 'package:netease_cloud_music_app/pages/search/widgets/search_page_bar.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../../http/api/search/dto/search_result.dart';
import '../../routes/routes.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/bottom_player_bar.dart';
import '../main/main_controller.dart';
import '../roaming/roaming.dart';
import '../roaming/roaming_controller.dart';

@RoutePage()
class SearchDetail extends StatefulWidget {
  SearchDetail({super.key,});

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SearchpageController controller = Get.find<SearchpageController>();
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: controller.textvalue.value);
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        int index = _tabController.index;
        if (index == 0) {
          // 当切换到“单曲”选项卡时，调用搜索单曲的方法
          controller.searchKeyWords(controller.textvalue.value);
        } else if (index == 1) {
          // 当切换到“视频”选项卡时，调用搜索视频的方法
          controller.searchMv(controller.textvalue.value);
        } else if(index == 2) {
          controller.searchSongList(controller.textvalue.value);
        }
        // 如果需要在其他选项卡下进行搜索，可以继续添加判断
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Icon(
              TablerIcons.chevron_left,
              size: 60.w,
            ),
          ),
        ),
        leadingWidth: 40,
        title: Padding(
          padding: EdgeInsets.only(right: 30.w, left: 20.w),
          child: SearchPageBar(
            search: (context) {
              if (controller.textvalue.value.isEmpty) {
                WidgetUtil.showToast('请输入搜索内容');
                return;
              }
              controller.clearData();
              if (_tabController.index == 0) {
                controller.searchKeyWords(controller.textvalue.value);
              } else if (_tabController.index == 1) {
                controller.searchMv(controller.textvalue.value);
              } else {
                controller.searchKeyWords(controller.textvalue.value);
              }
            },
            setTextValue: (value) {
              controller.textvalue.value = value;
            },
            textEditingController: textEditingController,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.w),
          child: _buildHeader(context),
        ),
      ),
      body: Stack(
        children: [
          _buildContent(context),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: const BottomPlayerBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return TabBar(
      dividerHeight: 0,
      padding: EdgeInsets.zero,
      controller: _tabController,
      // isScrollable: true,
      tabs: [
        Tab(text: '单曲'),
        Tab(text: '视频'),
        Tab(text: '歌单'),
        Tab(text: '歌手'),
        Tab(text: '专辑'),
      ],
      labelStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.normal,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Color.fromARGB(255, 145, 150, 162),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 2),
        insets: EdgeInsets.symmetric(horizontal: 22),
      ),
    );
  }

  _buildContent(BuildContext context) {
    return Obx(() {
      return controller.searchDetailLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              physics: NeverScrollableScrollPhysics(), // 禁用滑动
              controller: _tabController,
              children: [
                SongList(key: PageStorageKey('Tab0')),
                MvList(key: PageStorageKey('Tab1')),
                _buildSongList(context),
                Text('歌手'),
                Text('专辑'),
              ],
            );
    });
  }

  _buildSongList(BuildContext context) {
    return Container(
      child: Obx(() {
        final int count =
            controller.songList.value.result?.playlists?.length ?? 0;
        return count > 0
            ? ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              return GestureDetector(
                key: ValueKey(controller.songList.value.result?.playlists?[index]
                    .id),
                onTap: () async {
                  final lists = await MainController.to
                      .getPlayListDetail(controller.songList.value.result?.playlists?[index].id ?? 0);
                  GetIt.instance<AppRouter>().push(SongsList(
                      songs: lists,
                      title: controller.songList.value.result?.playlists?[index].name ?? '',
                      picUrl: controller.songList.value.result?.playlists?[index].coverImgUrl ?? ''));
                },
                child: ListTile(
                  title: Text(
                    controller.songList.value.result?.playlists?[index].name ??
                        '',
                    style: TextStyle(color: Colours.blue),
                  ),
                  subtitle: Text(
                      controller.songList.value.result?.playlists?[index].creator
                          ?.nickname ??
                          '',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: NeteaseCacheImage(
                        picUrl: controller.songList.value.result?.playlists?[index]
                            .coverImgUrl ??
                            ''),
                  ),
                ),
              );
            })
            : Center(
          child: Text('暂无数据'),
        );
      }),
    );
  }
}

class SongList extends GetView<SearchpageController> {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: Obx(() {
        final int count =
            controller.searchResult.value.result?.songs?.length ?? 0;
        return count > 0
            ? ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    key: ValueKey(controller.searchSongs.value[index].id),
                    onTap: () {
                      RoamingController.to.playByIndex(index, 'queueTitle',
                          mediaItem: controller.searchSongs.value);
                      Roaming.showBottomPlayer(context);
                    },
                    child: ListTile(
                      title: Text(
                        controller.searchResult.value.result?.songs?[index]
                                .name ??
                            '',
                        style: TextStyle(color: Colours.blue),
                      ),
                      subtitle: Text(
                          controller.searchResult.value.result?.songs?[index]
                                  .artists
                                  ?.map((e) => e.name)
                                  .join(' / ') ??
                              '',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                      trailing: IconButton(
                        icon: Icon(
                          TablerIcons.player_play_filled,
                          color: Colors.grey[400],
                          size: 30.w,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  );
                })
            : Center(
                child: Text('暂无数据'),
              );
      }),
    );
  }
}

class MvList extends GetView<SearchpageController> {
  const MvList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        key: key,
        child: Obx(() {
          final int count = controller.searchMvs.value.result?.mvs?.length ?? 0;
          return count > 0
              ? ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      key: ValueKey(controller.searchMvs.value.result?.mvs?[index]
                          .id),
                      onTap: () {
                        GetIt.instance<AppRouter>().push(MvPlayer(
                          title: controller
                                  .searchMvs.value.result?.mvs?[index].name ??
                              '',
                          id: controller
                                  .searchMvs.value.result?.mvs?[index].id ??
                              0,
                          artist: controller
                                  .searchMvs.value.result?.mvs?[index].artists
                                  ?.map((e) => e.name)
                                  .join(' / ') ??
                              '',
                        ));
                      },
                      child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: NeteaseCacheImage(
                                picUrl: controller.searchMvs.value.result
                                        ?.mvs?[index].cover ??
                                    ''),
                          ),
                          title: Text(
                            controller
                                    .searchMvs.value.result?.mvs?[index].name ??
                                '',
                            style: TextStyle(color: Colours.blue),
                            maxLines: 1,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (controller.searchMvs.value.result?.mvs?[index]
                                        .artists
                                        ?.map((e) => e.name)
                                        .join(' / ') ??
                                    ''),
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .fontSize,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                maxLines: 1,
                              ),
                              Text(
                                '播放量：${controller.searchMvs.value.result?.mvs?[index].playCount}',
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .fontSize,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                maxLines: 1,
                              ),
                            ],
                          )),
                    );
                  })
              : Center(
                  child: Text('暂无数据'),
                );
        }));
  }
}
