import 'dart:io';
import 'package:espitaliaa_doctors/models/appointment_model.dart';

import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppointmentController extends GetxController {
  var appointmentList = <AppointmentData>[];
  RxBool isLoading = false.obs;
  final pagingController = PagingController<int, AppointmentData>(
    // 2
    firstPageKey: 1,
  );
  void startPagingControllerListener() {
    pagingController.addPageRequestListener((pageKey) {
      getAppointment(pageKey);
    });
  }

  Future<void> getAppointment(int pageKey) async {
    try {
      // isLoading.value = true;
      appointmentList = [];
      var response = await ApiProvider().getRequest(
        "${ServerVars.getDoctorAppointment}?page=$pageKey",
      );

      var result = AppointmentModel.fromJson(response.data);
      appointmentList
        ..clear()
        ..assignAll(result.data);

      int currentPage = result.meta.currentPage;
      int lastPage = result.meta.lastPage;
      final isLastPage = currentPage == lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(appointmentList);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(appointmentList, nextPageKey);
      }
      //   Get.back();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      //AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  Future<AppointmentData> updateAppointment(int id, var body) async {
    try {
      Loading().loading();
      var response = await ApiProvider().postRequest(
        "${ServerVars.updateAppointment}$id",
        body: body,
      );
      pagingController.refresh();
      Get.back();

      AppointmentData result = AppointmentData.fromJson(response.data['data']);
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
}
