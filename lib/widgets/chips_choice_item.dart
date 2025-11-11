import 'package:chips_choice/chips_choice.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChipsChoiceItem extends StatelessWidget {
  final List list;
  final Function onChanged;
  final int selectedType;

  ChipsChoiceItem({this.list, this.selectedType, this.onChanged});

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        divider(size),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(16),
            ),
            child: Text(
              AppLocalizations.of(context).translate('doctor_title'),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(16),
          ),
          child: ChipsChoice<int>.single(
            itemConfig: ChipsChoiceItemConfig(
              selectedBorderOpacity: 1,
              elevation: 5,
              selectedColor: mainColor,
            ),
            value: selectedType,
            options: ChipsChoiceOption.listFrom<int, dynamic>(
              source: list,
              value: (i, v) => int.parse(v.id),
              label: (i, v) => v.name,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
