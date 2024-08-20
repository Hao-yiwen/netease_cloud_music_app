import 'package:auto_route/annotations.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

@RoutePage()
class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final List<String> _moments = List.generate(20, (index) => 'moment $index');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(
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
        SizedBox(width: 10),
        GestureDetector(
          child: Icon(
            TablerIcons.menu_2,
            size: 40.w,
          ),
          onTap: () {},
        ),
        SizedBox(width: 10),
        Spacer(),
        SizedBox(width: 10),
        GestureDetector(
          child: Container(
            width: 50.w, // 根据你的需求调整宽度和高度
            height: 50.w,
            decoration: BoxDecoration(
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
      child: EasyRefresh(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Banner',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_moments[index]),
                    );
                  },
                  childCount: _moments.length,
                ),
              ),
            ],
          )),
    );
  }
}
