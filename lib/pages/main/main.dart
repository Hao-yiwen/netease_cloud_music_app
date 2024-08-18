import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/main/main_controller.dart';

@RoutePage()
class Main extends GetView<MainController> {
  const Main({super.key});

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
      child: (Row(
        children: [
          GestureDetector(
            child: Icon(
              TablerIcons.menu_2,
              size: 40.w,
            ),
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
          Icon(
            Icons.search,
            size: 40.w,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 25,
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                // todo http://127.0.0.1:3000/search/hot
                decoration: InputDecoration(
                  hintText: '搜索歌曲、歌手、专辑',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 25.sp),
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
              child: _buildContentCard(),
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
              child: SizedBox(
                height: 300, // 固定的高度，每列高度
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.9, // 每列占90%的宽度
                    initialPage: -1, // 通过设置负的初始页面，消除初始空白
                  ),
                  itemCount: 6, // 总共6列
                  itemBuilder: (context, pageIndex) {
                    return Transform.translate(
                      offset: Offset(-ScreenUtil().screenWidth * 0.05, 0),
                      // 通过偏移纠正显示
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: List.generate(3, (rowIndex) {
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      '歌曲 ${pageIndex * 3 + rowIndex + 1}'),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
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
              child: SizedBox(
                height: 300, // 固定的高度，每列高度
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.9, // 每列占90%的宽度
                    initialPage: -1, // 通过设置负的初始页面，消除初始空白
                  ),
                  itemCount: 6, // 总共6列
                  itemBuilder: (context, pageIndex) {
                    return Transform.translate(
                      offset: Offset(-ScreenUtil().screenWidth * 0.05, 0),
                      // 通过偏移纠正显示
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: List.generate(3, (rowIndex) {
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      '歌曲 ${pageIndex * 3 + rowIndex + 1}'),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 198.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 168.w,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 198.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 168.w,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 198.w,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 168.w,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text('电音风暴 二次狂欢',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300, // 固定的高度，每列高度
                child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.9, // 每列占90%的宽度
                    initialPage: -1, // 通过设置负的初始页面，消除初始空白
                  ),
                  itemCount: 6, // 总共6列
                  itemBuilder: (context, pageIndex) {
                    return Transform.translate(
                      offset: Offset(-ScreenUtil().screenWidth * 0.05, 0),
                      // 通过偏移纠正显示
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: List.generate(3, (rowIndex) {
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.w),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                      '歌曲 ${pageIndex * 3 + rowIndex + 1}'),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildContentCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          height: 280.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 250.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                ),
              );
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
