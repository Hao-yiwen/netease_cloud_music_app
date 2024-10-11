import 'package:auto_route/annotations.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/mv_player/mv_player_controller.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class MvPlayer extends StatefulWidget {
  String title;
  int id;
  String artist;

  MvPlayer(
      {super.key, required this.title, required this.id, required this.artist});

  @override
  State<MvPlayer> createState() => _MvPlayerState();
}

class _MvPlayerState extends State<MvPlayer> {
  final MvPlayerController controller = MvPlayerController.to;
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _fetchMvDetail();
  }

  Future<void> _fetchMvDetail() async {
    await controller.getMvDetail(widget.id);
    print('mvDetail: ${controller.mvDetail.value.data?.url ?? 'null'}');
    if (controller.mvDetail.value.data != null &&
        controller.mvDetail.value.data?.url != null &&
        controller.mvDetail.value.data!.url!.isNotEmpty) {
      _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(controller.mvDetail.value.data!.url!));
      await _videoPlayerController.initialize();
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: true,
          aspectRatio: 16 / 9,
          allowFullScreen: true,
          allowMuting: true,
          showControls: true,
          showControlsOnInitialize: true,
          showOptions: false,
        );
      });
    } else {
      print('Video URL is null or empty');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (controller.loading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_chewieController != null) {
                // 如果是横屏则使用全屏
                if (MediaQuery.of(context).orientation ==
                    Orientation.landscape) {
                  return SizedBox(
                    width: 1.sw, // 使用屏幕宽度
                    height: 1.sh, // 使用屏幕高度
                    child: Chewie(controller: _chewieController!),
                  );
                }
                return SizedBox(
                  width: 1.sw, // 使用屏幕宽度
                  height: 1.sh / 3, // 屏幕高度的三分之一
                  child: Chewie(controller: _chewieController!),
                );
              }
              return const Center();
            }),
            SizedBox(
              height: 20.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                textAlign: TextAlign.left,
                "作者:" + widget.artist ?? '',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
