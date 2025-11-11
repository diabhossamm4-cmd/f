import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataFound extends StatelessWidget {
  final String title;
  final bool isSmallPage;
  NoDataFound({@required this.title, this.isSmallPage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_offers.png',
              width: size.width / 2,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              AppLocalizations.of(context).translate("$title"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setWidth(20),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(12),
            ),
            /*     MyButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddOfferPage(),
                  ),
                );
              },
              text: AppLocalizations.of(context).translate('start'),
              buttonColor: Colors.white,
              borderRadius: 20,
              width: ScreenUtil().setWidth(180),
              textStyle: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
