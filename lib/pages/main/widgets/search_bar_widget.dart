import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:netease_cloud_music_app/common/constants/app_strings.dart';
import 'package:netease_cloud_music_app/pages/main/constants.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SearchBarWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MainConstants.headerHeight.w,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(Icons.search, size: 40.w),
                  const SizedBox(width: 10),
                  Text(
                    AppStrings.searchTitle,
                    style: TextStyle(fontSize: 25.sp),
                  ),
                ],
              ),
            ),
          ),
          Icon(TablerIcons.scan, size: 40.w)
        ],
      ),
    );
  }
}
