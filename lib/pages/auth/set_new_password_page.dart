import 'package:espitaliaa_doctors/pages/auth/login_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SetNewPasswordPage extends StatefulWidget {
  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
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
                  text: AppLocalizations.of(context).translate('finish'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LoginPage(),
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
