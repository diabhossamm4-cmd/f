import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyDatePicker extends StatefulWidget {
  final validator;
  final TextEditingController controller;
  final String text;
  final DateTime startDate;
  final ValueChanged<DateTime> onDateChanged;
  final bool isStartDate;
  const MyDatePicker({
    Key key,
    this.validator,
    this.controller,
    this.onDateChanged,
    this.isStartDate = false,
    this.startDate,
    this.text,
  }) : super(key: key);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
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
            Icons.date_range,
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
            child: GestureDetector(
              onTap: () async {
                if (widget.startDate == null && widget.isStartDate == false) {
                  Get.showSnackbar(GetSnackBar(
                    duration: const Duration(seconds: 3),
                    message: "${AppLocalizations.of(context).translate('select_start_date')}",
                  ));
                  return;
                }
                DateTime date = DateTime.now();
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );

                DateTime picked = await showDatePicker(
                  context: context,
                  firstDate: widget.startDate == null || widget.isStartDate ? DateTime(1900) : widget.startDate,
                  initialDate: widget.startDate ?? date,
                  lastDate: DateTime(2101),
                );

                if (picked != null && picked != date) {
                  widget.onDateChanged(picked);
                }
              },
              child: TextFormField(
                controller: widget.controller,
                enabled: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: widget.text ?? AppLocalizations.of(context).translate('date_of_reservation'),
                    border: InputBorder.none,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                    )),
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
