import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<void> showModal(BuildContext context, String title,
      Function()? onConfirm, Function()? onCancel) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              TextButton(
                onPressed: () {
                  onCancel!();
                  Navigator.pop(context);
                },
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  onConfirm!();
                  Navigator.pop(context);
                },
                child: const Text('确定'),
              ),
            ],
          );
        });
  }
}
