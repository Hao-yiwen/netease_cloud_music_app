import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';

import '../common/constants/url.dart';

// 图片请求需要带上请求头 否则概率403
class NeteaseCacheImage extends StatelessWidget {
  final String picUrl;
  final Size? size;
  final Color? color;

  NeteaseCacheImage({
    super.key,
    required this.picUrl,
    this.size,
    this.color,
  });

  ImageProvider getImageProvider() {
    return CachedNetworkImageProvider(
      picUrl,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Referer': 'https://music.163.com',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: getImageProvider(),
      height: size?.height,
      width: size?.width,
      fit: BoxFit.cover,
      color: color ?? Colors.transparent,
      colorBlendMode: BlendMode.colorBurn,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(ImageUtils.getImagePath("placeholder"),
            height: size?.height,
            width: size?.width,
            fit: BoxFit.cover,
            color: color ?? Colors.transparent,
            colorBlendMode: BlendMode.colorBurn);
      },
    );
  }
}
