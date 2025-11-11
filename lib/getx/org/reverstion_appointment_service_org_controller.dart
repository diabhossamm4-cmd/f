import 'dart:io';

import 'package:espitaliaa_doctors/models/create_reverstion_model.dart';
import 'package:espitaliaa_doctors/utils/api_provider.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:espitaliaa_doctors/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ReverstiotionServiceOrgController extends GetxController {
  var reverstionModel = new ReverstionModel().obs;
  var selectedReversType = 'by_time'.obs;
  var index = 0.obs();
  bool isFirstTime = false;
  var reverstionDurationController = TextEditingController(text: '20').obs;
  RxBool isLoading = false.obs;
  RxList<HourRange> listDays = <HourRange>[
    daysDefaultList[0],
    daysDefaultList[1],
    daysDefaultList[2],
    daysDefaultList[3],
    daysDefaultList[4],
    daysDefaultList[5],
    daysDefaultList[6],
  ].obs;
  final formKey = GlobalKey<FormState>();

  Future<void> getDoctorAppointment(var body) async {
    try {
      isLoading.value = true;

      var response = await ApiProvider().getRequest(
        ServerVars.appointmentOrgRule,
        parms: body,
        isOrg: true,
      );
      ReverstionData data = ReverstionData.fromJson(response.data);
      if (data.data.isNotEmpty) {
        isFirstTime = false;
        if (data.data[0].hourRange.isNotEmpty) {
          reverstionModel.value = data.data[0];
        } else {
          buildFirstReversion();
        }
      } else {
        isFirstTime = true;

        buildFirstReversion();
      }
      selectedReversType.value = reverstionModel.value.schadualType;

      if (reverstionModel.value != null)
        reverstionDurationController.value.text =
            reverstionModel.value.detectionDuration.toString();

      if (reverstionModel.value.hourRange != null &&
          reverstionModel.value.hourRange.length > 0) {
        reverstionModel.value.hourRange.forEach((element) {
          switch (element.dayName) {
            case "Saturday":
              listDays[0] = element;
              listDays[0].active = 1;

              break;
            case "Sunday":
              listDays[1] = element;
              listDays[1].active = 1;

              break;
            case "Monday":
              listDays[2] = element;
              listDays[2].active = 1;

              break;
            case "Tuesday":
              listDays[3] = element;
              listDays[3].active = 1;

              break;
            case "Wednesday":
              listDays[4] = element;
              listDays[4].active = 1;

              break;
            case "Thursday":
              listDays[5] = element;
              listDays[5].active = 1;

              break;
            case "Friday":
              listDays[6] = element;
              listDays[6].active = 1;

              break;
          }
        });
      } else {
        reverstionModel.value.hourRange = [];
      }

      reverstionModel.value.hourRange.assignAll(listDays);
      reverstionModel.value.hourRange.forEach((element) {});
      isLoading.value = false;
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      isLoading.value = false;
      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      // if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      isLoading.value = false;
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }

  resetReserviation() {
    reverstionModel.value = ReverstionModel(
        saturday: 0,
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        detectionDuration: 0,
        schadualType: "by_time");
    listDays
      ..clear()
      ..assignAll(daysDefaultList);
    listDays.forEach((element) {
      element.active = 0;
    });
  }

  void buildFirstReversion() {
    reverstionModel.value = ReverstionModel(
        saturday: 0,
        sunday: 0,
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        detectionDuration: 0,
        hourRange: [],
        schadualType: "by_time");
    listDays
      ..clear()
      ..assignAll(daysDefaultList);
  }

  Future<void> showTime(TimeOfDay timeNow, context, index, {bool from}) async {
    TimeOfDay selectedTime = await showTimePicker(
      confirmText: "موافق",
      cancelText: "الغاء",
      helpText: "",
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: timeNow,
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
    if (from)
      reverstionModel.value.hourRange[index].startTime = selectedTime;
    else
      reverstionModel.value.hourRange[index].endTime = selectedTime;

    listDays.assignAll(reverstionModel.value.hourRange);
  }

  void onChangedSwitch(select, int index) {
    var isSelected = select ? 1 : 0;

    reverstionModel.value.hourRange[index].active = isSelected;
    listDays.assignAll(reverstionModel.value.hourRange);

    switch (index) {
      case 0:
        reverstionModel.value.saturday = isSelected;
        break;

      case 1:
        reverstionModel.value.sunday = isSelected;
        break;

      case 2:
        reverstionModel.value.monday = isSelected;
        break;

      case 3:
        reverstionModel.value.tuesday = isSelected;
        break;

      case 4:
        reverstionModel.value.wednesday = isSelected;
        break;

      case 5:
        reverstionModel.value.thursday = isSelected;
        break;

      case 6:
        reverstionModel.value.friday = isSelected;
        break;

      default:
        break;
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = intl.DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String formatTimeToJson(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = intl.DateFormat('HH:mm:ss'); //"6:00 AM"
    return format.format(dt);
  }

  void submitAndSaveAppointment(context, int id, String orgType) {
    if (formKey.currentState.validate()) {
      reverstionModel.value.schadualType = selectedReversType.value;
      if (reverstionModel.value.detectionDuration != null)
        reverstionModel.value.detectionDuration =
            int.parse(reverstionDurationController.value.text);
      var list = <HourRange>[];
      listDays.map((element) {
        if (selectedReversType.value == 'by_time') element.attendCount = "0";

        if (element.active == 1) {
          element.startTimeToSend = formatTimeToJson(element.startTime);
          element.endTimeToSend = formatTimeToJson(element.endTime);

          list.add(element);
        }
      }).toList();
      reverstionModel.value.hourRange.assignAll(list);

      updateAppointmentRequest(context, id, orgType);
    }
  }

  void updateAppointmentRequest(context, int id, String orgType) async {
    try {
      Loading().loading();
      Map<String, dynamic> body = reverstionModel.value.toJson();
      if (orgType == 'doctor')
        body['doctor_meshmesh_id'] = id;
      else
        body['org_service_id'] = id;

      var response = await ApiProvider().postRequest(
        "${isFirstTime ? ServerVars.appointmentOrgRule : ServerVars.updateAppointmentOrgRule}",
        isOrg: true,
        body: body,
      );

      AppUtils.showToast(
          msg: AppLocalizations.of(context)
              .translate('add_appointment_success'));
      Get.back();
      Get.back();
    } on SocketException catch (_) {
    } on ApiException catch (e) {
      if (ServerVars.IS_DEBUG) print("_notificationsA ${e.toString()}");
      Get.back();

      AppUtils.showToast(msg: e.toString());
    } catch (e, stackTrace) {
      // if (ServerVars.IS_DEBUG) print("_notificationsS ${e.toString()}");
      Get.back();
      AppUtils.showToast(msg: ApiException.unknownErr);
    }
  }
}
