import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/pages/roaming/play_album_cover.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../../common/music_handler.dart';

class Roaming extends StatefulWidget {
  const Roaming({super.key});

  static void showBottomPlayer(BuildContext hostContext) {
    showModalBottomSheet(
      context: hostContext,
      isScrollControlled: true, // 允许高度控制
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1.0, // 占据整个屏幕高度
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 77, 77, 77),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w))),
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(hostContext).padding.top),
                child: Roaming()),
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void playMusic() async {
    await audioHandler.setUrl(controller.songInfo.value.url ?? '');
    audioHandler.play();
    controller.playStatus.value = 1;
  }

  void pauseMusic() {
    audioHandler.pause();
    controller.playStatus.value = 0;
  }

  void stopMusic() {
    audioHandler.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !controller.loading.value,
        child: Column(
          children: [
            _buildPlayerHeader(context),
            SizedBox(
              height: 60.w,
            ),
            Hero(
              tag: "test",
              child: PlayAlbumCover(
                rotating: true,
                pading: 40.w,
              ),
            ),
            SizedBox(
              height: 60.w,
            ),
            // 歌曲信息
            _buildPlayerMusicInfo(),
            // 进度条
            _buildProgressBar(),
            // 播放按钮
            _buildPlayerControl(context),
            // 底部按钮
            _buildBottomButton(context),
          ],
        ),
      );
    });
  }

  _buildPlayerHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            icon: Icon(TablerIcons.chevron_down,
                color: Colors.grey[400], size: 60.w),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ),
      ],
    );
  }

  _buildPlayerMusicInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Faraway',
                style: TextStyle(color: Colors.grey[400], fontSize: 36.w),
              ),
              SizedBox(
                height: 10.w,
              ),
              Text(
                'Gala',
                style: TextStyle(color: Colors.grey[400], fontSize: 26.w),
              ),
            ],
          ),
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
              SizedBox(
                width: 60.w,
              ),
              Image.asset(ImageUtils.getImagePath('detail_icn_cmt'),
                  width: 60.w, height: 60.w),
            ],
          )
        ],
      ),
    );
  }

  _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.w),
      child: ProgressBar(
        progress: Duration(milliseconds: 500),
        buffered: Duration(milliseconds: 2000),
        total: Duration(milliseconds: 5000),
        onSeek: (duration) {
          LogBox.info('Seek to: ${duration.inMilliseconds}');
        },
        thumbColor: Colors.white,
        barHeight: 2.0,
        thumbRadius: 5.0,
        timeLabelTextStyle: TextStyle(color: Colors.white, fontSize: 18.w),
        timeLabelPadding: 14.w,
      ),
    );
  }

  _buildPlayerControl(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            ImageUtils.getImagePath('play_btn_shuffle'),
            width: 50.w,
            height: 50.w,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(
          width: 55.w,
        ),
        IconButton(
          icon: Icon(
            TablerIcons.player_skip_back_filled,
            color: Colors.grey[400],
            size: 55.w,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 60.w,
        ),
        IconButton(
          icon: Obx(() {
            return Icon(
              controller.playStatus.value == 1
                  ? TablerIcons.player_pause_filled
                  : TablerIcons.player_play_filled,
              color: Colors.grey[400],
              size: 80.w,
            );
          }),
          onPressed: () {
            if (controller.playStatus.value == 1) {
              pauseMusic();
            } else {
              playMusic();
            }
          },
        ),
        SizedBox(
          width: 55.w,
        ),
        IconButton(
          icon: Icon(
            TablerIcons.player_skip_forward_filled,
            color: Colors.grey[400],
            size: 55.w,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 60.w,
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            ImageUtils.getImagePath('epj'),
            width: 70.w,
            height: 70.w,
          ),
        )
      ],
    );
  }

  _buildBottomButton(BuildContext context) {
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
          SizedBox(
            width: 140.w,
          ),
          IconButton(
            icon: Icon(
              TablerIcons.info_square,
              color: Colors.grey[500],
              size: 40.w,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 140.w,
          ),
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
}
