import 'dart:io';

import 'package:espitaliaa_doctors/models/user_login_model.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/pages/auth/general_data_page.dart';
import 'package:espitaliaa_doctors/pages/home/home_page.dart';
import 'package:espitaliaa_doctors/pages/verifcation_clients_code.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/app_localization.dart';

class AuthController extends GetxController {
  // 0- clinic    1- hospital   2- Lab  3- center
  var selectedPlaceType = 0.obs;
  Rx<UserModel> activeUser = UserModel().obs;
  Rx<UserData> activeUserData = UserData().obs;

  Future<void> login({@required UserLoginModel user}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
          "${ServerVars.loginEndPoint}",
          body: user.toJson(),
          isGlobalURl: true);
      Get.back();

      activeUser.value = UserModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
      await activeUser.value.saveRememberMe(user.rememberMe);

      if (activeUser.value.data.valid == 1) {
        await activeUser.value.saveToken(activeUser.value.accessToken);
        await activeUser.value.saveUserData(activeUser.value.data);
        await activeUser.value.saveUserType('doctor');
      }

      activeUser.value.data.valid == 1
          ? Get.to(() => HomePage())
          : activeUser.value.data.smsOtp == 1
              ? Get.to(() => ClientVerificationCodeScreen(
                    pageRoute: HomePage(),
                  ))
              : Get.to(() => HomePage());
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      // if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> register({@required body}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
          "${ServerVars.registerEndPoint}",
          body: body,
          isGlobalURl: true);
      activeUser.value = UserModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
      await activeUser.value.saveRememberMe(true);

      Get.back();
      activeUser.value.data.valid == 1
          ? Get.to(() => GeneralDataPage())
          : activeUser.value.data.smsOtp == 1
              ? Get.to(() =>
                  ClientVerificationCodeScreen(pageRoute: GeneralDataPage()))
              : Get.to(() => GeneralDataPage());
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> updateInfo({@required body, @required bool isFirstTime}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
        "${ServerVars.updateInfo}",
        body: body,
      );
      Get.back();
      activeUser.value = UserModel.fromJson(response.data);

      activeUserData.value = UserModel.fromJson(response.data).data;

      /* update();
      Get.appUpdate();
      Get.forceAppUpdate();*/

      isFirstTime ? Get.offAll(HomePage()) : Get.back();
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> validateUser({@required body, @required route}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
          "${ServerVars.activeAccount}",
          body: body,
          validateToken: "Bearer ${activeUser.value.accessToken}");
      Get.back();
      await activeUser.value.saveToken(activeUser.value.accessToken);
      await activeUser.value.saveUserData(activeUser.value.data);
      await activeUser.value.saveUserType('doctor');
      Get.offAll((route));
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> resendSmsCode() async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
          "${ServerVars.resendCodeVerification}",
          validateToken: "Bearer ${activeUser.value.accessToken}",
          body: null);
      Get.back();
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> forgetPass({@required body, bool isOrg = false}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
        "${ServerVars.updatePasswords}",
        isOrg: isOrg,
        body: body,
      );
      Get.back();
      Get.back();
      AppUtils.showToast(msg: "تم تغيير الباسورد بنجاح");
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> validateEmailToForgetPass(context,
      {@required body, bool isOrg}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
        isOrg != null
            ? ServerVars.forgetOrgPasswords
            : ServerVars.forgetPasswords,
        isGlobalURl: true,
        body: body,
      );
      Get.back();
      AppUtils.showToast(
          msg: AppLocalizations.of(context).translate('send_email_success'));
      Get.back();
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<void> getUserProfile({bool isSplash}) async {
    try {
      if (!isSplash) Loading().loading();
      var response = await ApiProvider().getRequest(
        "${ServerVars.userInfo}",
      );

      if (!isSplash) Get.back();

      activeUser.value = UserModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      if (!isSplash) Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      // if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      if (!isSplash) Get.back();
      // AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
