import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:flutter/material.dart';

class NoInternetConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_internet_connction.png'),
            SizedBox(
              height: size.height * .1,
            ),
            Text(
              AppLocalizations.of(context)
                  .translate('no_internet_connection_msg'),
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                wordSpacing: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
