import 'package:audio_service/audio_service.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/colours.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

import '../../common/utils/debouncer.dart';
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
  final _debouncer = Debouncer(milliseconds: 500);

  SongsList(
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
          Container(
            color: Theme.of(context).cardColor,
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      title: Text(
                        title,
                        style: TextStyle(
                          color: top > 200 ? Colors.white : Colors.black,
                          fontWeight:
                              top > 200 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 35.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          NeteaseCacheImage(
                            picUrl: picUrl,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _debouncer.run(() {
                          RoamingController.to.playByIndex(index, 'queueTitle',
                              mediaItem: songs);
                          Roaming.showBottomPlayer(context);
                        });
                      },
                      child: Obx(() {
                        return ListTile(
                          leading: RoamingController.to.mediaItem ==
                                  songs[index]
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: RoamingController.to.mediaItem ==
                                        songs[index]
                                    ? Colours.app_main
                                    : Theme.of(context).colorScheme.onPrimary),
                          ),
                          subtitle: Text(
                            songs[index].artist!,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.7),
                                fontSize: Theme.of(context)
                                        .textTheme
                                        ?.bodySmall
                                        ?.fontSize ??
                                    14.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
}
