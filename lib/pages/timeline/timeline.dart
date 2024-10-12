import 'package:auto_route/annotations.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/timeline/timeline_controller.dart';
import 'package:netease_cloud_music_app/widgets/user_event_widget.dart';

import '../home/home_controller.dart';

@RoutePage()
class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final controller = TimelineController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(
            height: 10,
          ),
          _buildCOntainet()
        ],
      ),
    );
  }

  _buildHeader() {
    return Row(
      children: [
        const SizedBox(width: 10),
        GestureDetector(
          child: Icon(
            TablerIcons.menu_2,
            size: 40.w,
          ),
          onTap: () {
            HomeController.to.scaffoldKey.value.currentState?.openDrawer();
          },
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "广场",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h), // Text 与底部线条之间的间距
              Container(
                width: 30.w, // 底部线条的宽度
                height: 4.h, // 底部线条的高度
                color: Colors.deepOrange, // 底部线条的颜色
              ),
            ],
          ),
        )),
        const SizedBox(width: 10),
        GestureDetector(
          child: Container(
            width: 50.w, // 根据你的需求调整宽度和高度
            height: 50.w,
            decoration: const BoxDecoration(
              color: Colors.red, // 设置外面圆的颜色为红色
              shape: BoxShape.circle, // 确保形状为圆形
            ),
            child: Icon(
              TablerIcons.plus,
              color: Colors.white, // 图标颜色为白色
              size: 40.w,
            ),
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _buildCOntainet() {
    return Expanded(
      child: Obx(() {
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
          onRefresh: () async {
            controller.refreshTopics();
          },
          child: (controller.hotTopicsEvents.value.events == null ||
                  controller.hotTopicsEvents.value.events!.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : UserEventWidget(
                  events: controller.hotTopicsEvents.value.events,
                  showVip: false,
                ),
        );
      }),
    );
  }
}
