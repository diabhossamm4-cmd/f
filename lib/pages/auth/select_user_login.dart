import 'package:espitaliaa_doctors/pages/auth/organization/login_org_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/logo_with_app_name.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class SelectUserLogin extends StatelessWidget {
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
                MaterialPageRoute(builder: (_) => LoginPage() //ClientVerificationCodeScreen() ,
                    ),
              );
            },
            buttonColor: Colors.white,
            text: AppLocalizations.of(context).translate('user_type_doctor'),
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
              Get.to(LoginOrgPage());
            },
            text: AppLocalizations.of(context).translate('user_type_org'),
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
            style: const TextStyle(
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
