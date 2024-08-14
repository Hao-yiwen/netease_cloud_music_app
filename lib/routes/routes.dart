import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:netease_cloud_music_app/controllers/auth_controller.dart';
import 'package:netease_cloud_music_app/pages/Found.dart';
import 'package:netease_cloud_music_app/pages/Home.dart';
import 'package:netease_cloud_music_app/pages/Login.dart';
import 'package:netease_cloud_music_app/pages/Mine.dart';
import 'package:netease_cloud_music_app/pages/Timeline.dart';
import 'package:netease_cloud_music_app/routes/BottomBar.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter routes = GoRouter(
    initialLocation: '/login',
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return BottomBar(state: state, child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            builder: (context, state) => const Home(),
          ),
          GoRoute(
            path: '/found',
            builder: (context, state) => const Found(),
          ),
          GoRoute(
            path: '/timeline',
            builder: (context, state) => const Timeline(),
          ),
          GoRoute(
            path: '/mine',
            builder: (context, state) => const Mine(),
          ),
        ],
      ),
      GoRoute(path: '/login', builder: (context, state) => const Login()),
    ],
    redirect: (context, state) async {
      AuthController authController = Get.find();
      await authController.statusCheck();
      final isLoggedIn = authController.isLoggedIn.value; // 检查拼写
      final isLoggingIn = state.uri.toString() == '/login';
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }
      return null;
    });
