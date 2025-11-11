
import 'package:espitaliaa_doctors/pages/auth/login_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FinishPage extends StatefulWidget {
  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(
        ScreenUtil().setHeight(18),
      ),
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .35,
          ),
          Center(
            child: Container(
              height: ScreenUtil().setHeight(120),
              width: ScreenUtil().setWidth(120),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: mainColor,
                  size: 80,
                ),
              ),
            ),
          ),
          divider(size),
          Text(
            AppLocalizations.of(context)
                .translate('the_account_has_been_registered'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          Text(
            AppLocalizations.of(context).translate('register_msg'),
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 1),
          ),
          Expanded(
            child: Container(
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
        ],
      ),
    ));
  }

  Widget divider(Size size) {
    return SizedBox(
      height: size.height * .02,
    );
  }
}
