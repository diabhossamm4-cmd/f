import 'dart:math';

import 'package:flutter/material.dart';

class ReverstionData {
  List<ReverstionModel> data;

  ReverstionData({this.data});

  ReverstionData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ReverstionModel>();
      json['data'].forEach((v) {
        data.add(new ReverstionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReverstionModel {
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String schadualType;
  int detectionDuration;
  List<HourRange> hourRange;

  ReverstionModel(
      {this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.schadualType,
      this.detectionDuration,
      this.hourRange});

  ReverstionModel.fromJson(Map<String, dynamic> json) {
    saturday = json['saturday'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    schadualType = json['schadual_type'];
    detectionDuration = json['detection_duration'] != null
        ? int.parse(json['detection_duration'])
        : 20;
    if (json['appointmentHoursRange'] != null) {
      hourRange = new List<HourRange>();
      json['appointmentHoursRange'].forEach((v) {
        hourRange.add(new HourRange.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['schadual_type'] = this.schadualType;
    data['detection_duration'] = this.detectionDuration;
    if (this.hourRange != null) {
      data['hour_range'] = this.hourRange.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HourRange {
  String dayName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String startTimeToSend;
  String endTimeToSend;
  String attendCount;
  int active;
  HourRange(
      {this.dayName,
      this.startTime,
      this.endTime,
      this.attendCount,
      this.active});

  HourRange.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    startTime = json['start_time'] != null
        ? TimeOfDay(
            hour: int.parse(json['start_time'].split(":")[0]),
            minute: int.parse(json['start_time'].split(":")[1]))
        : null;
    endTime = json['end_time'] != null
        ? TimeOfDay(
            hour: int.parse(json['end_time'].split(":")[0]),
            minute: int.parse(json['end_time'].split(":")[1]))
        : null;
    attendCount = json['attend_count'] is int
        ? json['attend_count'].toString()
        : json['attend_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_name'] = this.dayName;
    data['start_time'] = this.startTimeToSend;
    data['end_time'] = this.endTimeToSend;
    data['attend_count'] = this.attendCount;
    return data;
  }
}

/*
class WorkingDays {
  String day;
  String dayText;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String openAtConverter;
  String closingAtConverter;
  int active;
  String attendCount;
  WorkingDays(
      {this.day,
      this.attendCount,
      this.startTime,
      this.endTime,
      this.active,
      this.openAtConverter,
      this.closingAtConverter});

  WorkingDays.fromJson(Map<String, dynamic> json) {
    day = json['day_name'];
    startTime = json['start_time'] != null
        ? TimeOfDay(
            hour: int.parse(json['start_time'].split(":")[0]),
            minute: int.parse(json['start_time'].split(":")[1]))
        : null;

    endTime = json['end_time'] != null
        ? TimeOfDay(
            hour: int.parse(json['end_time'].split(":")[0]),
            minute: int.parse(json['end_time'].split(":")[1]))
        : null;
    attendCount = json['attend_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day_name'] = this.day;
    data['start_time'] = this.openAtConverter;
    data['end_time'] = this.closingAtConverter;
    data['active'] = this.active;
    data['attend_count'] = this.attendCount;
    return data;
  }
}
*/
