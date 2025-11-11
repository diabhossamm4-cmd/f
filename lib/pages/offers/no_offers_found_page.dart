import 'package:espitaliaa_doctors/pages/offers/add_offer_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NoOffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Image.asset(
            'assets/images/offer_page.png',
            width: size.width,
            height: size.height * .55,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Text(
            AppLocalizations.of(context).translate('add_your_offer_now'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(12),
          ),
          MyButton(
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
          ),
        ],
      ),
    );
  }
}
