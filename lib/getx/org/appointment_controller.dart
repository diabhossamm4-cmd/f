import 'dart:io';

import 'package:espitaliaa_doctors/models/org/appointment_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentOrgController extends GetxController {
  var appointmentServiceList = [].obs;
  var appointmentHospitalDoctorsList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadFirstTime = true.obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxInt currentServicePage = 1.obs;
  RxInt lastServicePage = 1.obs;

  ScrollController doctorScrollController = ScrollController();
  ScrollController servicesScrollController = ScrollController();
  Future<void> initData() async {
    appointmentHospitalDoctorsList = [].obs;
    appointmentServiceList = [].obs;
    currentPage.value = 1;
    lastPage.value = 1;
    currentServicePage.value = 1;
    lastServicePage.value = 1;
    isLoadFirstTime.value = true;
    await getHospitalDoctorsAppointment(page: 1);
    await getServiceAppointment(page: 1);

    addListenerController();
  }

  Future<void> getServiceAppointment({@required int page}) async {
    try {
      if (!isLoadFirstTime.value) {
        isLoading.value = true;
        update();
      }

      var response = await ApiProvider().getRequest("${ServerVars.getAppointment}?type=org_service&page=$page", isOrg: true);

      // Get.back();
      var result = AppointmentOrgModel.fromJson(response.data);
      appointmentServiceList.addAll(result.data);
      lastServicePage.value = result.meta.lastPage;
      currentServicePage.value = result.meta.currentPage;
      update();

      //   Get.back();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      //  Get.back();
      //  AppUtils.showToast(msg: ApiException.unknownErr);
    } finally {
      isLoading.value = false;
      isLoadFirstTime.value = false;

      update();
    }
  }

  Future<void> getHospitalDoctorsAppointment({@required int page}) async {
    try {
      //Loading().loading();

      if (!isLoadFirstTime.value) {
        isLoading.value = true;
        update();
      }

      var response = await ApiProvider().getRequest("${ServerVars.getAppointment}?type=doctor_meshmesh&page=$page", isOrg: true);

      // Get.back();
      var result = AppointmentOrgModel.fromJson(response.data);
      lastPage.value = result.meta.lastPage;
      currentPage.value = result.meta.currentPage;
      appointmentHospitalDoctorsList.addAll(result.data);
      update();
      //  Get.back();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      //  Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    } finally {
      isLoading.value = false;
      isLoadFirstTime.value = false;
      update();
    }
  }

  Future<AppointmentOrgData> updateAppointment(int id, var body) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest("${ServerVars.updateAppointment}$id", body: body, isOrg: true);

      Get.back();

      AppointmentOrgData result = AppointmentOrgData.fromJson(response.data['data']);
      return result;
      //   Get.back();
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

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void addListenerController() {
    doctorScrollController.addListener(() {
      if (doctorScrollController.position.maxScrollExtent == doctorScrollController.position.pixels) {
        if (currentPage.value < lastPage.value) {
          currentPage.value++;
          getHospitalDoctorsAppointment(page: currentPage.value);
        }
      }
    });

    servicesScrollController.addListener(() {
      if (servicesScrollController.position.maxScrollExtent == servicesScrollController.position.pixels) {
        if (currentServicePage.value < lastServicePage.value) {
          currentServicePage.value++;
          getServiceAppointment(page: currentServicePage.value);
        }
      }
    });
  }
}
