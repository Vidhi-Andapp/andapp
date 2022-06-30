import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient {
  static String baseUrl = '';
  static String version = "";

  final String jsonHeaderName = 'Content-Type';
  final String jsonHeaderValue = 'application/json; charset=UTF-8';
  final String formHeaderValue =
      'multipart/form-data; boundary=<calculated when request is sent>';
  final int successResponse = 200;

  Map<String, String> getJsonHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    return header;
  }

  Map<String, String> getFormHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = formHeaderValue;
    return header;
  }

  gets(String url,
      {Map<String, String>? headers,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
      }
      AppComponentBase.getInstance()?.disableWidget(true);
      try {
        var response = await http.get(Uri.parse(url), headers: headers);
        logPrint(response: response);

        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);

        var responseStatus = json.decode(response.body);
        if ((responseStatus['Success'] ?? "") == true) {
          return responseStatus;
        } else {
          return responseStatus;
        }
      } catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);

        var e = exception is String
            ? exception
            : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetConnection);
      }
      throw StringUtils.noInternetConnection;
    }
  }

  posts(String url,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool isProgressBar = true,
      bool isBackground = false}) async {
    headers ??= getJsonHeader();
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      if (isProgressBar) {
        AppComponentBase.getInstance()?.showProgressDialog(true);
      }
      AppComponentBase.getInstance()?.disableWidget(true);
      try {
        var response = await http.post(Uri.parse(url),
            headers: headers, body: body, encoding: encoding);
        logPrint(requestData: body, response: response);

        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var responseStatus = json.decode(response.body);
        return responseStatus;
      } catch (exception) {
        if (isProgressBar) {
          AppComponentBase.getInstance()?.showProgressDialog(false);
        }
        AppComponentBase.getInstance()?.disableWidget(false);
        var e = exception is String
            ? exception
            : StringUtils.someThingWentWrong;
        if (!isBackground) {
          CommonToast.getInstance()?.displayToast(message: e);
        }
      }
    } else {
      if (!isBackground) {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.noInternetConnection);
      }
      throw StringUtils.noInternetConnection;
    }
  }

  void logPrint({String? requestData, Response? response}) {
    if (response != null) {
      debugPrint(
          '--------------------------------------------------------------');
      debugPrint(
          'request url :${response.request?.method}  ${response.request?.url}');
      debugPrint('request header : ${response.request?.headers}');
      if (requestData != null) {
        debugPrint('request body : ${requestData.toString()}');
      }
      debugPrint(
          '--------------------------------------------------------------');
      debugPrint('response header : ${response.headers}');
      debugPrint('response statusCode : ${response.statusCode}');
      debugPrint('response body : ${response.body}');
    }
  }
}
