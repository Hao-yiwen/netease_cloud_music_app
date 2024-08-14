import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class WidgetUtil {
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Center(
                child: Lottie.asset(
              'assets/lottie/empty_status.json',
              width: 750.w / 4,
              height: 750.w / 4,
              fit: BoxFit.fitWidth,
            )));
  }

  static closeLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
