import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:netease_cloud_music_app/controllers/auth_controller.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: ElevatedButton(
        onPressed: () {
          print('Logout button was pressed!');
          authController.logout();
          context.replace("/login");
        },
        child: const Text('Logout'),
      )),
    );
  }
}
