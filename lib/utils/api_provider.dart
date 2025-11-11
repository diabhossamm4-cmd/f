import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:espitaliaa_doctors/models/user_model.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future<String> _getUserToken() async {
    UserModel user = UserModel();
    String userToken = await user.getToken;
    //if (userToken == null) throw "User Not Logged In";
    return userToken;
  }

  Future<String> _getLang() async {
    String langCode = await SharedPreferences.getInstance()
        .then((value) => value.getString("lang"));
    if (langCode == null)
      return 'ar';
    else
      return langCode;
  }

  static const Map<String, dynamic> apiHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json, text/plain, */*",
    "X-Requested-With": "XMLHttpRequest",
  };

//////////////////////////////
// ////////////////////////////////////////////////
//////////////////////////////// Helpers Functions /////////////////////////////
  void _debugApi({
    String fileName = "ApiProvider.dart",
    @required String methodName,
    @required int statusCode,
    @required response,
    @required data,
    @required endPoint,
  }) {
    if (ServerVars.IS_DEBUG)
      debugPrint(
        "FileName: $fileName\n"
        "Method: $methodName\n"
        "${endPoint != null ? 'EndPoint: $endPoint\n' : ''}"
        "${data != null ? 'Sent with data: $data\n' : ''}"
        "Returned with statusCode: $statusCode\n"
        "${response != null ? 'Returned with Response: $response\n' : ''}"
        "--------------------",
        wrapWidth: 512,
      );
  }

  Future<Response> getRequest(String url,
      {var parms, bool isGlobalUrl, bool isOrg, String validateToken}) async {
    // Retrieving User Token
    // Http Request
    String lang = await _getLang();
    var userToken = await _getUserToken();

    Dio dio = Dio();
    Response response;

    try {
      // final result = await InternetAddress.lookup('google.com');
      response = await dio
          .get(
              '${isGlobalUrl != null ? ServerVars.Global_BASE_URL : isOrg != null && isOrg == true ? ServerVars.ORGANIZATION_BASE_URL : ServerVars.DOCTOR_BASE_URL}$lang$url',
              queryParameters: parms,
              options: Options(headers: {
                HttpHeaders.authorizationHeader: validateToken ?? "$userToken",
                ...apiHeaders
              }))
          .timeout(Duration(seconds: 30));
      // Decoding Response.

      // Debugging API response

    } on TimeoutException catch (_) {
      throw SocketException(ApiException.noInternetConnectionMsg);
    } on DioError catch (e) {
      print('\n\n ---.Future<Response> get catch (e >>> $e\n\n\n');
      print('type= ${e.type.name}');
      if (e.response != null) response = e.response;
    }
    _debugApi(
      methodName: "$url",
      statusCode: response?.statusCode,
      response: response,
      data: null,
      endPoint: response?.requestOptions?.path,
    );

    // Response Handling
    if (response != null && _isValidResponse(response.statusCode)) {
      // Ok

      return response;
    } else {
      throw _apiExceptionGenerator(response.statusCode, response);
    }
  }

  Future<Response> postRequest(String url,
      {@required var body,
      bool isGlobalURl,
      bool isOrg,
      String validateToken}) async {
    // Retrieving User Token
    // Http Request
    Dio dio = Dio();

    var userToken = await _getUserToken();
    String lang = await _getLang();
    Response response;

    try {
      await dio
          .post(
              '${isGlobalURl != null ? ServerVars.Global_BASE_URL : isOrg != null && isOrg == true ? ServerVars.ORGANIZATION_BASE_URL : ServerVars.DOCTOR_BASE_URL}$lang$url',
              data: body,
              options: Options(headers: {
                HttpHeaders.authorizationHeader: validateToken ?? "$userToken",
                ...apiHeaders
              }))
          .then((value) {
        response = value;
      });
    } on DioError catch (e) {
      print('\n\n ---.Future<Response> get catch (e >>> $e\n\n\n');
      if (e.response != null)
        response = e.response;
      else {
        throw const SocketException("Internet Loading Problem");
      }
    }

    // Decoding Response.
    // Debugging API response
    _debugApi(
      methodName: "$url",
      statusCode: response?.statusCode,
      response: response,
      data: body,
      endPoint: response?.requestOptions?.path,
    );

    // Response Handling
    if (_isValidResponse(response.statusCode)) {
      // Ok

      return response;
    } else {
      // No Success

      throw _apiExceptionGenerator(response.statusCode, response);
    }
  }

  bool _isValidResponse(int statusCode) {
    return statusCode >= 200 && statusCode <= 302;
  }

  Exception _apiExceptionGenerator(int statusCode, Response decoded) {
    // print("aaa ${decoded['error'].values.toList()[0][0]}");
    String error = "";
    if (decoded.data['error'] != null) {
      /* if (decoded.data['error'] is List) {*/

      decoded.data['error'].values.forEach((e) {
        error = error += ("${e[0]}\n");
      });
      throw ApiException(
        code: statusCode,
        message: "",
        reason: (error),
      );
      /* } else {
        throw ApiException(
            code: statusCode,
            reason: "${decoded.data['error']['message']}",
            message: "");
      }*/
    } else {
      throw ApiException(
        code: statusCode,
        reason: "${decoded.data['message']}",
        message: "",
      );
    }
  }
}
