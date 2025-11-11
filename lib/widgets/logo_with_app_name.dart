import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget logoWithAppName(Size size) {
  return Container(
    width: size.width,
    height: size.height * .14,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(5.0),
            bottom: ScreenUtil().setHeight(5.0),
          ),
          child: Image.asset(
            'assets/images/logo_white.png',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'الإسبتالية',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Espitaliaa',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
