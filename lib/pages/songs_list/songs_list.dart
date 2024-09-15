import 'package:audio_service/audio_service.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../../common/utils/image_utils.dart';
import '../../widgets/bottom_player_bar.dart';

/**
 * @data 2024/09/15
 * @desc 所有songDto接口都转化为mediaItem
 */
@RoutePage()
class SongsList extends StatelessWidget {
  final List<MediaItem> songs;
  final String title;
  final String picUrl;

  const SongsList(
      {super.key,
      required this.songs,
      required this.title,
      required this.picUrl});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(title),
                  background: NeteaseCacheImage(picUrl: picUrl),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final isPlaying =
                        RoamingController.to.mediaItem == songs[index];
                    return GestureDetector(
                      onTap: () {
                        RoamingController.to
                            .playByIndex(index, 'queueTitle', mediaItem: songs);
                        Roaming.showBottomPlayer(context);
                      },
                      child: Obx(() {
                        return ListTile(
                          leading: isPlaying
                              ? (RoamingController.to.playing.value
                                  ? Image.asset(
                                      ImageUtils.getImagePath(
                                          'video_playlist_icn_playing'),
                                      height: 40.w,
                                      width: 40.h,
                                      color: Colors.red)
                                  : Image.asset(ImageUtils.getImagePath('c2w'),
                                      height: 40.w,
                                      width: 40.h,
                                      color: Colors.red))
                              : Text(
                                  '${index + 1}.',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                  ),
                                ),
                          title: Text(
                            songs[index].title!,
                            style: TextStyle(
                                color: isPlaying ? Colors.red : Colors.black),
                          ),
                          subtitle: Text(
                            songs[index].artist!,
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        );
                      }),
                    );
                  },
                  childCount: songs.length,
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0, // 确保有约束条件
              right: 0, //
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: const BottomPlayerBar(),
                ),
              ))
        ],
      ),
    );
  }
}
