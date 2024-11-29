import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/pages/search/mv_list.dart';
import 'package:netease_cloud_music_app/pages/search/searchpage_controller.dart';
import 'package:netease_cloud_music_app/pages/search/song_list.dart';
import 'package:netease_cloud_music_app/pages/search/widgets/search_page_bar.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../../routes/routes.dart';
import '../../routes/routes.gr.dart';
import '../../widgets/bottom_player_bar.dart';
import '../main/main_controller.dart';

@RoutePage()
class SearchDetail extends StatefulWidget {
  const SearchDetail({super.key});

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final SearchpageController controller = Get.find();
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController =
        TextEditingController(text: controller.textvalue.value);
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) return;

    final searchText = controller.textvalue.value;
    switch (_tabController.index) {
      case 0:
        controller.searchKeyWords(searchText);
        break;
      case 1:
        controller.searchMv(searchText);
        break;
      case 2:
        controller.searchSongList(searchText);
        break;
    }
  }

  void _handleSearch(BuildContext context) {
    if (controller.textvalue.value.isEmpty) {
      WidgetUtil.showToast('请输入搜索内容');
      return;
    }

    controller.clearData();
    final searchText = controller.textvalue.value;

    switch (_tabController.index) {
      case 0:
      case 2:
        controller.searchKeyWords(searchText);
        break;
      case 1:
        controller.searchMv(searchText);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildContent(),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(TablerIcons.chevron_left, size: 60.w),
        onPressed: () => Navigator.of(context).pop(),
      ),
      leadingWidth: 40,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SearchPageBar(
          search: _handleSearch,
          setTextValue: (value) => controller.textvalue.value = value,
          textEditingController: textEditingController,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70.w),
        child: _buildTabBar(),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      dividerHeight: 0,
      padding: EdgeInsets.zero,
      tabs: const [
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
      unselectedLabelColor: const Color.fromARGB(255, 145, 150, 162),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.red, width: 2),
        insets: EdgeInsets.symmetric(horizontal: 22),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.searchDetailLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          const SongList(key: PageStorageKey('Tab0')),
          const MvList(key: PageStorageKey('Tab1')),
          _buildSongList(),
          const Center(child: Text('歌手')),
          const Center(child: Text('专辑')),
        ],
      );
    });
  }

  Widget _buildSongList() {
    return Obx(() {
      final playlists = controller.songList.value.result?.playlists;
      if (playlists == null || playlists.isEmpty) {
        return const Center(child: Text('暂无数据'));
      }

      return ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return GestureDetector(
            key: ValueKey(playlist.id ?? index),
            onTap: () => _handlePlaylistTap(playlist),
            child: ListTile(
              title: Text(
                playlist.name ?? '',
                style: const TextStyle(color: Colours.blue),
              ),
              subtitle: Text(
                playlist.creator?.nickname ?? '',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: NeteaseCacheImage(picUrl: playlist.coverImgUrl ?? ''),
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> _handlePlaylistTap(dynamic playlist) async {
    GetIt.instance<AppRouter>().push(SongsList(id: playlist.id!));
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: const BottomPlayerBar(),
      ),
    );
  }
}
