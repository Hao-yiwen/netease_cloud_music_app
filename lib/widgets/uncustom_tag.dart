import 'package:flutter/material.dart';

class UncustomTag extends StatelessWidget {
  final String label;

  const UncustomTag({super.key, required this.label});


  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}