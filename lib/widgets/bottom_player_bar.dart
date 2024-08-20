import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class BottomPlayerBar extends StatelessWidget {
  const BottomPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Icon(
              TablerIcons.brand_netease_music,
              size: 40,
            ),
            SizedBox(width: 10),
            Text(
              '播放条占位~',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  // 指定字体族
                  decoration: TextDecoration.none),
              overflow: TextOverflow.ellipsis, // 处理溢出文本
            ),
            Spacer(),
            Icon(TablerIcons.player_play, size: 20),
            SizedBox(width: 10),
            Icon(TablerIcons.music, size: 20),
            SizedBox(width: 20),
          ],
        ));
  }
}
