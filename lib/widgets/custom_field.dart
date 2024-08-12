import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

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
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
        borderRadius: BorderRadius.circular(50.w),
      ),
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
            obscureText: isPass,
            controller: widget.textEditingController,
            keyboardType: widget.textInputType ?? TextInputType.text,
            cursorColor: Theme.of(context).primaryColor.withOpacity(.4),
            onSubmitted: widget.onSubmitted,
            textInputAction: widget.textInputAction,
            autofocus: widget.autoFocus ?? false,
            decoration: InputDecoration(
                hintText: widget.hitText ?? '',
                hintStyle: TextStyle(fontSize: 28.sp, color: Colors.grey),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
                isDense: true),
          )),
          Visibility(
            visible: widget.pass ?? false,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: GestureDetector(
                onTap: () {
                  isPass = !isPass;
                },
                child: Icon(
                  isPass ? TablerIcons.eye_off : TablerIcons.eye,
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
