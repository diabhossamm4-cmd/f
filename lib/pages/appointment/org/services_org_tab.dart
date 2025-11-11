import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:espitaliaa_doctors/getx/org/appointment_controller.dart';
import 'package:espitaliaa_doctors/pages/appointment/org/appointment_org_card.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrgServicesTab extends StatelessWidget {
  final appointmentController = Get.put(AppointmentOrgController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appointmentController.isLoadFirstTime.value == true
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 15.0.w,
                  ),
                )
              : appointmentController.appointmentServiceList == null || appointmentController.appointmentServiceList.isEmpty
                  ? Center(
                      child: NoDataFound(
                        title: "no_appointment",
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        controller: appointmentController.servicesScrollController,
                        itemBuilder: (context, index) {
                          var model = appointmentController.appointmentServiceList[index];
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
                                  btnCancelText: AppLocalizations.of(context).translate('no'),
                                  btnOkText: AppLocalizations.of(context).translate('yes'),
                                  btnCancelOnPress: () {
                                    Get.back();
                                  },
                                  btnOkOnPress: () async {
                                    var body = {"status": "attended"};
                                    var result = await appointmentController.updateAppointment(model.id, body);
                                    if (result != null) {
                                      appointmentController.appointmentServiceList[index] = result;
                                    }
                                  },
                                ).show();
                                return;
                              }
                              var body = {"status": "accepted"};
                              var result = await appointmentController.updateAppointment(model.id, body);
                              if (result != null) {
                                appointmentController.appointmentServiceList[index] = result;
                              }
                            },
                            rejectFunc: () async {
                              Map<String, String> body;

                              if (model.status == 'accepted') {
                                body = {"status": "no_attended"};
                              } else {
                                body = {"status": "rejected"};
                              }

                              var result = await appointmentController.updateAppointment(model.id, body);
                              if (result != null) {
                                appointmentController.appointmentServiceList[index] = result;
                              }
                            },
                          );
                        },
                        itemCount: appointmentController.appointmentServiceList.length,
                      ),
                    ),
          appointmentController.isLoading.value
              ? Center(
                  child: CupertinoActivityIndicator(
                    radius: 15.0.w,
                  ),
                )
              : SizedBox()
        ],
      );
    });
  }
}
