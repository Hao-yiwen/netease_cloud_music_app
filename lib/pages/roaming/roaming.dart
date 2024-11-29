import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/constants/colors.dart';
import 'package:netease_cloud_music_app/common/constants/other.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/pages/roaming/play_album_cover.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/widgets/play_list.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

import '../../common/constants/app_strings.dart';
import '../../common/music_handler.dart';
import 'dart:math' as math;

class Roaming extends StatefulWidget {
  const Roaming({super.key});

  static void showBottomPlayer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, _, __) {
        final view = View.of(context);
        final viewPadding = view.padding;
        final mediaPadding = MediaQuery.paddingOf(context);
        final viewTopPadding = viewPadding.top / view.devicePixelRatio;
        final topPadding = math.max(viewTopPadding, mediaPadding.top);

        return Material(
          child: Container(
            padding:
                EdgeInsets.only(top: topPadding, bottom: mediaPadding.bottom),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppTheme.playPageBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w))),
            child: const Roaming(),
          ),
        );
      },
    );
  }

  @override
  State<Roaming> createState() => _RoamingState();
}

class _RoamingState extends State<Roaming> {
  final RoamingController controller = Get.find<RoamingController>();
  final audioHandler = GetIt.instance<MusicHandler>();
  var _showLyric = false;

  void _toggleLyric() {
    setState(() => _showLyric = !_showLyric);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPlayerHeader(context),
        const Spacer(),
        GestureDetector(
          onTap: _toggleLyric,
          child: _showLyric ? _buildLyric() : _buildPlayer(),
        ),
        const Spacer(),
        _buildPlayerMusicInfo(),
        _buildProgressBar(),
        _buildPlayerControl(context),
        _buildBottomButton(context)
      ],
    );
  }

  Widget _buildPlayerHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            icon: Icon(TablerIcons.chevron_down,
                color: Colors.grey[400], size: 60.w),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Text(
          '你的红心歌曲和相似推荐',
          style: TextStyle(color: Colors.grey[300]),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: IconButton(
            icon: Icon(TablerIcons.share, color: Colors.grey[400], size: 45.w),
            onPressed: () => WidgetUtil.showToast(AppStrings.waitDevelop),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerMusicInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            final mediaItem = controller.mediaItem.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400.w),
                  child: Text(
                    mediaItem.title.fixAutoLines(),
                    style: TextStyle(color: Colors.grey[400], fontSize: 36.w),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10.w),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400.w),
                  child: Text(
                    (mediaItem.artist ?? '').fixAutoLines(),
                    style: TextStyle(color: Colors.grey[400], fontSize: 26.w),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  TablerIcons.heart_plus,
                  color: Colors.grey[400],
                  size: 60.w,
                ),
                onPressed: () {},
              ),
              SizedBox(width: 60.w),
              GestureDetector(
                onTap: () =>
                    GetIt.instance<AppRouter>().pushNamed(Routes.comment),
                child: Image.asset(ImageUtils.getImagePath('detail_icn_cmt'),
                    width: 60.w, height: 60.w),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Obx(() {
      final duration = controller.duration.value;
      final mediaItem = controller.mediaItem.value;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
        child: ProgressBar(
          progress: duration,
          buffered: duration,
          total: mediaItem.duration!,
          onSeek: (duration) {
            LogBox.info('Seek to: ${duration.inMilliseconds}');
            controller.audioHandler.seek(duration);
          },
          thumbColor: Colors.white,
          barHeight: 2.0,
          thumbRadius: 5.0,
          timeLabelTextStyle: TextStyle(color: Colors.white, fontSize: 18.w),
          timeLabelPadding: 14.w,
        ),
      );
    });
  }

  Widget _buildPlayerControl(BuildContext context) {
    return Obx(() {
      final isPlaying = controller.playing.value;
      final isFm = controller.fm.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: controller.changeRepeatMode,
              icon: Icon(
                controller.getRepeatIcon(),
                size: 43.w,
                color: Colors.grey[400],
              )),
          SizedBox(width: 55.w),
          IconButton(
            icon: Icon(
              TablerIcons.player_skip_back_filled,
              color: Colors.grey[400],
              size: 55.w,
            ),
            onPressed: () {
              if (!isFm && controller.intervalClick()) {
                controller.audioHandler.skipToPrevious();
              }
            },
          ),
          SizedBox(width: 60.w),
          IconButton(
            icon: Icon(
              isPlaying
                  ? TablerIcons.player_pause_filled
                  : TablerIcons.player_play_filled,
              color: Colors.grey[400],
              size: 80.w,
            ),
            onPressed: controller.playOrPause,
          ),
          SizedBox(width: 55.w),
          IconButton(
            icon: Icon(
              TablerIcons.player_skip_forward_filled,
              color: Colors.grey[400],
              size: 55.w,
            ),
            onPressed: () {
              if (controller.intervalClick()) {
                controller.audioHandler.skipToNext();
              }
            },
          ),
          SizedBox(width: 60.w),
          GestureDetector(
            onTap: () => _showPlaylist(context),
            child: Image.asset(
              ImageUtils.getImagePath('epj'),
              width: 70.w,
              height: 70.w,
            ),
          ),
        ],
      );
    });
  }

  void _showPlaylist(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return Obx(() {
            return Container(
              padding: EdgeInsets.only(top: 40.w, left: 20.w, right: 20.w),
              child: PlayList(
                mediaItems: controller.mediaItems,
                currentItem: controller.mediaItem.value,
                onItemTap: (index) {
                  controller.playByIndex(index, 'roaming',
                      mediaItem: controller.mediaItems);
                },
                playing: controller.playing.value,
              ),
            );
          });
        });
  }

  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              TablerIcons.devices,
              color: Colors.grey[500],
              size: 40.w,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 140.w),
          IconButton(
            icon: Icon(
              TablerIcons.info_square,
              color: Colors.grey[500],
              size: 40.w,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 140.w),
          IconButton(
            icon: Icon(
              TablerIcons.dots,
              color: Colors.grey[500],
              size: 40.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLyric() {
    return Container(
      constraints: BoxConstraints(maxHeight: 620.h, maxWidth: 620.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final model in controller.lyricLineModels)
              Text(
                model.mainText ?? '',
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontSize: 30.w, height: 2),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return Obx(() {
      final mediaItem = controller.mediaItem.value;
      return PlayAlbumCover(
        rotating: controller.playing.value,
        pading: 40.w,
        imgPic: '${mediaItem.extras?['image'] ?? PLACE_IMAGE_HOLDER}',
      );
    });
  }
}

extension FixAutoLines on String {
  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }
}
