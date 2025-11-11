import 'package:espitaliaa_doctors/pages/auth/set_new_password_page.dart';
import 'package:espitaliaa_doctors/providers/network_provider.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_code_pin.dart';
import 'package:espitaliaa_doctors/widgets/no_internet_connection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordCodePage extends StatefulWidget {
  @override
  _ForgotPasswordCodePageState createState() => _ForgotPasswordCodePageState();
}

class _ForgotPasswordCodePageState extends State<ForgotPasswordCodePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      physics: bouncingScroll,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate("restore_password"),
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
                AppLocalizations.of(context)
                    .translate("enter_phone_to_reset_password"),
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
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(90),
              vertical: ScreenUtil().setHeight(35),
            ),
            child: MyPinCodeTextField(
              activeColor: mainColor,
              textInputType: TextInputType.number,
              onCompleted: (String input) {},
              shape: PinCodeFieldShape.underline,
              inactiveColor: Colors.grey,
              length: 4,
              onChanged: (String value) {},
            ),
          ),
          SizedBox(
            height: size.height * .025,
          ),
          MyButton(
            text: AppLocalizations.of(context).translate("restore_password"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SetNewPasswordPage(),
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * .065,
          ),
          Text(
            AppLocalizations.of(context).translate("no_code_sent"),
          ),
          SizedBox(
            height: size.height * .035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate("change_phone"),
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              Container(
                width: ScreenUtil().setWidth(2),
                height: ScreenUtil().setHeight(25),
                color: mainColor,
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              Text(
                AppLocalizations.of(context).translate("resend_code"),
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
