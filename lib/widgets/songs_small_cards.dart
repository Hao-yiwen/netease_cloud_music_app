import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongsSmallCards extends StatelessWidget{
  const SongsSmallCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          height: 198.w,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 168.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                ),
              );
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          )),
    );
  }

}