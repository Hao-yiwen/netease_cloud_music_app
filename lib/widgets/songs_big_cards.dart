import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class SongsBigCards extends StatelessWidget {
  const SongsBigCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          height: 280.w,
          child: ListView(children:<Widget> [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: 250.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("每日推荐",
                            style: TextStyle(
                                fontSize: 30.sp, color: Colors.white))),
                    Icon(TablerIcons.calendar, size: 100.w),
                    Spacer(),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child:
                              Text("符合你口味的新鲜好歌", textAlign: TextAlign.center,),
                        )),
                    SizedBox(
                      height: 20.w,
                    )
                  ],
                ),
              ),
            ),
          ], scrollDirection: Axis.horizontal)),
    );
  }
}
