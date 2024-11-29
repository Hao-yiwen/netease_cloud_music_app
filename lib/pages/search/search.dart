import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/app_strings.dart';
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
  late final SearchpageController controller;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    Get.lazyPut(() => SearchpageController());
    controller = Get.find<SearchpageController>();
    textEditingController.text = controller.textvalue.value;
    controller.getSearchKeyWords();
  }

  void _gotoSearchDetail(BuildContext context) {
    final searchText = controller.textvalue.value;
    if (searchText.isEmpty) {
      WidgetUtil.showToast(AppStrings.pleaseEnterSearchContent);
      return;
    }

    GetIt.instance<AppRouter>().push(SearchDetail());
    controller.searchKeyWords(searchText);
    controller.saveSearchKeyWords(searchText);
  }

  void _handleKeywordTap(String keyword) {
    textEditingController.text = keyword;
    controller.textvalue.value = keyword;
    _gotoSearchDetail(context);
  }

  void _clearSearchText() {
    textEditingController.clear();
    controller.textvalue.value = '';
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildContent(),
          _buildBottomPlayerBar(bottomPadding),
          _buildKeyWords(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleSpacing: 0,
      leading: _buildBackButton(),
      leadingWidth: 40,
      title: SearchPageBar(
        search: _gotoSearchDetail,
        setTextValue: _handleTextValueChange,
        textEditingController: textEditingController,
      ),
      actions: _buildAppBarActions(context),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: Icon(
          TablerIcons.chevron_left,
          size: 60.w,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      const SizedBox(width: 15),
      GestureDetector(
        onTap: () => _gotoSearchDetail(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20.w),
          ),
          child: Text(
            AppStrings.search,
            style: TextStyle(
              fontSize: 28.w,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      const SizedBox(width: 15),
    ];
  }

  void _handleTextValueChange(String value) {
    controller.textvalue.value = value;
    controller.searchSuggest(value);
  }

  Widget _buildContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchHistory(),
            SizedBox(height: 30.w),
            _buildSearchHot(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPlayerBar(double bottomPadding) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: const BottomPlayerBar(),
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Obx(() {
      if (controller.searchKey.isEmpty) return const SizedBox();

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.searchHistory,
                  style: TextStyle(
                    fontSize: 32.w,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                IconButton(
                  onPressed: () => controller.clearSearchKeyWords(),
                  icon: Icon(
                    TablerIcons.trash,
                    size: 40.w,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            _buildHistoryKeywords(),
          ],
        ),
      );
    });
  }

  Widget _buildHistoryKeywords() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.w,
      children: controller.searchKey.map((keyword) {
        return _buildKeywordChip(keyword);
      }).toList(),
    );
  }

  Widget _buildKeywordChip(String keyword) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleKeywordTap(keyword),
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.w,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                TablerIcons.clock,
                size: 28.w,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                keyword,
                style: TextStyle(
                  fontSize: 28.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => controller.deleteSearchKeyWords(keyword),
                child: Icon(
                  TablerIcons.x,
                  size: 28.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHot() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.hotSearch,
          style: TextStyle(
            fontSize: 32.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.w),
        // TODO: Add hot search content
      ],
    );
  }

  Widget _buildKeyWords(BuildContext context) {
    return Obx(() {
      if (controller.textvalue.value.isEmpty) {
        return Container();
      }

      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: _buildSuggestionsList(),
      );
    });
  }

  Widget _buildSuggestionsList() {
    final hasMatches =
        controller.keyWordsSuggest.value?.result?.allMatch?.isNotEmpty == true;

    if (!hasMatches) {
      return Center(
        child: Text(
          AppStrings.continueSearch,
          style: TextStyle(
            fontSize: 28.w,
            color: Colors.grey[600],
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount:
          controller.keyWordsSuggest.value?.result?.allMatch?.length ?? 0,
      itemBuilder: (context, index) {
        final keyword = controller
                .keyWordsSuggest.value?.result?.allMatch?[index].keyword ??
            '';
        return _buildSuggestionItem(keyword);
      },
    );
  }

  Widget _buildSuggestionItem(String keyword) {
    return InkWell(
      onTap: () => _handleKeywordTap(keyword),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.w),
        child: Row(
          children: [
            Icon(
              TablerIcons.search,
              size: 40.w,
              color: Colors.grey[600],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                keyword,
                style: TextStyle(
                  fontSize: 28.w,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
