import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {super.key,
      required this.onTapHandle,
      required this.title,
      required this.subTitle,
      this.icon});

  final Function() onTapHandle;
  final String title;
  final String subTitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapHandle();
      },
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
                child: Text(title,
                    style: TextStyle(fontSize: 30.sp, color: Colors.white))),
            if (icon != null) Expanded(child: Icon(icon, size: 100.w)),
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
              height: 20.w,
            )
          ],
        ),
      ),
    );
  }
}
