import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class Roaming extends GetView<Roaming> {
  const Roaming({super.key});

  static void showBottomPlayer(BuildContext hostContext) {
    showModalBottomSheet(
      context: hostContext,
      isScrollControlled: true, // 允许高度控制
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1.0, // 占据整个屏幕高度
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 77, 77, 77),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w))),
            child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(hostContext).padding.top),
                child: Roaming()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildPlayerHeader(context)],
    );
  }

  _buildPlayerHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            icon: Icon(TablerIcons.chevron_down,
                color: Colors.grey[400], size: 60.w),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Text(
          '你的红心歌曲和相似推荐',
          style: TextStyle(color: Colors.grey[300]),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: IconButton(
            icon: Icon(TablerIcons.share, color: Colors.grey[400], size: 45.w),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ),
      ],
    );
  }
}
