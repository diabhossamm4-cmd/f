
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MoreItem extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Function onTap;
  final double iconSize;
  final bool withTrailing;

  const MoreItem({
    Key key,
    @required this.title,
    @required this.leadingIcon,
    this.onTap,
    this.iconSize,
    this.withTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(12),
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5),
      ),
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(title),
          onTap: onTap ?? () {},
          leading: Icon(
            leadingIcon,
            color: mainColor,
            size: iconSize ?? 20,
          ),
          trailing: withTrailing
              ? Icon(
                  Icons.arrow_right,
                  color: mainColor,
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
