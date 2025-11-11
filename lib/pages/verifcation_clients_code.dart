import 'dart:async';

import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_localization.dart';

class ClientVerificationCodeScreen extends StatefulWidget {
  final pageRoute;
  ClientVerificationCodeScreen({@required this.pageRoute});
  @override
  _ClientVerificationCodeScreenState createState() => _ClientVerificationCodeScreenState();
}

class _ClientVerificationCodeScreenState extends State<ClientVerificationCodeScreen> {
  TextEditingController codeController = TextEditingController();
  var authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  int _start;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: SizedBox(),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  AppLocalizations.of(context).translate("client_verification"),
                  style: TextStyle(color: mainColor, fontWeight: FontWeight.w700, height: 2.0, fontSize: 20.0.w),
                ),
                SizedBox(height: 15.0.h),
                Text(
                  AppLocalizations.of(context).translate("enter_code_received"),
                  style: TextStyle(color: Colors.grey, height: 1.5.h, fontSize: 15.w),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).translate("the_code_is"),
                    style: TextStyle(color: mainColor, fontWeight: FontWeight.w600, height: 2.0, fontSize: 15.0.w),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                MyTextFormField(
                  prefixIcon: Icons.sms_failed,
                  hint: AppLocalizations.of(context).translate('code'),
                  keyboardType: TextInputType.number,
                  controller: codeController,
                  validator: (String input) {
                    if (input.isEmpty) {
                      return AppLocalizations.of(context).translate('required');
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    checkValidation(context);
                  },
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).translate("verify"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.w,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: _start == 0 ? Colors.grey : mainColor,
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                  ),
                ),
                Center(
                  child: RichText(
                      text: TextSpan(style: TextStyle(fontSize: 13.w, height: 2.0), children: [
                    TextSpan(text: AppLocalizations.of(context).translate("didn't_receive_code"), style: const TextStyle(color: Colors.grey)),
                    TextSpan(text: "$_start ", style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    TextSpan(text: AppLocalizations.of(context).translate("sec"), style: const TextStyle(color: Colors.grey)),
                  ])),
                ),
                GestureDetector(
                  onTap: () async {
                    await authController.resendSmsCode().then((value) => startTimer());
                    /*   dueController
                          .generateOtpNotification()
                          .then((value) => startTimer());*/
                  },
                  child: Center(
                      child: Text(
                    "Resend code".tr,
                    style: TextStyle(color: mainColor, fontSize: 11.0.w, height: 1.5, decoration: TextDecoration.underline),
                  )),
                ),
                // Center(
                //     child: Text(
                //   "or send".tr,
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 11.0.w,
                //     fontWeight: FontWeight.w600,
                //     height: 1.5,
                //   ),
                // )),
                // Center(
                //     child: Text(
                //   "SMS code".tr,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 11.0.w,
                //       height: 1.5,
                //       decoration: TextDecoration.underline),
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkValidation(BuildContext context) async {
    AppUtils.hideKeyboard(context);

    if (_start != 0) if (formKey.currentState.validate()) {
      var body = {"valid_code": "${codeController.text}"};
      authController.validateUser(body: body, route: widget.pageRoute);
    }
  }

  void startTimer() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted)
            setState(() {
              timer.cancel();
            });
        } else {
          if (mounted)
            setState(() {
              _start--;
            });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
