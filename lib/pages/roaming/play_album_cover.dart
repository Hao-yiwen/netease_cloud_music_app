import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';

class PlayAlbumCover extends StatefulWidget {
  const PlayAlbumCover({
    super.key,
    required this.rotating,
    required this.pading,
    required this.imgPic,
  });

  final bool rotating;
  final double pading;
  final String imgPic;

  @override
  State<PlayAlbumCover> createState() => _PlayAlbumCoverState();
}

class _PlayAlbumCoverState extends State<PlayAlbumCover>
    with TickerProviderStateMixin {
  static const _rotationDuration = Duration(seconds: 20);
  static const _needleDuration = Duration(milliseconds: 500);
  static const _needleStartAngle = -1 / 12;
  static const _needleEndAngle = -1 / 36;

  late final AnimationController _rotationController;
  late final AnimationController _needleController;
  late final Animation<double> _needleAnimation;

  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    _initControllers();
    if (widget.rotating) {
      _rotationController.forward();
    }
  }

  void _initControllers() {
    _rotationController = AnimationController(
      vsync: this,
      duration: _rotationDuration,
    )
      ..addListener(_updateRotation)
      ..addStatusListener(_handleRotationStatus);

    _needleController = AnimationController(
      value: 1,
      vsync: this,
      duration: _needleDuration,
    );

    _needleAnimation = Tween<double>(
      begin: _needleStartAngle,
      end: _needleEndAngle,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_needleController);
  }

  void _updateRotation() {
    setState(() {
      _rotation = _rotationController.value * 2 * 3.14;
    });
  }

  void _handleRotationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && widget.rotating) {
      _rotationController.forward();
    }
    if (status == AnimationStatus.completed) {
      _rotationController.forward(from: 0);
    }
  }

  @override
  void didUpdateWidget(PlayAlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (mounted) {
      widget.rotating
          ? _rotationController.forward(from: _rotationController.value)
          : _rotationController.stop();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _needleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.w),
        child: Stack(
          children: [
            _buildAlbumDisc(),
            _buildNeedle(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumDisc() {
    return Padding(
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
                    _buildRotatingImage(),
                    Positioned.fill(
                      child: Image.asset(ImageUtils.getImagePath('play_disc')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRotatingImage() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(widget.pading),
        child: Transform.rotate(
          angle: _rotation,
          child: ClipOval(
            child: Image.network(
              widget.imgPic,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNeedle() {
    return Align(
      alignment: const Alignment(0, -1),
      child: Transform.translate(
        offset: const Offset(30, -12),
        child: RotationTransition(
          alignment: Alignment(-1 + 46.w * 2 / 182.w, -1 + 46.w * 2 / 294.w),
          turns: _needleAnimation,
          child: Image.asset(
            ImageUtils.getImagePath('play_needle_play'),
            height: 360.w,
          ),
        ),
      ),
    );
  }
}
