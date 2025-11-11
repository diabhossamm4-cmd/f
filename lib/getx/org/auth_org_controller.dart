import 'dart:io';

import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/models/org/user_org_model.dart';
import 'package:espitaliaa_doctors/models/user_login_model.dart';
import 'package:espitaliaa_doctors/pages/auth/organization/general_data_org_page.dart';
import 'package:espitaliaa_doctors/pages/home/org/home_org_page.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOrgController extends GetxController {
  var selectedPlaceType = 0.obs;
  Rx<UserOrgModel> activeUser = UserOrgModel().obs;
  Rx<UserOrgData> activeUserData = UserOrgData().obs;
  HomeOrgController _homeOrgController = Get.put(HomeOrgController());
  Future<void> login({@required UserLoginModel user}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest("${ServerVars.loginOrgEndPoint}", body: user.toJson(), isGlobalURl: true);
      activeUser.value = UserOrgModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
      await activeUser.value.saveToken(activeUser.value.accessToken);
      await activeUser.value.saveRememberMe(user.rememberMe);
      await activeUser.value.saveUserData(activeUser.value.data);
      await activeUser.value.saveUserType('organization');
      await _homeOrgController.initData();

      Get.back();

      Get.to(() => HomeOrgPage());
    } on SocketException catch (_) {
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

  Future<void> register({
    @required body,
  }) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest("${ServerVars.registerOrgEndPoint}", body: body, isGlobalURl: true);
      activeUser.value = UserOrgModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
      await activeUser.value.saveRememberMe(true);

      ///TODO edittttt
      await activeUser.value.saveToken(activeUser.value.accessToken);
      await activeUser.value.saveUserData(activeUser.value.data);
      await activeUser.value.saveUserType('organization');
      Get.back();

      Get.to(() => GeneralDataOrgPage());
    } on SocketException catch (_) {
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

  Future<void> updateInfo(context, {@required body, @required bool isFirstTime}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
        "${ServerVars.updateInfo}",
        isOrg: true,
        body: body,
      );

      Get.back();
      activeUser.value = UserOrgModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
      Get.back();
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 3),
        message: "${AppLocalizations.of(context).translate('update_data_success')}",
      ));

      Future.delayed(const Duration(seconds: 3)).then((value) => isFirstTime ? Get.offAll(HomeOrgPage()) : Get.back());
    } on SocketException catch (_) {
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
      var response = await ApiProvider().getRequest("${ServerVars.orgInfo}", isOrg: true);

      if (!isSplash) Get.back();

      activeUser.value = UserOrgModel.fromJson(response.data);
      activeUserData.value = activeUser.value.data;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      if (!isSplash) Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      // if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      if (!isSplash) Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
