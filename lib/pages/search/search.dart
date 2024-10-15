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
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    Get.lazyPut(() => SearchpageController());
    controller = Get.find<SearchpageController>();
    textEditingController.text = controller.textvalue.value;
    controller.getSearchKeyWords();
    super.initState();
  }

  _gotoSearchDetail(BuildContext context) {
    if (controller.textvalue.value.isEmpty) {
      WidgetUtil.showToast('请输入搜索内容');
      return;
    }
    GetIt.instance<AppRouter>().push(SearchDetail());
    controller.searchKeyWords(controller.textvalue.value);
    // 保存搜索结果
    controller.saveSearchKeyWords(controller.textvalue.value);
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
          child: Center(
              child: Icon(
            TablerIcons.chevron_left,
            size: 60.w,
          )),
        ),
        leadingWidth: 40,
        title: SearchPageBar(
          search: _gotoSearchDetail,
          setTextValue: (value) {
            controller.textvalue.value = value;
            controller.searchSuggest(value);
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
                  child: const BottomPlayerBar(),
                ),
              )),
          _buildKeyWords(context),
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
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('搜索历史'),
            Wrap(
              spacing: 10, // 控制水平间距
              runSpacing: 5, // 控制垂直间距
              children: controller.searchKey.map((e) {
                return GestureDetector(
                  onTap: () {
                    textEditingController.text = e;
                    controller.textvalue.value = e;
                    _gotoSearchDetail(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e,
                          style: TextStyle(color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              controller.deleteSearchKeyWords(e);
                            },
                            child: Icon(TablerIcons.trash, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }

  _buildSearchHot() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [Text('热门搜索')],
      ),
    );
  }

  _buildKeyWords(BuildContext context) {
    return Obx(() {
      if (controller.textvalue.value.isNotEmpty) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: controller
                      .keyWordsSuggest.value?.result?.allMatch?.isNotEmpty ==
                  true
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        textEditingController.text = controller.keyWordsSuggest
                                .value?.result?.allMatch?[index].keyword ??
                            '';
                        controller.textvalue.value = controller.keyWordsSuggest
                                .value?.result?.allMatch?[index].keyword ??
                            '';
                        _gotoSearchDetail(context);
                      },
                      child: ListTile(
                        leading: Icon(
                          TablerIcons.search,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          controller.keyWordsSuggest.value?.result
                                  ?.allMatch?[index].keyword ??
                              '',
                          style: TextStyle(
                              fontSize: 25.w, color: Colors.blueAccent),
                        ),
                      ),
                    );
                  },
                  itemCount: controller
                          .keyWordsSuggest.value?.result?.allMatch?.length ??
                      0,
                )
              : Container(
                  child: Text(
                    '继续搜索',
                    style: TextStyle(fontSize: 30.w, color: Colors.blueAccent),
                  ),
                ),
        );
      }
      return Container();
    });
  }
}
