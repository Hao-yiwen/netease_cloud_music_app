import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../widgets/bottom_player_bar.dart';

@RoutePage()
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Center(
                child: Icon(
              TablerIcons.chevron_left,
              size: 60.w,
            )),
          ),
        ),
        leadingWidth: 40,
        title: _buildSearchBar(),
        actions: [
          SizedBox(
            width: 15,
          ),
          Text('搜索', style: TextStyle(fontSize: 30.w)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildContent(),
          Positioned(
              bottom: 0,
              left: 0, // 确保有约束条件
              right: 0, //
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomPadding),
                  child: BottomPlayerBar(),
                ),
              ))
        ],
      ),
    );
  }

  _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.search),
          Text('搜索歌曲、歌手、专辑',
              style: TextStyle(color: Colors.grey, fontSize: 30.w)),
        ],
      ),
    );
  }

  _buildContent() {
    return Center(
      child: Text('Search Page'),
    );
  }
}
