import 'dart:io';

import 'package:espitaliaa_doctors/models/org/org_services_model.dart';
import 'package:espitaliaa_doctors/models/org/org_subsribers_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeOrgController extends GetxController {
  RxList<SubscribersData> doctorsList = <SubscribersData>[].obs;
  RxList<ServicesData> servicesList = <ServicesData>[].obs;
  ScrollController doctorScrollController = ScrollController();
  ScrollController servicesScrollController = ScrollController();

  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;

  RxInt currentServicePage = 1.obs;
  RxInt lastServicePage = 1.obs;
  RxBool isLoading = false.obs;

  Future<void> initData() async {
    doctorsList = <SubscribersData>[].obs;
    servicesList = <ServicesData>[].obs;
    await getDoctorsList(page: 1);
    await getOrgServices(page: 1);

    addListenerController();
    /*    getSpecializationList();
    getDoctorTitles();*/
  }

  getDoctorsList({@required int page}) async {
    try {
      isLoading.value = true;
      update();
      var response = await ApiProvider().getRequest("${ServerVars.orgSubscribersEndPoint}?page=$page", isOrg: true);
      OrgSubscribersModel model = OrgSubscribersModel.fromJson(response.data);
      lastPage.value = model.meta.lastPage;
      currentPage.value = model.meta.currentPage;
      doctorsList.addAll(model.data);
      isLoading.value = false;
      update();
    } on SocketException catch (_) {
      isLoading.value = false;
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      isLoading.value = false;
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      isLoading.value = false;

      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  getOrgServices({@required int page}) async {
    try {
      isLoading.value = true;
      update();

      var response = await ApiProvider().getRequest("${ServerVars.orgServicesList}?page=$page", isOrg: true);
      OrgServicesModel model = OrgServicesModel.fromJson(response.data);
      lastServicePage.value = model.meta.lastPage;
      currentServicePage.value = model.meta.currentPage;
      servicesList.addAll(model.data);
      isLoading.value = false;
      update();
    } on SocketException catch (_) {
      isLoading.value = false;
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      isLoading.value = false;
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      isLoading.value = false;

      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  addNewDoctor({var body}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(ServerVars.orgSubscribersEndPoint, body: body, isOrg: true);
      Get.back();
      var res = response.data['data'];
      SubscribersData model = SubscribersData.fromJson(res);
      doctorsList.add(model);
      Get.back();
      update();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      Get.back();
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  editOrgDoctor({var body, int doctorId}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest('${ServerVars.updateOrgSubscriber}$doctorId', body: body, isOrg: true);
      Get.back();
      var res = response.data['data'];

      SubscribersData model = SubscribersData.fromJson(res);
      int index = doctorsList.indexWhere((element) => element.id == doctorId);
      doctorsList[index] = model;

      Get.back();
      doctorsList.refresh();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      Get.back();
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  editOrgService({var body, int serviceId}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest('${ServerVars.updateOrgServices}$serviceId', body: body, isOrg: true);
      Get.back();
      var res = response.data['data'];
      ServicesData model = ServicesData.fromJson(res);

      int index = servicesList.indexWhere((element) => element.id == serviceId);
      servicesList[index] = model;

      Get.back();
      servicesList.refresh();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      Get.back();
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  addNewService({var body}) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(ServerVars.orgServicesList, body: body, isOrg: true);
      Get.back();
      var res = response.data['data'];
      ServicesData model = ServicesData.fromJson(res);
      servicesList.add(model);
      Get.back();
      update();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
      Get.back();
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  void addListenerController() {
    doctorScrollController.addListener(() {
      if (doctorScrollController.position.maxScrollExtent == doctorScrollController.position.pixels) {
        if (currentPage.value < lastPage.value) {
          currentPage.value++;
          getDoctorsList(page: currentPage.value);
        }
      }
    });

    servicesScrollController.addListener(() {
      if (servicesScrollController.position.maxScrollExtent == servicesScrollController.position.pixels) {
        if (currentServicePage.value < lastServicePage.value) {
          currentServicePage.value++;
          getOrgServices(page: currentServicePage.value);
        }
      }
    });
  }
}
