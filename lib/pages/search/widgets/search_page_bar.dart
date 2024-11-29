import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageBar extends StatelessWidget {
  final Function(BuildContext) search;
  final Function(String) setTextValue;
  final TextEditingController textEditingController;

  const SearchPageBar({
    super.key,
    required this.search,
    required this.setTextValue,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                    prefixIcon: const Icon(Icons.search),
                    hintText: '搜索歌曲、歌手、专辑',
                    hintStyle: TextStyle(fontSize: 30.w),
                    border: InputBorder.none,
                    suffixIcon: textEditingController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              textEditingController.clear();
                              setTextValue('');
                            },
                          )
                        : null,
                  ),
                  onChanged: setTextValue,
                  onSubmitted: (_) => search(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
