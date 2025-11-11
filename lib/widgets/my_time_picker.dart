import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyTimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> timeOfDay;
  final TextEditingController controller;
  final validator;
  final String label;

  const MyTimePicker({
    Key key,
    this.timeOfDay,
    this.controller,
    this.validator,
    this.label,
  }) : super(key: key);

  @override
  _MyTimePickerState createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<MyTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(18),
      ),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Icon(
            Icons.timer,
            color: mainColor,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Container(
            width: ScreenUtil().setWidth(1),
            height: ScreenUtil().setHeight(25),
            color: mainColor.withOpacity(.55),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                  labelText: widget.label ??
                      AppLocalizations.of(context)
                          .translate('time_of_reservation'),
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    fontSize: 14,
                  )),
              onTap: () async {
                TimeOfDay time = TimeOfDay.now();
                FocusScope.of(context).requestFocus(new FocusNode());

                TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: time,
                  cancelText: AppLocalizations.of(context).translate('cancel'),
                  confirmText: AppLocalizations.of(context).translate('ok'),
                );

                if (picked != null && picked != time) {
                  widget.timeOfDay(picked);
                }
              },
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
