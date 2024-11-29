import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/common/utils/log_box.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../pages/roaming/widgets/play_list.dart';

class BottomPlayerBar extends StatefulWidget {
  const BottomPlayerBar({super.key});

  @override
  State<BottomPlayerBar> createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar>
    with TickerProviderStateMixin {
  final RoamingController controller = Get.find<RoamingController>();
  late final AnimationController _controller;
  double rotation = 0;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  void _initAnimationController() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..addListener(_updateRotation)
          ..addStatusListener(_handleAnimationStatus);

    if (controller.playing.value) {
      _controller.forward(from: _controller.value);
    }

    ever(controller.playing, _handlePlayingStateChange);
  }

  void _updateRotation() {
    setState(() {
      rotation = _controller.value * 2 * 3.14;
    });
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && controller.playing.value) {
      _controller.forward(from: _controller.value);
    }
    if (status == AnimationStatus.completed && _controller.value == 1) {
      _controller.forward(from: 0);
    }
  }

  void _handlePlayingStateChange(bool isPlaying) {
    if (isPlaying) {
      _controller.forward(from: _controller.value);
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: GestureDetector(
        onTap: () => Roaming.showBottomPlayer(context),
        child: Obx(() => _buildPlayerContent(context)),
      ),
    );
  }

  Widget _buildPlayerContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 20.w),
        _buildAlbumImage(),
        SizedBox(width: 20.w),
        Expanded(child: _buildSongInfo(context)),
        _buildControlButtons(context),
        SizedBox(width: 30.w),
      ],
    );
  }

  Widget _buildSongInfo(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Text(
            controller.mediaItem.value.title,
            style: TextStyle(
              fontSize: 30.w,
              color: Theme.of(context).colorScheme.onPrimary,
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            "- ${controller.mediaItem.value.artist}",
            style: TextStyle(
              fontSize: 26.w,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              fontFamily: 'Roboto',
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButtons(BuildContext context) {
    return Row(
      children: [
        _buildPlayPauseButton(context),
        SizedBox(width: 30.w),
        _buildPlaylistButton(context),
      ],
    );
  }

  Widget _buildPlayPauseButton(BuildContext context) {
    return GestureDetector(
      onTap: controller.playOrPause,
      child: Image.asset(
        !controller.playing.value
            ? ImageUtils.getImagePath('btn_play')
            : ImageUtils.getImagePath('btn_pause'),
        width: 55.w,
        height: 55.w,
        fit: BoxFit.cover,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildPlaylistButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPlaylist(context),
      child: Image.asset(
        ImageUtils.getImagePath('play_btn_src'),
        width: 40.w,
        height: 40.w,
        fit: BoxFit.cover,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  void _showPlaylist(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          LogBox.info('mediaItems: ${controller.mediaItems}');
          return Obx(() => Container(
                padding: EdgeInsets.only(top: 40.w, left: 20.w, right: 20.w),
                child: PlayList(
                  mediaItems: controller.mediaItems,
                  currentItem: controller.mediaItem.value,
                  onItemTap: (index) => controller.playByIndex(index, 'roaming',
                      mediaItem: controller.mediaItems),
                  playing: controller.playing.value,
                ),
              ));
        });
  }

  Widget _buildAlbumImage() {
    return Stack(
      children: [
        Image.asset(
          ImageUtils.getImagePath('play_disc_mask'),
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Transform.rotate(
              angle: rotation,
              child: ClipOval(
                child: Image.network(
                  controller.mediaItem.value.extras?["image"] ??
                      PLACE_IMAGE_HOLDER,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
            child: Image.asset(ImageUtils.getImagePath('play_disc'))),
      ],
    );
  }
}
