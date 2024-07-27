import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp.router(
    routerConfig: routes,
  ));
}
