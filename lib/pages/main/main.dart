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
import '../../widgets/songs_big_cards.dart';
import '../../widgets/songs_list_widget.dart';
import '../../widgets/songs_small_cards.dart';
import '../home/home_controller.dart';

@RoutePage()
class Main extends GetView<MainController> {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.loading.value,
      child: SafeArea(
        child: (Column(
          children: [_buildHeader(context), _buildContent(context)],
        )),
      ),
    );
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
                child: GestureDetector(
                  onTap: () {
                    GetIt.instance<AppRouter>().push(SongsList(
                        recommendSongsDto: controller.recommendSongsDto.value));
                  },
                  child: Container(
                      height: 280.w,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                width: 250.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("每日推荐",
                                            style: TextStyle(
                                                fontSize: 30.sp,
                                                color: Colors.white))),
                                    Icon(TablerIcons.calendar, size: 100.w),
                                    Spacer(),
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Text(
                                            "符合你口味的新鲜好歌",
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ])),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('你的红心歌曲和相似推荐',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SongsListWidget(),
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
              child: SongsListWidget(),
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
            SliverToBoxAdapter(child: SongsListWidget()),
          ],
        ),
      ),
    );
  }
}
