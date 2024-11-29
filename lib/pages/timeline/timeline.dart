import 'package:auto_route/annotations.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/timeline/timeline_controller.dart';
import 'package:netease_cloud_music_app/widgets/user_event_widget.dart';

import '../../widgets/shimmer_loading.dart';
import '../home/home_controller.dart';

@RoutePage()
class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final TimelineController controller = TimelineController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [_buildHeader(), SizedBox(height: 10.h), _buildContent()],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () =>
                HomeController.to.scaffoldKey.value.currentState?.openDrawer(),
            child: Icon(TablerIcons.menu_2, size: 40.w),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "广场",
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 30.w,
                  height: 4.h,
                  color: Colors.deepOrange,
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                TablerIcons.plus,
                color: Colors.white,
                size: 40.w,
              ),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.w),
          child: ShimmerLoading(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        SizedBox(height: 5.w),
                        Container(
                          width: 60.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.w),
                Container(
                  width: double.infinity,
                  height: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Obx(() {
        final events = controller.hotTopicsEvents.value.events;

        return EasyRefresh(
          header: const ClassicHeader(
            dragText: "下拉刷新",
            armedText: "释放刷新",
            processedText: "刷新完成",
            failedText: "刷新失败",
            noMoreText: "没有更多数据",
            readyText: "正在刷新...",
            messageText: "上次刷新时间 %T",
          ),
          onRefresh: controller.refreshTopics,
          child: events == null || events.isEmpty
              ? _buildShimmerLoading()
              : UserEventWidget(
                  events: events,
                  showVip: false,
                ),
        );
      }),
    );
  }
}
