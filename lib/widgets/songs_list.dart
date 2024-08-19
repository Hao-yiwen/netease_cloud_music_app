import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongsList extends StatelessWidget {
  const SongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // 固定的高度，每列高度
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.9, // 每列占90%的宽度
          initialPage: -1, // 通过设置负的初始页面，消除初始空白
        ),
        itemCount: 6, // 总共6列
        itemBuilder: (context, pageIndex) {
          return Transform.translate(
            offset: Offset(-ScreenUtil().screenWidth * 0.05, 0),
            // 通过偏移纠正显示
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: List.generate(3, (rowIndex) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('歌曲 ${pageIndex * 3 + rowIndex + 1}'),
                      ),
                    ),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
