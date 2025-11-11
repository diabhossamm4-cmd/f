import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final validator;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Widget swifixIcon;
  final double height;
  final String initialValue;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final double iconSize;
  final List<TextInputFormatter> inputFormatters;
  final String limitNumber;
  final textFieldFocusNode;
  final TextInputAction textInputAction;
  const MyTextFormField({
    Key key,
    this.hint = '',
    this.validator,
    this.controller,
    @required this.prefixIcon,
    this.swifixIcon,
    this.height = 45,
    this.initialValue,
    this.textFieldFocusNode,
    this.obscureText = false,
    this.textInputAction,
    this.maxLines,
    this.keyboardType,
    this.iconSize,
    this.inputFormatters,
    this.limitNumber = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
      ),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(15),
      ),
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Icon(
            prefixIcon,
            color: mainColor,
            size: iconSize,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Container(
            width: ScreenUtil().setWidth(1),
            height: ScreenUtil().setHeight(height > 45
                ? height > 70
                    ? 100
                    : 40
                : 25),
            color: mainColor.withOpacity(.55),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Expanded(
            child: TextFormField(
              obscureText: obscureText,
              initialValue: initialValue,
              controller: controller,
              focusNode: textFieldFocusNode,
              textAlign: TextAlign.start,
              maxLines: maxLines != null ? maxLines : 1,
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.bottom,
              validator: validator,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                hintMaxLines: maxLines,
                contentPadding: EdgeInsets.only(top: 10),
                counter: Text(limitNumber),
                border: InputBorder.none,
                hintText: hint,
                suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: swifixIcon),
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
