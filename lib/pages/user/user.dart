import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _MineState();
}

class _MineState extends State<User> {
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
