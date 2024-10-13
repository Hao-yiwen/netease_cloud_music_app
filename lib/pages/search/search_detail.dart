import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';
import 'package:netease_cloud_music_app/pages/search/widgets/search_page_bar.dart';

import '../../http/api/search/dto/search_result.dart';
import '../../widgets/bottom_player_bar.dart';
import '../roaming/roaming.dart';
import '../roaming/roaming_controller.dart';

@RoutePage()
class SearchDetail extends StatefulWidget {
  final String keywords;
  SearchDetail({super.key, required this.keywords});

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageViewController;
  var textvalue = '';
  final SearchpageController controller = Get.find<SearchpageController>();
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    // 延迟设置textEditingController的值
    textEditingController = TextEditingController(text: widget.keywords);
    _tabController = TabController(length: 5, vsync: this);
    _pageViewController = PageController();
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
            child: Container(
              child: Center(
                  child: Icon(
                TablerIcons.chevron_left,
                size: 60.w,
              )),
            ),
          ),
          leadingWidth: 40,
          title: Padding(
              padding: EdgeInsets.only(right: 30.w, left: 20.w),
              child: SearchPageBar(search: (context) {
                if(textvalue.isEmpty){
                  WidgetUtil.showToast('请输入搜索内容');
                  return;
                }
                controller.searchKeyWords(textvalue);
              }, setTextValue: (value) {
                setState(() {
                  textvalue = value;
                });
              }, textEditingController: textEditingController,)),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context),
                SizedBox(height: 20.w),
                Expanded(child: _buildContent(context))
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0, // 确保有约束条件
                right: 0, //
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
                    child: const BottomPlayerBar(),
                  ),
                ))
          ],
        ));
  }

  _buildHeader(BuildContext context) {
    return SizedBox(
      height: 70.w,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TabBar(
            controller: _tabController,
            dividerHeight: 0,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: '单曲'),
              Tab(text: '视频'),
              Tab(text: '歌单'),
              Tab(text: '歌手'),
              Tab(text: '专辑'),
            ],
            onTap: (index) {
              _pageViewController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
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
          ),
        ),
      ),
    );
  }

  _buildContent(BuildContext context) {
    return Obx(() {
      return controller.searchDetailLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: MediaQuery.of(context).padding.bottom),
              child: PageView(
                controller: _pageViewController,
                onPageChanged: (index) {
                  _tabController.animateTo(index);
                },
                children: [
                  _buildSongList(context),
                  Text('歌单'),
                  Text('歌手'),
                  Text('专辑'),
                  Text('视频'),
                ],
              ),
            );
    });
  }

  _buildSongList(BuildContext context) {
    return Obx(() {
      final int count = controller.searchResult.value.result?.songCount ?? 0;
      return count > 0
          ? ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    RoamingController.to.playByIndex(index, 'queueTitle',
                        mediaItem: controller.searchSongs.value);
                    Roaming.showBottomPlayer(context);
                  },
                  child: ListTile(
                    title: Text(
                      controller
                              .searchResult.value.result?.songs?[index].name ??
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
    });
  }
}
