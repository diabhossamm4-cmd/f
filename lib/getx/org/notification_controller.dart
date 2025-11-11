import 'dart:io';
import 'package:espitaliaa_doctors/models/org/notification_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationData> notificationList = <NotificationData>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getNotification(bool isOrg) async {
    try {
      isLoading.value = true;
      var response = await ApiProvider()
          .getRequest("${ServerVars.getNotification}", isOrg: isOrg);

      // Get.back();
      var result = NotificationModel.fromJson(response.data);
      notificationList.assignAll(result.data);
      isLoading.value = false;
      //   Get.back();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //Get.back();
      isLoading.value = false;

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
// if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      //  Get.back();
      isLoading.value = false;
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
