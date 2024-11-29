import 'package:auto_route/annotations.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/mv_player/mv_player_controller.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class MvPlayer extends StatefulWidget {
  final String title;
  final int id;
  final String artist;

  const MvPlayer({
    super.key,
    required this.title,
    required this.id,
    required this.artist,
  });

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
    final mvUrl = controller.mvDetail.value.data?.url;

    if (mvUrl != null && mvUrl.isNotEmpty) {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(mvUrl));
      await _videoPlayerController.initialize();

      if (mounted) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
            aspectRatio: 16 / 9,
            allowFullScreen: true,
            allowMuting: true,
            showControls: true,
            showControlsOnInitialize: true,
            showOptions: false,
            placeholder: Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
      }
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
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36.sp,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return SizedBox(
              width: 1.sw,
              height: 1.sh / 3,
              child: controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : _chewieController != null
                      ? OrientationBuilder(
                          builder: (context, orientation) {
                            if (orientation == Orientation.landscape) {
                              return SizedBox(
                                width: 1.sw,
                                height: 1.sh,
                                child: Chewie(controller: _chewieController!),
                              );
                            }
                            return Chewie(controller: _chewieController!);
                          },
                        )
                      : const SizedBox.shrink(),
            );
          }),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.w),
                  Text(
                    "演唱者: ${widget.artist}",
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
