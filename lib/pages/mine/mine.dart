import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(child: Text('Mine')),
    );
  }
}
