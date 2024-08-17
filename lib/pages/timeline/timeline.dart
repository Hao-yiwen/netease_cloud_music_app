import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Feed Page!'),
    );
  }
}
