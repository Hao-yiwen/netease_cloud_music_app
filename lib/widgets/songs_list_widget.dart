import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongsListWidget extends StatelessWidget {
  const SongsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // 固定的高度，每列高度
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.9, // 每列占90%的宽度
        ),
        itemCount: 6, // 总共6列
        itemBuilder: (context, pageIndex) {
          // 根据 pageIndex 计算偏移量
          double offsetX = ScreenUtil().screenWidth * 0.05 * (pageIndex - 1);

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Transform.translate(
              offset: Offset(offsetX, 0),
              child: Column(
                children: List.generate(3, (rowIndex) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.r),
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