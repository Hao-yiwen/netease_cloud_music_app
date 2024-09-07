import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';
import 'package:netease_cloud_music_app/routes/routes.gr.dart';

import '../../routes/routes.dart';
import '../../widgets/song_card.dart';
import '../../widgets/songs_list_widget.dart';
import '../../widgets/songs_small_cards.dart';
import '../home/home_controller.dart';
import '../roaming/roaming.dart';

@RoutePage()
class Main extends GetView<MainController> {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !controller.loading.value,
        child: SafeArea(
          child: (Column(
            children: [_buildHeader(context), _buildContent(context)],
          )),
        ),
      );
    });
  }

  _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
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
                  SizedBox(width: 10),
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('晚上好',
                    style: TextStyle(
                        fontSize: 40.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 280.w,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        MusicCard(
                          title: "每日推荐",
                          subTitle: "符合你口味的新鲜好歌",
                          icon: TablerIcons.calendar,
                          onTapHandle: () {
                            GetIt.instance<AppRouter>().push(SongsList(
                                recommendSongsDto:
                                    controller.recommendSongsDto.value));
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MusicCard(
                          title: "私人漫游",
                          subTitle: "多种听歌模式随心播放",
                          icon: TablerIcons.radio,
                          onTapHandle: () {
                            Roaming.showBottomPlayer(context);
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MusicCard(
                          title: "私人雷达",
                          subTitle: "你爱的歌值得反复聆听",
                          icon: TablerIcons.radio,
                          onTapHandle: () {
                            Roaming.showBottomPlayer(context);
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MusicCard(
                          title: "相似歌曲",
                          subTitle: "从你喜欢的歌听起",
                          onTapHandle: () {
                            Roaming.showBottomPlayer(context);
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MusicCard(
                          title: "相似艺人",
                          subTitle: "从你喜欢的艺人听起",
                          onTapHandle: () {
                            Roaming.showBottomPlayer(context);
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        MusicCard(
                          title: "每日博客",
                          subTitle: "【白噪音】初秋傍晚，写写画画，虫鸣唧唧，...",
                          onTapHandle: () {
                            Roaming.showBottomPlayer(context);
                          },
                        ),
                      ]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('你的红心歌曲相似推荐',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SongsListWidget(
                songs: controller.similarSongs.value,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('为你定制精选歌曲',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
                // child: SongsListWidget(),
                ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('推荐歌单',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SongsSmallCards(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('老死在撒哈拉的雷达歌单',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SongsSmallCards(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('排行榜',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SongsSmallCards(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('电音风暴 二次狂欢',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            // SliverToBoxAdapter(child: SongsListWidget()),
          ],
        ),
      ),
    );
  }
}
