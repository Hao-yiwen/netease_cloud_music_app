import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/pages/home/home_controller.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';

class BottomPlayerBar extends StatelessWidget {
  const BottomPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: GestureDetector(
          onTap: () {
            Roaming.showBottomPlayer(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20.w),
              Stack(
                children: [
                  Image.asset(
                    ImageUtils.getImagePath('play_disc_mask'),
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                      child: Image.asset(ImageUtils.getImagePath('play_disc'))),
                  Positioned.fill(
                      child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Transform.rotate(
                      angle: 0,
                      child: ClipOval(
                        child: Image.network(
                          "http://b.hiphotos.baidu.com/image/pic/item/9d82d158ccbf6c81b94575cfb93eb13533fa40a2.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(width: 20.w),
              Row(
                children: [
                  Text(
                    "Trouble I'm In",
                    style: TextStyle(
                        fontSize: 30.w,
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        // 指定字体族
                        decoration: TextDecoration.none),
                    overflow: TextOverflow.ellipsis, // 处理溢出文本
                  ),
                  Text(
                    "- Twinbed",
                    style: TextStyle(
                        fontSize: 26.w,
                        color: Colors.grey[500],
                        fontFamily: 'Roboto',
                        // 指定字体族
                        decoration: TextDecoration.none),
                    overflow: TextOverflow.ellipsis, // 处理溢出文本
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                ImageUtils.getImagePath('list_btn_play'),
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
                color: Colors.black,
              ),
              SizedBox(width: 25.w),
              Image.asset(
                ImageUtils.getImagePath('play_btn_src'),
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 25.w),
            ],
          ),
        ));
  }
}
