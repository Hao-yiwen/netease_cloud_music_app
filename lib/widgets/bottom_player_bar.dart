import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';
import 'package:netease_cloud_music_app/common/utils/image_utils.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';

import '../pages/roaming/widgets/play_list.dart';

class BottomPlayerBar extends GetView<RoamingController> {
  const BottomPlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: GestureDetector(
          onTap: () {
            Roaming.showBottomPlayer(context);
          },
          child: Obx(() {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.w),
                _buildAlbumImage(),
                SizedBox(width: 20.w),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          controller.mediaItem.value.title,
                          style: TextStyle(
                              fontSize: 30.w,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontFamily: 'Roboto',
                              // 指定字体族
                              decoration: TextDecoration.none),
                          overflow: TextOverflow.ellipsis, // 处理溢出文本
                          maxLines: 1,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          "- ${controller.mediaItem.value.artist}",
                          style: TextStyle(
                              fontSize: 26.w,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.7),
                              fontFamily: 'Roboto',
                              // 指定字体族
                              decoration: TextDecoration.none),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // 处理溢出文本
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.playOrPause();
                  },
                  child: Image.asset(
                    !controller.playing.value
                        ? ImageUtils.getImagePath('btn_play')
                        : ImageUtils.getImagePath('btn_pause'),
                    width: 55.w,
                    height: 55.w,
                    fit: BoxFit.cover,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(width: 30.w),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return Obx(() {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 40.w, left: 20.w, right: 20.w),
                              child: PlayList(
                                mediaItems: controller.mediaItems,
                                currentItem: controller.mediaItem.value,
                                onItemTap: (index) {
                                  controller.playByIndex(index, 'roaming',
                                      mediaItem: controller.mediaItems);
                                },
                                playing: controller.playing.value,
                              ),
                            );
                          });
                        });
                  },
                  child: Image.asset(
                    ImageUtils.getImagePath('play_btn_src'),
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            );
          }),
        ));
  }

  _buildAlbumImage() {
    return Stack(
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
                controller.mediaItem.value.extras?["image"] ??
                    PLACE_IMAGE_HOLDER,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
      ],
    );
  }
}
