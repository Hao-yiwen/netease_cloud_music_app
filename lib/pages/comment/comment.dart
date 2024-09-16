import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CommentPage extends StatelessWidget {
  CommentPage({super.key});

  final List<Map<String, dynamic>> sections = [
    {
      'header': 'Section 1',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'header': 'Section 2',
      'items': ['Item 4', 'Item 5', 'Item 6']
    },
    {
      'header': 'Section 3',
      'items': ['Item 7', 'Item 8', 'Item 9']
    },
    {
      'header': 'Section 4',
      'items': ['Item 10', 'Item 11', 'Item 12']
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('评论'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Text('评论(666)'),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (context, sectionIndex) {
                    return Column(
                      children: [
                        Container(
                          height: 50.0,
                          color: Colors.blueGrey[700],
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            sections[sectionIndex]['header'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            sections[sectionIndex]['items'].length,
                            (itemIndex) => ListTile(
                              title: Text(
                                  sections[sectionIndex]['items'][itemIndex]),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
