import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingModel extends StatelessWidget {
  final bool isLoadingDialog;

  const LoadingModel({
    Key key,
    this.isLoadingDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SpinKitDoubleBounce(
                  color: isLoadingDialog ? mainColor : Colors.white,
                  size: 25,
                ),
                SpinKitRipple(
                  color: isLoadingDialog ? mainColor : Colors.white,
                  size: 150,
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(12),
            ),
            isLoadingDialog
                ? SizedBox.shrink()
                : Text(
                    AppLocalizations.of(context).translate('loading'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class Loading {
  loading({bool isDialogLoading = true}) {
    return Get.dialog(WillPopScope(
      onWillPop: () async => false,
      child: Container(
        height: 20, //MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadingModel(isLoadingDialog: isDialogLoading),
          ],
        ),
      ),
    ));
  }
}
