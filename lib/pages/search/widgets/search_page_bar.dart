import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageBar extends StatelessWidget {
  Function search;
  Function setTextValue;
  TextEditingController textEditingController;

  SearchPageBar(
      {super.key,
      required this.search,
      required this.setTextValue,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: '搜索歌曲、歌手、专辑',
                hintStyle: TextStyle(fontSize: 30.w),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setTextValue(value);
              },
              onSubmitted: (value) {
                search(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
