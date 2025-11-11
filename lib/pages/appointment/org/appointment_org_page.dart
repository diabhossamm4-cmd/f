import 'package:espitaliaa_doctors/getx/org/appointment_controller.dart';
import 'package:espitaliaa_doctors/pages/appointment/org/appointment_org_card.dart';
import 'package:espitaliaa_doctors/pages/appointment/org/doctors_org_tab.dart';
import 'package:espitaliaa_doctors/pages/appointment/org/services_org_tab.dart';
import 'package:espitaliaa_doctors/pages/offers/no_offers_found_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentOrgPage extends StatefulWidget {
  @override
  _AppointmentOrgPageState createState() => _AppointmentOrgPageState();
}

class _AppointmentOrgPageState extends State<AppointmentOrgPage>
    with TickerProviderStateMixin {
  final appointmentController = Get.put(AppointmentOrgController());
  TabController _controller;

  @override
  void initState() {
    super.initState();
    initData();

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(
        ScreenUtil().setWidth(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(controller: _controller, indicatorColor: Colors.orange,

              /*  indicator: BoxDecoration(
                    //  color: GlobalColors.buttonColor2,
                    border: Border(
                      right: BorderSide(color: Colors.grey), // for right side
                    ),
                  ),*/
              tabs: [
                Tab(
                  child: Text(
                    AppLocalizations.of(context).translate('doctors'),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 2.0,
                        fontSize: 17.0.w),
                  ),
                ),
                Tab(
                    child: Text(
                  AppLocalizations.of(context).translate('services'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      height: 2.0,
                      fontSize: 17.0.w),
                )),
              ]),
          Expanded(
            child: Container(
              //height: 300,
              child: TabBarView(
                  controller: _controller,
                  children: [OrgDoctorsTab(), OrgServicesTab()]),
            ),
          )
        ],
      ),
    );

    Obx(
      () => Scaffold(
          backgroundColor:
              appointmentController.appointmentHospitalDoctorsList == null &&
                      appointmentController
                              .appointmentHospitalDoctorsList.length ==
                          0
                  ? mainColor
                  : Colors.white,
          body: appointmentController.appointmentHospitalDoctorsList == null &&
                  appointmentController.appointmentHospitalDoctorsList.length ==
                      0
              ? NoOffersPage()
              : Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var model = appointmentController
                          .appointmentHospitalDoctorsList[index];
                      return AppointmentCard(
                        appointmentModel: model,
                      );
                    },
                    itemCount: appointmentController
                        .appointmentHospitalDoctorsList.length,
                  ),
                )),
    );
  }

  void initData() async {
    appointmentController.initData();
  }
}
