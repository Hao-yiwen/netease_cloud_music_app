import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {super.key,
      required this.onTapHandle,
      required this.title,
      required this.subTitle,
      this.icon,
      this.cardPic});

  final Function() onTapHandle;
  final String title;
  final String subTitle;
  final IconData? icon;
  final String? cardPic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapHandle();
      },
      child: Container(
        width: 250.w,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20.w),
            image: cardPic != null
                ? DecorationImage(
                    image:
                        NeteaseCacheImage(picUrl: cardPic!).getImageProvider(),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.colorBurn),
                  )
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          icon,
                          size: 30.w,
                          color: Colors.white,
                        ),
                      ),
                    Text(title,
                        style: TextStyle(
                            fontSize: 26.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                  ])),
            ),
            const Spacer(),
            SizedBox(
              height: 70.w,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          subTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
