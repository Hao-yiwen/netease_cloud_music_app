import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get_it/get_it.dart';

import '../../routes/routes.dart';
import '../../widgets/songs_big_cards.dart';
import '../../widgets/songs_list.dart';
import '../../widgets/songs_small_cards.dart';

@RoutePage()
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final scaffoldKey = GetIt.instance<GlobalKey<ScaffoldState>>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Column(
        children: [_buildHeader(), _buildContent()],
      )),
    );
  }

  _buildHeader() {
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
                print('open drawer');
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            SizedBox(width: 10),
            Expanded(child: _buildSearchBar()),
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

  _buildSearchBar() {
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
                GetIt.instance<AppRouter>().pushNamed('/home/search');
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

  _buildContent() {
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
              child: SongsBigCards(),
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
              child: SongsList(),
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
              child: SongsList(),
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
            SliverToBoxAdapter(child: SongsList()),
          ],
        ),
      ),
    );
  }
}
