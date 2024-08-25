import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';

class PlayAlbumCover extends StatefulWidget {
  const PlayAlbumCover(
      {super.key, required this.rotating, required this.pading});

  final bool rotating;
  final double pading;

  @override
  State<PlayAlbumCover> createState() => _PlayAlbumCoverState();
}

class _PlayAlbumCoverState extends State<PlayAlbumCover>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  double rotation = 0;
  late Animation<double> _needleAnimation;
  late AnimationController _needleController;

  @override
  void didUpdateWidget(covariant PlayAlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      if (widget.rotating) {
        _controller.forward(from: _controller.value);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..addListener(() {
            setState(() {
              rotation = _controller.value * 2 * 3.14;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed && widget.rotating) {
              _controller.forward(from: _controller.value);
            }
            if (status == AnimationStatus.completed && _controller.value == 1) {
              _controller.forward(from: 0);
            }
          });
    _needleController = AnimationController(
        value: 1, vsync: this, duration: const Duration(milliseconds: 500));
    _needleAnimation = Tween<double>(begin: -1 / 12, end: -1 / 36)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_needleController);
    if (widget.rotating) {
      _controller.forward(from: _controller.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _needleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 40.w,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 130.w),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 620.w,
                    maxHeight: 620.w,
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        ImageUtils.getImagePath('play_disc_mask'),
                        fit: BoxFit.cover,
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned.fill(
                                child: Padding(
                              padding: EdgeInsets.all(widget.pading),
                              child: Transform.rotate(
                                angle: rotation,
                                child: ClipOval(
                                  child: Image.network(
                                    "http://b.hiphotos.baidu.com/image/pic/item/9d82d158ccbf6c81b94575cfb93eb13533fa40a2.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )),
                            Positioned.fill(
                                child: Image.asset(
                                    ImageUtils.getImagePath('play_disc'))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -1),
              child: Transform.translate(
                offset: Offset(30, -12),
                child: RotationTransition(
                  alignment:
                      Alignment(-1 + 46.w * 2 / 182.w, -1 + 46.w * 2 / 294.w),
                  turns: _needleAnimation,
                  child: Image.asset(
                      ImageUtils.getImagePath('play_needle_play'),
                      height: 360.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
