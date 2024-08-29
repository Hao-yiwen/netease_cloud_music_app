import 'package:flutter/material.dart';

class DrawerItem {
  final IconData icon;
  final String text;
  final String? badge;
  final Function()? onTap;
  final String? title;
  final Widget? trailing;
  final Color? color;

  DrawerItem({
    required this.icon,
    required this.text,
    this.badge,
    this.onTap,
    this.title,
    this.trailing,
    this.color
  });
}