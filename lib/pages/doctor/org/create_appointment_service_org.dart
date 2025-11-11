import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../getx/org/reverstion_appointment_service_org_controller.dart';
import '../../../utils/app_utils.dart';

class CreateAppointmentServiceOrg extends StatefulWidget {
  final int doctorId;
  final String orgType;

  const CreateAppointmentServiceOrg({Key key, @required this.doctorId, @required this.orgType}) : super(key: key);

  @override
  _CreateAppointmentServiceOrgState createState() => _CreateAppointmentServiceOrgState();
}

class _CreateAppointmentServiceOrgState extends State<CreateAppointmentServiceOrg> {
  String lang = "";
  final ReverstiotionServiceOrgController controller = Get.put(ReverstiotionServiceOrgController());

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('add_appointment'),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => controller.isLoading.value == true
                ? Center(
                    child: CupertinoActivityIndicator(
                      radius: 15.0.w,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).translate('reverstion_type'), style: TextStyle(fontSize: sizeWidth / 28)),
                            SizedBox(
                              width: sizeWidth / 30,
                            ),
                            Obx(
                              () => Container(
                                color: mainColor.withOpacity(.05),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: controller.selectedReversType.value,
                                    items: lang == "ar"
                                        ? schadualTypeAr
                                        : schadualTypeEn.map((Map map) {
                                            return DropdownMenuItem<String>(
                                              value: map['value'],
                                              child: Container(
                                                child: Text(map['name']),
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: ScreenUtil().setWidth(16),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    onChanged: (String select) {
                                      controller.selectedReversType.value = select;
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: sizeHeight / 30,
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.selectedReversType.value == 'by_time',
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context).translate('reverstion_time'),
                                  style: TextStyle(fontSize: sizeWidth / 28),
                                ),
                                SizedBox(
                                  width: sizeWidth / 20,
                                ),
                                Container(
                                  width: sizeWidth / 4,
                                  color: mainColor.withOpacity(.05),
                                  child: TextFormField(
                                    controller: controller.reverstionDurationController.value,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    //   textAlignVertical: TextAlignVertical.bottom,
                                    validator: (String input) {
                                      if (input.isEmpty) {
                                        return AppLocalizations.of(context).translate("required");
                                      } else {
                                        if (input == '0') {
                                          return AppLocalizations.of(context).translate('required');
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      hintMaxLines: 1,
                                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeHeight / 30,
                        ),
                        Divider(
                          color: Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Obx(
                            () => Column(
                                children: controller.listDays.map((e) {
                              int index = controller.listDays.indexOf(e);
                              return Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                        Text(
                                          e.dayName ?? '--',
                                          textScaleFactor: 1.0,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                            fontFamily: "Cairo",
                                          ),
                                        ),
                                        Switch(
                                          activeColor: mainColor,
                                          inactiveThumbColor: Colors.grey[350],
                                          onChanged: (select) {
                                            controller.onChangedSwitch(select, index);
                                          },
                                          /*(select) {
                                            e.active = select ? 1 : 0;
                                          },*/
                                          value: e.active == 1,
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: e.active == 1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context).translate('from'),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black,
                                                        fontFamily: "Cairo",
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await controller.showTime(e.startTime, context, index, from: true);
                                                      },
                                                      /*async{
                                                      TimeOfDay hour =
                                                      await _showTime(e.openAt);
                                                      setState(() {
                                                        e.openAt = hour;
                                                        start.replacing(hour: hour.hour);
                                                      });
                                                    },*/
                                                      child: Container(
                                                          width: sizeWidth / 6,
                                                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                          decoration: BoxDecoration(
                                                              color: mainColor.withOpacity(.05), borderRadius: BorderRadius.circular(5.0)),
                                                          child: Center(
                                                            child: Text(
                                                              controller.formatTimeOfDay(e.startTime),
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                fontFamily: "Cairo",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: sizeWidth * 0.07,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context).translate('to'),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black,
                                                        fontFamily: "Cairo",
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await controller.showTime(e.endTime, context, index, from: false);
                                                      },
                                                      child: Container(
                                                          width: sizeWidth / 6,
                                                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                                                          decoration: BoxDecoration(
                                                              color: mainColor.withOpacity(.05), borderRadius: BorderRadius.circular(5.0)),
                                                          child: Center(
                                                            child: Text(
                                                              controller.formatTimeOfDay(e.endTime),
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                fontFamily: "Cairo",
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: sizeWidth * 0.07,
                                                ),
                                                Visibility(
                                                  visible: controller.selectedReversType.value != 'by_time',
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context).translate('attendence_count'),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.black,
                                                          fontFamily: "Cairo",
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Container(
                                                        width: sizeWidth / 5,
                                                        color: mainColor.withOpacity(.05),
                                                        child: TextFormField(
                                                          initialValue: e.attendCount,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              e.attendCount = value;
                                                            });
                                                          },
                                                          textAlign: TextAlign.center,
                                                          maxLines: 1,
                                                          keyboardType: TextInputType.number,
                                                          //   textAlignVertical: TextAlignVertical.bottom,
                                                          validator: (String input) {
                                                            if (input.isEmpty) {
                                                              return AppLocalizations.of(context).translate("required");
                                                            } else {
                                                              if (input == '0') {
                                                                return AppLocalizations.of(context).translate('required');
                                                              } else {
                                                                return null;
                                                              }
                                                            }
                                                          },
                                                          decoration: const InputDecoration(
                                                            hintMaxLines: 1,
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 1),
                                                            border: InputBorder.none,
                                                            hintStyle: TextStyle(
                                                              fontSize: 8,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[600],
                                  ),
                                ],
                              );
                            }).toList()),
                          ),
                        ),
                        SizedBox(
                          height: sizeHeight / 30,
                        ),
                        MyButton(
                          borderRadius: 12,
                          width: ScreenUtil().setWidth(120),
                          text: AppLocalizations.of(context).translate('save'),
                          onTap: () {
                            AppUtils.hideKeyboard(context);
                            controller.submitAndSaveAppointment(context, widget.doctorId, widget.orgType);
                          },
                        ),
                        SizedBox(
                          height: sizeHeight / 30,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void getLanguage() async {
    await SharedPreferences.getInstance().then((pref) {
      lang = pref.getString('lang');
    });
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    // Get.delete<ReverstiotionServiceOrgController>();
    super.dispose();
  }
}
