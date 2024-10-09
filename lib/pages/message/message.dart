import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netease_cloud_music_app/pages/message/message_controller.dart';

import '../../widgets/bottom_player_bar.dart';

@RoutePage()
class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
              bottom: 0,
              left: 0, // 确保有约束条件
              right: 0, //
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: BottomPlayerBar(),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Obx(() {
      return controller.loading.value
          ? Center(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(bottom: 64.w),
              child: ListView.builder(
                itemCount: controller.privateMessage.value.msgs?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = controller.privateMessage.value.msgs?[index];
                  var lastMsg = "";
                  if (controller.privateMessage.value.msgs?[index].lastMsg !=
                      null) {
                    // jsonString = jsonString.replaceAll(r'\\', '');
                    Map<String, dynamic> jp = json.decode(
                        controller.privateMessage.value.msgs?[index].lastMsg ??
                            "");
                    if (jp['msg'] != null) {
                      lastMsg = jp['msg'];
                    }
                  }
                  return ListTile(
                    title: Text(item?.fromUser?.nickname ?? ""),
                    subtitle: Text(
                      lastMsg,
                      maxLines: 1,
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(item?.fromUser?.avatarUrl ?? ""),
                    ),
                  );
                },
              ),
            );
    });
  }
}
