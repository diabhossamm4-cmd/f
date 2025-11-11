import 'package:cached_network_image/cached_network_image.dart';
import 'package:espitaliaa_doctors/models/appointment_model.dart';
import 'package:espitaliaa_doctors/models/offer_model.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentData appointmentModel;
  final Function acceptFunc;
  final Function rejectFunc;
  AppointmentCard({this.appointmentModel, this.acceptFunc, this.rejectFunc});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String status = appointmentModel.status;

    return Card(
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          left: ScreenUtil().setWidth(15),
          right: ScreenUtil().setWidth(15),
        ),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0)),
        ),
        color: Colors.grey[200],
        elevation: 4,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(size.width / 30),
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${appointmentModel.date}",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: size.width / 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${appointmentModel.day}",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          Text(
                            appointmentModel.hour != null
                                ? convertAndFormatTime(
                                    appointmentModel.hour, context)
                                : '--',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: size.width / 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 2.0,
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(size.width / 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cardRows(
                              titleName: AppLocalizations.of(context)
                                  .translate('patient_name'),
                              details: Text("${appointmentModel.userName}")),
                          SizedBox(
                            height: size.height / 35.0,
                          ),
                          cardRows(
                              titleName: AppLocalizations.of(context)
                                  .translate('phone'),
                              details:
                                  Text(appointmentModel.userPhone ?? '--')),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(size.width / 50),
                            decoration: BoxDecoration(
                              color: status == "pending"
                                  ? mainColor.withOpacity(0.4)
                                  : status == "rejected" || status == "missed"
                                      ? Colors.grey[100]
                                      : status == "cancelled"
                                          ? Colors.red.withOpacity(0.3)
                                          : Colors.green[400].withOpacity(0.4),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              appointmentModel.status,
                              style: TextStyle(
                                color: status == "pending"
                                    ? mainColor
                                    : status == "rejected"
                                        ? Colors.red[700]
                                        : status == "missed"
                                            ? Colors.red[800]
                                            : status == "cancelled"
                                                ? Colors.red[900]
                                                : Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: status == "accepted" || status == "pending",
                  child: Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: acceptFunc,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff45E27F),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5.0))),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            status == "pending"
                                ? AppLocalizations.of(context)
                                    .translate('accept')
                                : status == "accepted"
                                    ? AppLocalizations.of(context)
                                        .translate("user_attended")
                                    : "$status",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width / 25),
                          )),
                        ),
                      )),
                ),
                Visibility(
                  visible: status == "pending" || status == 'accepted',
                  child: Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: rejectFunc,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              color: Color(0xffEA5D5D),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5.0))),
                          child: Center(
                              child: Text(
                                  status == "pending"
                                      ? AppLocalizations.of(context)
                                          .translate('reject')
                                      : status == "accepted"
                                          ? AppLocalizations.of(context)
                                              .translate("not_attended")
                                          : status,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width / 25,
                                      fontWeight: FontWeight.bold))),
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget cardRows({String titleName, Widget details, bool isDate}) {
    return Row(
      children: [
        Text(
          "$titleName :  ",
          style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: isDate != null ? 15 : 13),
        ),
        const SizedBox(
          width: 2.0,
        ),
        Expanded(child: details)
      ],
    );
  }

  String convertAndFormatTime(
    String time,
    context,
  ) {
    // String year = dateModel.date.date.sp
    String languageCode = Localizations.localeOf(context).languageCode;

    DateFormat format = DateFormat("hh:mm:ss");
    DateTime timeFormated = format.parse(time);
    DateFormat formatDate;
    if (languageCode == 'en') {
      formatDate = DateFormat('hh : mm a', languageCode);
    } else {
      formatDate = DateFormat('mm : hh a', languageCode);
    }

    return formatDate.format(timeFormated);
  }
}
