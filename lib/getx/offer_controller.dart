import 'dart:io';

import 'package:espitaliaa_doctors/models/offer_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OfferController extends GetxController {
  var offerList = <OfferData>[];
  RxBool isOrg = false.obs;
  RxBool isLoading = false.obs;
  final pagingController = PagingController<int, OfferData>(
    // 2
    firstPageKey: 1,
  );
  Future<void> addNewOffer(context, {var body}) async {
    try {
      Loading().loading();
      var response = await ApiProvider()
          .postRequest(ServerVars.addNewOffer, body: body, isOrg: isOrg.value);
      Get.back();
      Get.back();
      pagingController.refresh();

      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 4),
        message:
            "${AppLocalizations.of(context).translate('success_offer_add')}",
      ));
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      //AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");

      AppUtils.showToast(msg: ApiException.unknownErr);
      Get.back();
    }
  }

  void startPagingControllerListener() {
    pagingController.addPageRequestListener((pageKey) {
      getOffersList(pageKey);
    });
  }

  getOffersList(int pageKey) async {
    try {
      offerList = [];
      var response = await ApiProvider().getRequest(
          ServerVars.getNewOffer + "?page=$pageKey",
          isOrg: isOrg.value);
      OfferModel model = OfferModel.fromJson(response.data);
      offerList.assignAll(model.data);
      int currentPage = model.meta.currentPage;
      int lastPage = model.meta.lastPage;
      final isLastPage = currentPage == lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(offerList);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(offerList, nextPageKey);
      }
      //   Get.back();
    } on SocketException catch (_) {
      Get.back();
      AppUtils.showToast(msg: ApiException.noInternetConnectionMsg);
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      //AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
// سينشس زثيؤموشتةثي شسةزؤموشوزثيظؤكززيؤزي يسوؤوؤي شتوثيزؤمو ؤءوو يوؤيسو يسويؤ وموم يوم سيسي س
