import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/models/org/org_subsribers_model.dart';
import 'package:espitaliaa_doctors/pages/doctor/org/edit_doctor_page.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/widgets/emergency_doctor_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DoctorList extends StatelessWidget {
  final HomeOrgController orgController = Get.put(HomeOrgController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return orgController.doctorsList == null || orgController.doctorsList.length == 0
          ? NoDataFound(
              title: 'no_doctors',
              isSmallPage: true,
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: orgController.doctorScrollController,
                    itemBuilder: (context, index) {
                      SubscribersData model = orgController.doctorsList[index];
                      int price = model.price;

                      return GestureDetector(
                          onTap: () {
                            Get.to(EditDoctorPage(
                              doctorModel: model,
                            ));
                          },
                          child: EmergencyDoctorCard(doctorModel: model));
                    },
                    itemCount: orgController.doctorsList.length,
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
                orgController.isLoading.value
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
