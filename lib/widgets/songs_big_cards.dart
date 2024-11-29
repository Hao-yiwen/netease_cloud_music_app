import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class SongsBigCards extends StatelessWidget {
  const SongsBigCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: SizedBox(
        height: 280.w,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildDailyRecommendCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyRecommendCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Container(
        width: 250.w,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.w),
                child: Text(
                  "每日推荐",
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Icon(
              TablerIcons.calendar,
              size: 100.w,
              color: Colors.white,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "符合你口味的新鲜好歌",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.w),
          ],
        ),
      ),
    );
  }
}
