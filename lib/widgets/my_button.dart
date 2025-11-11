import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final TextStyle textStyle;
  final Function onTap;
  final double width;
  final double height;
  final double borderRadius;

  const MyButton({
    Key key,
    @required this.text,
    this.buttonColor,
    this.textStyle,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width * .9,
      height: height ?? ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 50),
        color: buttonColor ?? mainColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 50),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: onTap ?? () {},
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
