import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'login_verify_otp_page.dart';

class LoginSendOTPBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  TextEditingController mobNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  String? updateMobOtp;

  Future getURLs(BuildContext context) async {
    var getURls = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getURls();
    if (getURls != null && getURls.resultflag == ApiClient.resultflagSuccess) {
      ApiClient.freshDeskUrl = getURls.data?.freshdeskurl ?? "";
      ApiClient.userManualUrl = getURls.data?.usermanualurl ?? "";
    }
  }

  Future sendOTP(BuildContext context, bool mounted) async {
    if (ApiClient.bearerToken.isEmpty) {
      var tokenValue = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .token();
      if (tokenValue != null && tokenValue.accessToken != null) {
        if (tokenValue.accessToken!.isNotEmpty) {
          ApiClient.bearerToken = tokenValue.accessToken!;
        }
    }}
      var deviceId = await AppComponentBase.getInstance()
          ?.getSharedPreference()
          .getUserDetail(key: SharedPreference().deviceId);
      var sendOTPDataResponse = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .commonSendOTP(mobileNo: mobNo.text);
      if (sendOTPDataResponse != null &&
          sendOTPDataResponse.resultflag == ApiClient.resultflagSuccess) {
        var commonData = await AppComponentBase.getInstance()
            ?.getApiInterface()
            .getApiRepository()
            .registerDevice(mobileNo: mobNo.text, deviceId: deviceId);
          if (commonData != null &&
              commonData.resultflag == ApiClient.resultflagSuccess) {
            if (kDebugMode) {
              print("OTP : ${sendOTPDataResponse.data?.oTP}");
            }
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginVerifyOTP(
                    enteredMobNo: mobNo.text,
                    otp: sendOTPDataResponse.data?.oTP);
              }),
            );
          } else {
            CommonToast.getInstance()?.displayToast(
                message: commonData?.messages ?? StringUtils.sendOTPFail);
          }
      } else {
        CommonToast.getInstance()?.displayToast(
            message: sendOTPDataResponse?.messages ?? StringUtils.sendOTPFail);
      }

  }
  Future sendOTPUpdateMobile(BuildContext context) async {
    var sendOTPData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(email: email.text, type: ApiClient.otpTypeEmail);
    if (sendOTPData != null &&
        sendOTPData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${sendOTPData.data?.oTP}");
      }
      updateMobOtp = "${sendOTPData.data?.oTP}";
    } else {
      CommonToast.getInstance()?.displayToast(
          message: sendOTPData?.messages ?? StringUtils.sendOTPFail);
    }
  }

  void verifyOTPUpdateMobile(BuildContext context) async {
    var sendOTPData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(email: email.text, type: ApiClient.otpTypeEmail);
    if (sendOTPData != null &&
        sendOTPData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${sendOTPData.data?.oTP}");
      }
      otp.text = "${sendOTPData.data?.oTP}";
    }
  }

  Future updateMobile(BuildContext context) async {
    var commonData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateMobile();
    if (commonData != null &&
        commonData.resultflag == ApiClient.resultflagSuccess) {
      CommonToast.getInstance()?.displayToast(
          message: commonData.messages ?? StringUtils.updateMobSuccess);
    }
  }


  @override
  void dispose() {}
}