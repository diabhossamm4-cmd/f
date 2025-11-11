import 'package:espitaliaa_doctors/pages/auth/register_page.dart';
import 'package:espitaliaa_doctors/pages/auth/select_user_login.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/logo_with_app_name.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      color: mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          logoWithAppName(size),
          SizedBox(
            height: size.height * .12,
          ),
          MyButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SelectUserLogin(),
                ),
              );
            },
            buttonColor: Colors.white,
            text: AppLocalizations.of(context).translate('login'),
            textStyle: TextStyle(
              color: mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          MyButton(
            buttonColor: Colors.white,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RegisterPage(),
                ),
              );
            },
            text: AppLocalizations.of(context).translate('register'),
            textStyle: TextStyle(
              color: mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * .15,
          ),
          Text(
            AppLocalizations.of(context).translate('login_terms'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
        ],
      ),
    ));
  }
}
