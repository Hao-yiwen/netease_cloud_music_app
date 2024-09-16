import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/common/constants/url.dart';
import 'package:netease_cloud_music_app/pages/roaming/roaming_controller.dart';
import 'package:netease_cloud_music_app/widgets/netease_cache_image.dart';

@RoutePage()
class CommentPage extends StatelessWidget {
  CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('评论'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Obx(() {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 20.w),
                  child: Text('评论(${RoamingController.to.commentCount.value})'),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: RoamingController.to.comments.length,
                    itemBuilder: (context, sectionIndex) {
                      return Column(
                        children: [
                          Container(
                            height: 50.0,
                            color: Colors.blueGrey[700],
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              RoamingController
                                      .to.comments.value[sectionIndex].title ??
                                  '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Column(
                            children: List.generate(
                                RoamingController.to.comments
                                        .value[sectionIndex].comments?.length ??
                                    0,
                                (itemIndex) => Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipOval(
                                              child: NeteaseCacheImage(
                                                picUrl: RoamingController
                                                        .to
                                                        .comments
                                                        .value[sectionIndex]
                                                        .comments?[itemIndex]
                                                        .user
                                                        ?.avatarUrl ??
                                                    PLACE_IMAGE_HOLDER,
                                                size: Size(55.w, 55.w),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      RoamingController
                                                              .to
                                                              .comments
                                                              .value[
                                                                  sectionIndex]
                                                              .comments?[
                                                                  itemIndex]
                                                              .user
                                                              ?.nickname ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    subtitle: Text(
                                                      RoamingController
                                                              .to
                                                              .comments
                                                              .value[
                                                                  sectionIndex]
                                                              .comments?[
                                                                  itemIndex]
                                                              .timeStr ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(
                                            left: 70.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                RoamingController
                                                        .to
                                                        .comments
                                                        .value[sectionIndex]
                                                        .comments?[itemIndex]
                                                        .content ??
                                                    '',
                                                style: const TextStyle(),
                                              ),
                                              SizedBox(height: 20.h),
                                              Container(
                                                height: 0.5.w,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          }),
        ));
  }
}
