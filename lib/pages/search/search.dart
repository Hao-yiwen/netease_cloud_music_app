import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';
import 'package:netease_cloud_music_app/pages/search/widgets/search_page_bar.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import '../../routes/routes.gr.dart';
import '../../widgets/bottom_player_bar.dart';

@RoutePage()
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SearchpageController controller;
  var textvalue = '';
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    Get.lazyPut(() => SearchpageController());
    controller = Get.find<SearchpageController>();
    super.initState();
  }

  _gotoSearchDetail(BuildContext context) {
    if (textvalue.isEmpty) {
      WidgetUtil.showToast('请输入搜索内容');
      return;
    }
    GetIt.instance<AppRouter>().push(SearchDetail(keywords: textvalue));
    controller.searchKeyWords(textvalue);
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

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
        title: SearchPageBar(
          search: _gotoSearchDetail,
          setTextValue: (value) {
            textvalue = value;
          },
          textEditingController: textEditingController,
        ),
        actions: [
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              _gotoSearchDetail(context);
            },
            child: Text('搜索', style: TextStyle(fontSize: 30.w)),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
              bottom: 0,
              left: 0, // 确保有约束条件
              right: 0, //
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: BottomPlayerBar(),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchHistory(),
            _buildSearchHot(),
          ],
        ),
      ),
    );
  }

  _buildSearchHistory() {
    return Container(
      child: Column(
        children: [Text('搜索历史')],
      ),
    );
  }

  _buildSearchHot() {
    return Container(
      child: Column(
        children: [Text('热门搜索')],
      ),
    );
  }
}
