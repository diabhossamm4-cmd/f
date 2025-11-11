import 'package:espitaliaa_doctors/models/org/org_services_model.dart';
import 'package:espitaliaa_doctors/pages/home/org/edit_service_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../getx/org/reverstion_appointment_service_org_controller.dart';
import '../pages/doctor/org/create_appointment_service_org.dart';

class EmergencyServiceCard extends StatelessWidget {
  final ServicesData servicesData;

  final ReverstiotionServiceOrgController _reverstiotionOrgController = Get.put(ReverstiotionServiceOrgController());

  EmergencyServiceCard({Key key, this.servicesData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Get.to(() => EditServicePage(
              serviceModel: servicesData,
            ));
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(16),
          vertical: ScreenUtil().setHeight(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(8.0),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        /* AppLocalizations.of(context).translate(
                                      doctorModel.gender == "male"
                                          ? 'dr_title_male'
                                          : "dr_title_female") +*/
                        servicesData.title ?? '--',
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.yellow[800],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      servicesData.overalRate ?? '0.0',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          servicesData.description ?? '--',
                          style: TextStyle(
                            fontSize: 12,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.edit,
                        color: mainColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(18),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(4),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/clinic.png'),
                    SizedBox(
                      width: ScreenUtil().setWidth(18),
                    ),
                    Expanded(
                      child: Text(servicesData.description ?? ''.trim()),
                    ),
                  ],
                ),
              ),
              /*  Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setHeight(4),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: mainColor,
                        size: 22,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(18),
                      ),
                      Flexible(
                        child: Text(
                          '${AppLocalizations.of(context).translate('address')} :  ${doctorModel.address ?? ''}',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),*/
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.moneyBillWave,
                      color: mainColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(18),
                    ),
                    Row(
                      children: [
                        Text('${AppLocalizations.of(context).translate('detection_price')}  :  '),
                        Text(
                          '${servicesData.price ?? '-'} ${AppLocalizations.of(context).translate('lever')}',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.chartArea,
                      color: mainColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(18),
                    ),
                    Text('${AppLocalizations.of(context).translate('offer_status')}  :  '),
                    Text(
                      AppLocalizations.of(context).translate(servicesData.active == 1 ? "active" : "un_active"),
                      style: TextStyle(
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10),
                  top: ScreenUtil().setHeight(16),
                  bottom: ScreenUtil().setHeight(10),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      /*   MyButton(
                        onTap: () {
                          */ /*   doctorProvider.getData(doctorModel.id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    DoctorProfilePage(doctorId: doctorModel.id),
                              ),
                            );*/ /*
                        },
                        text:
                            AppLocalizations.of(context).translate('book_now'),
                        width: ScreenUtil().setWidth(90),
                        borderRadius: 8,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        height: ScreenUtil().setHeight(30),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(10),
                      ),*/
                      MyButton(
                        onTap: () {
                          var parms = {"service_id": "${servicesData.id}", "type": "service"};
                          _reverstiotionOrgController.resetReserviation();

                          _reverstiotionOrgController.getDoctorAppointment(parms);
                          Get.to(() => CreateAppointmentServiceOrg(
                                doctorId: servicesData.id,
                                orgType: 'service',
                              ));
                        },
                        text: AppLocalizations.of(context).translate('add_appointment'),
                        width: ScreenUtil().setWidth(90),
                        borderRadius: 8,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        height: ScreenUtil().setHeight(30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
