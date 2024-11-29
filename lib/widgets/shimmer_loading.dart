import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  final Widget child;
  const ShimmerLoading({super.key, required this.child});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment((-2 + 3 * _shimmerAnimation.value), 0),
              end: Alignment((-1 + 3 * _shimmerAnimation.value), 0),
              colors: isDark
                  ? const [
                      Color(0xFF303030),
                      Color(0xFF404040),
                      Color(0xFF404040),
                      Color(0xFF303030),
                    ]
                  : const [
                      Color(0xFFE0E0E0),
                      Color(0xFFE8E8E8),
                      Color(0xFFE8E8E8),
                      Color(0xFFE0E0E0),
                    ],
              stops: const [0.0, 0.3, 0.7, 1.0],
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
