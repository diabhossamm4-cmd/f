import 'package:espitaliaa_doctors/getx/org/reverstion_appointment_doctor_org_controller.dart';
import 'package:espitaliaa_doctors/models/org/org_subsribers_model.dart';
import 'package:espitaliaa_doctors/pages/doctor/org/create_appointment_doctor_org.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EmergencyDoctorCard extends StatelessWidget {
  final SubscribersData doctorModel;
  EmergencyDoctorCard({Key key, @required this.doctorModel}) : super(key: key);
  final ReverstiotionDoctorOrgController _reverstiotionOrgController = Get.put(ReverstiotionDoctorOrgController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
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
                      doctorModel.name ?? '--',
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow[800],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    doctorModel.overalRate ?? '0.0',
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
                        doctorModel.bio ?? '--',
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
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  ServerVars.IMAGES_PREFIX_LINK + doctorModel.profilePic,
                ),
                radius: 30,
                /*  child: ClipOval(
                  child: Image.network(

                    fit: BoxFit.contain,
                  ),
                ),*/
                backgroundColor: Colors.transparent,
                /*
                backgroundImage: widget.doctorModel.profilePic == null
                    ? AssetImage('assets/images/avatar.jfif')
                    : CachedNetworkImageProvider(
                        //'$IMAGES_PREFIX_LINK'
                        '${widget.doctorModel.profilePic}',
                      ),*/
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
                    child: Text(doctorModel.bio ?? ''.trim()),
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
            SizedBox(
              width: ScreenUtil().setWidth(18),
            ),
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
                        '${doctorModel.price ?? '-'} ${AppLocalizations.of(context).translate('lever')}',
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setHeight(30),
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
                    AppLocalizations.of(context).translate(doctorModel.active == 1 ? "active" : "un_active"),
                    style: TextStyle(
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(18),
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
                    /*         MyButton(
                      onTap: () {
                        */ /*   doctorProvider.getData(doctorModel.id);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DoctorProfilePage(doctorId: doctorModel.id),
                          ),
                        );*/ /*
                      },
                      text: AppLocalizations.of(context).translate('book_now'),
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
                        var parms = {"doctor_id": "${doctorModel.id}", "type": "doctor"};
                        _reverstiotionOrgController.resetReserviation();
                        _reverstiotionOrgController.getDoctorAppointment(parms);
                        Get.to(() => CreateAppointmentDoctorOrg(
                              doctorId: doctorModel.id,
                              orgType: 'doctor',
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
    );
  }
}
