import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkingText extends StatelessWidget {
  const LinkingText(
    this.text,
    this.onTap, {
    super.key,
  });

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: Color(0xff4158A6), fontSize: 24.w),
      ),
    );
  }
}
