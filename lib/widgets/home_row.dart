import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget homeRow(String title, String imagePath, Function onTap) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: ScreenUtil().setWidth(12),
      vertical: ScreenUtil().setHeight(8),
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: onTap ?? () {},
        child: Center(
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: mainColor,
              ),
            ),
            leading: Image.asset(
              imagePath,
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: mainColor,
            ),
          ),
        ),
      ),
    ),
  );
}
