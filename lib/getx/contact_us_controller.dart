import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_utils.dart';

class ContactUsController extends GetxController {
  /*Future<void> contactUs(BuildContext context){
    try {
      // hide keyboard if appears
      AppUtils.hideKeyboard(context);
      // show loading model
      //Loading().loading(context);
      Map<String, String> body = {
        'description': "${_messageController.text}",
        'email': "${_emailController.text}",
        'phone': "${_phoneController.text}",
      };
      await ApiProvider().contactUs(body);
      Navigator.of(context).pop();

      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(
        content: new Text(
            AppLocalizations.of(context).translate('contact_us_message')),
        duration: Duration(seconds: 1),
      ))
          .closed
          .then((value) => Navigator.of(context).pop());
    } on SocketException catch (_) {
      Navigator.of(context).pop();
      await AppUtils.showNoInternectConnectiondailog(context);
    } on ApiException catch (e) {
      // AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      print("Error = ${e.toString()}");
    } finally {}
  }
  }*/
}
