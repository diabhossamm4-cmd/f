import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditReservationPagePage extends StatefulWidget {
  @override
  _EditReservationPagePageState createState() =>
      _EditReservationPagePageState();
}

class _EditReservationPagePageState extends State<EditReservationPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'سعر الكشف',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            MyTextFormField(
              prefixIcon: FontAwesomeIcons.file,
              hint: 'سعر الكشف (جنية)',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(90),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              child: MyButton(
                width: ScreenUtil().setWidth(120),
                borderRadius: 12,
                text: AppLocalizations.of(context).translate(
                  'save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
