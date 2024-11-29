import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/pages/songs_list/song_list_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';
import 'package:netease_cloud_music_app/widgets/shimmer_loading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/utils/debouncer.dart';
import '../../common/utils/image_utils.dart';
import '../../widgets/bottom_player_bar.dart';

@RoutePage()
class SongsList extends GetView<SongListController> {
  final int id;
  final _debouncer = Debouncer(milliseconds: 500);

  SongsList({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SongListController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPlayListDetail(id);
    });

    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(color: theme.cardColor),
          Obx(() {
            if (controller.isLoading.value) {
              return CustomScrollView(
                slivers: [
                  _buildSkeletonAppBar(context),
                  _buildSkeletonList(),
                ],
              );
            }

            if (controller.error.value.isNotEmpty) {
              return Center(
                child: Text(
                  controller.error.value,
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: theme.colorScheme.error,
                  ),
                ),
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildAppBar(context),
                _buildSongsList(context),
              ],
            );
          }),
          _buildBottomBar(context, bottomPadding),
        ],
      ),
    );
  }

  Widget _buildSkeletonAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.h,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50.w),
        ),
        margin: EdgeInsets.all(8.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: ShimmerLoading(
          child: Container(
            width: 200.w,
            height: 35.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
        ),
        background: ShimmerLoading(
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.h,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(50.w),
        ),
        margin: EdgeInsets.all(8.w),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          final isExpanded = top > 200;

          return FlexibleSpaceBar(
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                controller.title.value,
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    color: isExpanded ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: isExpanded ? 32.sp : 28.sp,
                    letterSpacing: 1.2,
                    shadows: isExpanded
                        ? [
                            Shadow(
                              offset: Offset(2.w, 2.w),
                              blurRadius: 4.w,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            Shadow(
                              offset: Offset(-1.w, -1.w),
                              blurRadius: 4.w,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ]
                        : null,
                  ),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                NeteaseCacheImage(
                  picUrl: controller.picUrl.value,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: ShimmerLoading(
            child: Container(
              height: 80.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(12.w),
              ),
            ),
          ),
        ),
        childCount: 10,
      ),
    );
  }

  Widget _buildSongsList(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildSongItem(context, index),
          childCount: controller.songs.length,
        ),
      ),
    );
  }

  Widget _buildSongItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final roamingController = RoamingController.to;
    final song = controller.songs[index];

    return GestureDetector(
      onTap: () {
        _debouncer.run(() {
          roamingController.playByIndex(index, 'queueTitle',
              mediaItem: controller.songs);
          Roaming.showBottomPlayer(context);
        });
      },
      child: Obx(() {
        final isCurrentSong = roamingController.mediaItem == song;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: isCurrentSong ? theme.primaryColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: _buildLeadingWidget(index, isCurrentSong),
            title: Text(
              song.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isCurrentSong
                    ? Colours.app_main
                    : theme.colorScheme.onPrimary,
                fontSize: 28.sp,
                fontWeight: isCurrentSong ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              song.artist!,
              style: TextStyle(
                color: theme.colorScheme.onPrimary.withOpacity(0.7),
                fontSize: 24.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLeadingWidget(int index, bool isCurrentSong) {
    if (!isCurrentSong) {
      return Container(
        width: 50.w,
        height: 50.w,
        alignment: Alignment.center,
        child: Text(
          '${index + 1}.',
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Obx(() {
      final isPlaying = RoamingController.to.playing.value;
      final imagePath = isPlaying ? 'video_playlist_icn_playing' : 'c2w';

      return Container(
        width: 50.w,
        height: 50.w,
        padding: EdgeInsets.all(5.w),
        child: Image.asset(
          ImageUtils.getImagePath(imagePath),
          color: Colours.app_main,
        ),
      );
    });
  }

  Widget _buildBottomBar(BuildContext context, double bottomPadding) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, -2.w),
              blurRadius: 10.w,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: const BottomPlayerBar(),
        ),
      ),
    );
  }
}
