import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:espitaliaa_doctors/getx/appointment_controller.dart';
import 'package:espitaliaa_doctors/models/appointment_model.dart';
import 'package:espitaliaa_doctors/pages/appointment/appointment_card.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppointmentPage extends StatefulWidget {
  final appointmentController = Get.put(AppointmentController());

  AppointmentPage() {
    appointmentController.startPagingControllerListener();
  }
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final appointmentController = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*Obx(
      () => appointmentController.isLoading.value == true
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 15.0.w,
              ),
            )
          : appointmentController.appointmentList == null ||
                  appointmentController.appointmentList.isEmpty
              ? NoDataFound(
                  title: "no_appointment",
                )
              :*/
          RefreshIndicator(
        onRefresh: () async => appointmentController.pagingController.refresh(),
        child: /*Obx(
          () => appointmentController.isLoading.value == true &&
                  appointmentController.appointmentList.isNotEmpty
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 15.0.w,
                  ),
                )
              :  appointmentController.isLoading.value == false &&
                      (appointmentController.appointmentList == null ||
                          appointmentController.appointmentList.isEmpty)
                  ? NoDataFound(
                      title: "no_appointment",
                    )
                  : */
            Container(
          padding: const EdgeInsets.all(10.0),
          child: PagedListView<int, AppointmentData>(
              pagingController: appointmentController.pagingController,
              builderDelegate: PagedChildBuilderDelegate<AppointmentData>(
                  noItemsFoundIndicatorBuilder: (_) => NoDataFound(
                        title: "no_appointment",
                      ),
                  firstPageProgressIndicatorBuilder: (_) => const LoadingModel(
                        isLoadingDialog: true,
                      ),
                  firstPageErrorIndicatorBuilder: (_) => NoDataFound(
                        title: "no_appointment",
                      ),
                  newPageErrorIndicatorBuilder: (_) => NoDataFound(
                        title: "no_appointment",
                      ),
                  itemBuilder: (context, item, index) {
                    var model = item;
                    return AppointmentCard(
                      appointmentModel: model,
                      acceptFunc: () async {
                        if (model.status == "accepted") {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            animType: AnimType.BOTTOMSLIDE,
                            title: '',
                            desc: AppLocalizations.of(context).translate('patent_attended'),
                            btnCancelText: AppLocalizations.of(context).translate("no"),
                            btnOkText: AppLocalizations.of(context).translate('yes'),
                            btnCancelOnPress: () {
                              Get.back();
                            },
                            btnOkOnPress: () async {
                              var body = {"status": "attended"};
                              var result = await appointmentController.updateAppointment(model.id, body);
                              appointmentController.appointmentList[index] = result;
                            },
                          ).show();
                          return;
                        }
                        var body = {"status": "accepted"};
                        var result = await appointmentController.updateAppointment(model.id, body);
                        appointmentController.appointmentList[index] = result;
                      },
                      rejectFunc: () async {
                        Map<String, String> body;
                        if (model.status == 'accepted') {
                          body = {"status": "no_attended"};
                        } else {
                          body = {"status": "rejected"};
                        }

                        var result = await appointmentController.updateAppointment(model.id, body);
                        appointmentController.appointmentList[index] = result;
                      },
                    );
                  })),
        ),
      ),
    );
  }
}
