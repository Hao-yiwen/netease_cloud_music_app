import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomField extends StatefulWidget {
  final IconData? iconData;
  final String? hitText;
  final TextStyle? hintStyle;
  final TextEditingController textEditingController;
  final bool? pass;
  final bool? autoFocus;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextInputType? textInputType;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  const CustomField(
      {super.key,
      this.iconData,
      this.hitText,
      this.hintStyle,
      required this.textEditingController,
      this.pass,
      this.autoFocus,
      this.padding,
      this.margin,
      this.textInputType,
      this.onSubmitted,
      this.textInputAction});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isPass = false;

  @override
  void initState() {
    super.initState();
    isPass = widget.pass ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
      child: Row(
        children: [
          widget.iconData != null
              ? Icon(
                  widget.iconData,
                  size: 42.sp,
                )
              : const SizedBox.shrink(),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              hintText: widget.hitText ?? '',
            ),
          )),
          Visibility(
            visible: widget.pass ?? false,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  isPass ? Icons.visibility : Icons.visibility_off,
                  size: 40.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
