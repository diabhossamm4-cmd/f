/*
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SetPasswordPage extends StatefulWidget {
  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .translate('choose_a_strong_password'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                wordSpacing: 2,
                fontSize: 22,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                AppLocalizations.of(context).translate('choose_password_label'),
                style: TextStyle(
                  wordSpacing: 2,
                  color: Colors.black38,
                  fontSize: 16,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .1,
          ),
          MyTextFormField(
            prefixIcon: Icons.lock,
            swifixIcon: IconButton(
              icon:
                  Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                _hidePassword = !_hidePassword;
                setState(() {});
              },
            ),
            hint: AppLocalizations.of(context).translate('password'),
          ),
          SizedBox(
            height: size.height * .015,
          ),
          MyTextFormField(
            prefixIcon: Icons.lock,
            swifixIcon: IconButton(
              icon: Icon(_hideConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                _hideConfirmPassword = !_hideConfirmPassword;
                setState(() {});
              },
            ),
            hint: AppLocalizations.of(context).translate('password_confirm'),
          ),
          SizedBox(
            height: size.height * .2,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(18),
                vertical: ScreenUtil().setHeight(12),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: MyButton(
                  borderRadius: 12,
                  width: ScreenUtil().setWidth(120),
                  text: AppLocalizations.of(context).translate('next'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GeneralDataPage1(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
        ],
      ),
    ));
  }
}
*/
