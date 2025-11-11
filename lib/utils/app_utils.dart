import 'dart:io';

/*
import 'package:connectivity/connectivity.dart';
*/
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
/*
*/

import 'consts.dart';

class AppUtils {
/*
  PermissionStatus status;
*/

/*  static Future<bool> getConnectionState() async {
    return await DataConnectionChecker().hasConnection;
  }*/

/*
  bool getNetworkState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  }
*/

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static showToast({@required msg, int timeInSeconds, Color backgroundColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    /*if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //  return Future.error('Location services are disabled.');
      return null;
    }*/

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        //  return Future.error('Location permissions are denied');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      /*return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');*/
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  // true if granted : false if denied
/*  static Future<bool> askExternalStoragePermission() async {
    bool permissionState = false;
    await PermissionHandler().requestPermissions([
      PermissionGroup.storage,
    ]).then(
      (Map<PermissionGroup, PermissionStatus> map) {
        if (map[PermissionGroup.storage] == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );

    return permissionState;
  }*/

  // true if granted : false if denied
/*  static Future<bool> askOpenGalleryPermission() async {
    bool permissionState = false;
    await PermissionHandler().requestPermissions([
      PermissionGroup.photos,
    ]).then(
      (Map<PermissionGroup, PermissionStatus> map) {
        if (map[PermissionGroup.photos] == PermissionStatus.granted) {
          permissionState = true;
        } else {
          permissionState = false;
        }
      },
    );

    print('state of permission >>>> $permissionState');
    return permissionState;
  }

  static bool getNetworkStatePresestence(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.none:
        return false;
      default:
        return false;
    }
  }*/

  static Future<void> downloadFile(String fileUrl) async {
    if (Platform.isAndroid) {
      _downloadOnAndroid(fileUrl);
    } else {
      _downloadOnIos(fileUrl);
    }
  }

  static void _downloadOnAndroid(String fileUrl) async {
    String directoryLocation = "";
    try {
      directoryLocation = "/sdcard/download/";
      await Dio().download(fileUrl, '$directoryLocation${DateTime.now()}.jpg');
      AppUtils.showToast(
        msg: 'تم التحميل',
        backgroundColor: mainColor,
      );
    } catch (error) {
      directoryLocation = (await getExternalStorageDirectory()).path;
      await Dio().download(fileUrl, '$directoryLocation${DateTime.now()}.jpg');
      AppUtils.showToast(
        msg: 'تم التحميل',
        backgroundColor: mainColor,
      );
    }
  }

  static void openLink(String linkUrl) async {
    if (await canLaunch(linkUrl)) {
      await launch(
        linkUrl,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $linkUrl';
    }
  }

  static void _downloadOnIos(String fileUrl) async {
    String directoryLocation = "";
    try {
      AppUtils.showToast(msg: 'بدء التحميل', backgroundColor: mainColor);
      await Dio().download(fileUrl, '$directoryLocation${DateTime.now()}.jpg');
      AppUtils.showToast(msg: 'تم التحميل', backgroundColor: mainColor);
    } catch (error) {
      AppUtils.showToast(msg: 'لم يتم التحميل', backgroundColor: mainColor);
      print(error.toString());
    }
  }
}
