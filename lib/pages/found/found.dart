import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Found extends StatelessWidget {
  const Found({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Found Page!'),
    );
  }
}
