import 'package:espitaliaa_doctors/getx/org/home_org_controllers.dart';
import 'package:espitaliaa_doctors/models/org/org_services_model.dart';
import 'package:espitaliaa_doctors/pages/more/no_data_found.dart';
import 'package:espitaliaa_doctors/widgets/emergency_service_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServicesList extends StatelessWidget {
  final HomeOrgController orgController = Get.put(HomeOrgController());

  ServicesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return orgController.servicesList == null || orgController.servicesList.isEmpty
            ? NoDataFound(
                title: 'no_services',
                isSmallPage: true,
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: orgController.servicesScrollController,
                      itemBuilder: (context, index) {
                        ServicesData model = orgController.servicesList[index];
                        print("ServiceName= ${model.title}");
                        return EmergencyServiceCard(servicesData: model);
                      },
                      shrinkWrap: true,
                      itemCount: orgController.servicesList.length,
                    ),
                  ),
                  orgController.isLoading.value
                      ? Center(
                          child: CupertinoActivityIndicator(
                            radius: 15.0.w,
                          ),
                        )
                      : const SizedBox()
                ],
              );
      },
    );
  }
}
