import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';

class NeteaseCacheImage extends StatelessWidget {
  final String picUrl;
  final Size? size;
  final Color? color;
  final BoxFit fit;

  const NeteaseCacheImage({
    super.key,
    required this.picUrl,
    this.size,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: picUrl,
      height: size?.height,
      width: size?.width,
      fit: fit,
      color: color,
      colorBlendMode: color != null ? BlendMode.colorBurn : null,
      httpHeaders: const {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Referer': 'https://music.163.com',
      },
      placeholder: (context, url) => Image.asset(
        ImageUtils.getImagePath("placeholder"),
        height: size?.height,
        width: size?.width,
        fit: fit,
        color: color,
        colorBlendMode: color != null ? BlendMode.colorBurn : null,
      ),
      errorWidget: (context, url, error) => Image.asset(
        ImageUtils.getImagePath("placeholder"),
        height: size?.height,
        width: size?.width,
        fit: fit,
        color: color,
        colorBlendMode: color != null ? BlendMode.colorBurn : null,
      ),
    );
  }
}
