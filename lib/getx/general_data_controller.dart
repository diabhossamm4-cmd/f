import 'dart:io';

import 'package:espitaliaa_doctors/models/general_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:get/get.dart';

class GeneralDataController extends GetxController {
  List<GeneralData> cityList = <GeneralData>[].obs;
  var districtList = <GeneralData>[].obs;

  List<GeneralData> specializationList = <GeneralData>[].obs;
  List<GeneralData> doctorsTitleList = <GeneralData>[].obs;
  List<Map<String, dynamic>> specializationListJson = <Map<String, dynamic>>[].obs;

  Future<void> initData() async {
    await getCityList();
    await getSpecializationList();
    await getDoctorTitles();
  }

  getCityList() async {
    try {
      var response = await ApiProvider().getRequest(ServerVars.getCitiesEndPoint, isGlobalUrl: true);
      GeneralModel model = GeneralModel.fromJson(response.data);
      cityList = model.data;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");

      // AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  getDistrictList(String id) async {
    districtList.assignAll(new List());
    try {
      var response = await ApiProvider().getRequest(ServerVars.getDistrictsEndPoint + "$id", isGlobalUrl: true);
      GeneralModel model = GeneralModel.fromJson(response.data);
      districtList.assignAll(model.data);
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      // AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  getSpecializationList() async {
    try {
      var response = await ApiProvider().getRequest(ServerVars.getSpecializationsEndPoint, isGlobalUrl: true);
      GeneralModel model = GeneralModel.fromJson(response.data);
      specializationList = model.data;
      if (specializationList.length >= 0) specializationListJson = specializationList.map((e) => e.toJson()).toList();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      // AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");

      //AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  getDoctorTitles() async {
    try {
      var response = await ApiProvider().getRequest(ServerVars.getDoctorTitlesLoginEndPoint, isGlobalUrl: true);
      GeneralModel model = GeneralModel.fromJson(response.data);
      doctorsTitleList = model.data;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //   AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");

      // AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
