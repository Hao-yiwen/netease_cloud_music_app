import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common/constants/colors.dart';
import '../common/utils/datetime.dart';
import '../common/utils/image_utils.dart';
import '../http/api/timeline/dto/events.dart';
import 'netease_cache_image.dart';

class UserEventWidget extends StatelessWidget {
  UserEventWidget(
      {super.key, required this.events, this.canScroll, this.showVip}) {
    canScroll ??= true;
    showVip ??= true;
  }

  final List<Event>? events;
  bool? canScroll;
  bool? showVip;

  @override
  Widget build(BuildContext context) {
    if (events == null || events!.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        padding:
            EdgeInsets.only(top: 20.w, bottom: 100.w, left: 20.w, right: 20.w),
        itemBuilder: (context, index) {
          final event = events![index];
          Map<String, dynamic> jsonMap = {};
          if (event?.json != null) {
            String jsonString = event!.json!;
            jsonString = jsonString.replaceAll('\\', '');
            jsonMap = jsonDecode(event!.json!);
          }
          return Container(
            padding: EdgeInsets.only(top: 20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: NeteaseCacheImage(
                    picUrl: event?.user?.avatarUrl ?? "",
                    size: Size(50.w, 50.w),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              event?.user?.nickname ?? "",
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            if (showVip!)
                              NeteaseCacheImage(
                                  picUrl: event?.user?.vipRights?.associator
                                          ?.iconUrl ??
                                      "",
                                  color: Colors.transparent,
                                  size: Size(90.w, 30.w)),
                          ],
                        ),
                        Text(
                          FormatTime(event?.eventTime ?? 0),
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: AppTheme.userScrollColor,
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Text(jsonMap["msg"] ?? "",
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 26.sp)),
                        SizedBox(height: 20.w),
                        // 图片展示
                        _buildPicsShow(context, event),
                        SizedBox(
                          height: 20.w,
                        ),
                        // 底部按钮
                        Container(
                          height: 60.h,
                          padding: EdgeInsets.only(bottom: 30.w),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Image.asset(
                                        ImageUtils.getImagePath('icn_share'),
                                        width: 40.w,
                                        height: 40.w,
                                        color: Colors.grey[600]),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "分享",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 22.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 50.w),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Image.asset(
                                        ImageUtils.getImagePath(
                                            'detail_icn_cmt'),
                                        width: 40.w,
                                        height: 40.w,
                                        color: Colors.grey[600]),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      "评论",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 22.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 50.w),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImageUtils.getImagePath('even_like'),
                                      width: 45.w,
                                      height: 45.w,
                                      color: Colors.grey[600],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: events!.length,
        physics: canScroll!
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
      );
    }
    ;
  }

  _buildPicsShow(BuildContext context, Event event) {
    // 3x3
    // 2x2
    // 1
    if (event!.pics!.length >= 4) {
      return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(event?.pics?.length ?? 0, (index) {
          double imageWidth = event?.pics?[index]?.width?.toDouble() ?? 90.w;
          double imageHeight = event?.pics?[index]?.height?.toDouble() ?? 90.h;
          imageHeight = imageHeight / 3;
          imageWidth = imageWidth / 3;
          return NeteaseCacheImage(
            picUrl: event?.pics?[index].originUrl ?? "",
            size: Size(ScreenUtil().setWidth(imageWidth),
                ScreenUtil().setWidth(imageHeight)),
          );
        }),
      );
    } else if (event!.pics!.length >= 2 && event!.pics!.length < 4) {
      return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(event?.pics?.length ?? 0, (index) {
          double imageWidth = event?.pics?[index]?.width?.toDouble() ?? 120.w;
          double imageHeight = event?.pics?[index]?.height?.toDouble() ?? 120.h;
          imageHeight = imageHeight / 3;
          imageWidth = imageWidth / 3;
          return NeteaseCacheImage(
            picUrl: event?.pics?[index].originUrl ?? "",
            size: Size(ScreenUtil().setWidth(imageWidth),
                ScreenUtil().setWidth(imageHeight)),
          );
        }),
      );
    } else if (event!.pics!.length == 1) {
      double imageWidth = event?.pics?[0]?.width?.toDouble() ?? 180.w;
      double imageHeight = event?.pics?[0]?.height?.toDouble() ?? 180.h;
      imageHeight = imageHeight / 3;
      imageWidth = imageWidth / 3;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300.w,
          maxHeight: 600.w,
        ),
        child: NeteaseCacheImage(
          picUrl: event?.pics?[0].originUrl ?? "",
          size: Size(ScreenUtil().setWidth(imageWidth),
              ScreenUtil().setWidth(imageHeight)),
        ),
      );
    } else {
      return Container();
    }
  }
}
