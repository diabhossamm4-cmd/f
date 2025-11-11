import 'package:espitaliaa_doctors/models/create_reverstion_model.dart';
import 'package:flutter/material.dart';

Color mainColor = Color(0xff01B5B6);
ScrollPhysics bouncingScroll = BouncingScrollPhysics();
bool showDevicePreviewMode = false;

String googleMapApiKey = "AIzaSyAfqSPSU0T476NtAp4jHwCTrMOYU9KlXS8";

var supportedLanguages = [
  Locale('en', 'US'),
  Locale('ar', 'EG'),
];

var schadualTypeAr = [
  {'name': 'الحجز باسبقية الحضور', 'value': 'first_come'},
  {'name': 'الحجز بميعاد', 'value': 'by_time'},
];
var schadualTypeEn = [
  {'name': 'First come ', 'value': 'first_come'},
  {'name': 'Reservation by date', 'value': 'by_time'},
];

final List<HourRange> daysDefaultList = [
  HourRange(
    dayName: "Saturday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    //  day: "saturday"
  ),
  HourRange(
    dayName: "Sunday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    //     day: "sunday"
  ),
  HourRange(
    dayName: "Monday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    //  day: "monday"
  ),
  HourRange(
    dayName: "Tuesday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    //     day: "tuesday"
  ),
  HourRange(
    dayName: "Wednesday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    // day: "wednesday"
  ),
  HourRange(
    dayName: "Thursday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    // day: "thursday"
  ),
  HourRange(
    dayName: "Friday",
    active: 0,
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 20, minute: 0),
    //  day: "friday"
  ),
];

class ServerVars {
  static const Global_BASE_URL = 'https://espitaliaa.com/api/';
  static const DOCTOR_BASE_URL = 'https://espitaliaa.com/api/doctor/';
  static const ORGANIZATION_BASE_URL = 'https://espitaliaa.com/api/org/';

  static const IMAGES_PREFIX_LINK = 'https://espitaliaa.com';

  // http://192.168.1.27:8000
  static const bool IS_DEBUG = true;

  ///General EndPoints

  static const String getDoctorTitlesLoginEndPoint = "/doctor-titles";
  static const String getCitiesEndPoint = "/cities";
  static const String getOrgTypesEndPoint = "/org-types";

  static const String getDistrictsEndPoint = "/districts/";
  static const String getSpecializationsEndPoint = "/specializations";

  ////////////////// Doctor EndPoints ///////////////////
  /// Auth EndPoints

  static const String loginEndPoint = "/doctor-login";
  static const String registerEndPoint = "/doctor-register";
  static const String userInfo = "/doctor-info";
  static const String updateInfo = "/update-info";
  static const String activeAccount = "/active-account";
  static const String resendCodeVerification = "/resend-code";
  static const String updatePasswords = "/update-password";
  static const String forgetPasswords = "/doctor-reset-password";

  /// Create Offer

  static const String addNewOffer = "/offer";
  static const String getNewOffer = "/offer";

  /// Appointment
  static const String updateDoctorAppointment = "/update-appointment-role";
  static const String showDoctorAppointment = "/appointment-role";
  static const String getDoctorAppointment = "/appointment";

/////////////////////////// ORganization  EndPoints /////////////////////////////////////////////

  /// Auth EndPoints
  static const String loginOrgEndPoint = "/organization-login";
  static const String registerOrgEndPoint = "/organization-register";
  static const String orgInfo = "/org-info";
  static const String forgetOrgPasswords = "/org-reset-password";

  /// Doctor Meshmsh  List
  static const String orgSubscribersEndPoint = "/org-subscriber";
  static const String updateOrgSubscriber = "/update-org-subscriber/";

  /// OrgServices  List
  static const String orgServicesList = "/org-service";
  static const String updateOrgServices = "/update-org-service/";

  /// Appointment
  static const String getAppointment = "/appointment";
  static const String updateAppointment = "/update-appointment/";

  ///APPointmentRole
  static const String appointmentOrgRule = "/appointment-role";
  static const String updateAppointmentOrgRule = "/update-appointment-role";

  ///Notification
  static const String getNotification = "/notification";

  /// AboutUs
  static const String getAboutUs = "/about-us";
}
