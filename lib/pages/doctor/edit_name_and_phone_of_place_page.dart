import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EditNamePhonePlacePage extends StatefulWidget {
  @override
  _EditNamePhonePlacePageState createState() => _EditNamePhonePlacePageState();
}

class _EditNamePhonePlacePageState extends State<EditNamePhonePlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context).translate('edit_place_info')}',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            MyTextFormField(
              prefixIcon: Icons.place,
              hint: 'عيادة*   مركز*   معمل*   مستشفى',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            MyTextFormField(
              prefixIcon: Icons.place,
              hint: 'Clinic*  Center*   Lab*   Hospital',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            MyTextFormField(
              prefixIcon: Icons.phone,
              hint: 'Phone',
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
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
