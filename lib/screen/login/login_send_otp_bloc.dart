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

  void getToken(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .token()
        .then((tokenValue) {
      if (tokenValue != null && tokenValue.accessToken != null) {
        if (tokenValue.accessToken!.isNotEmpty) {
          ApiClient.bearerToken = tokenValue.accessToken!;
          getURLs(context);
        }
      }
    });
  }

  void getURLs(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getURls()
        .then((getURls) {
      if (getURls != null &&
          getURls.resultflag == ApiClient.resultflagSuccess) {
        ApiClient.freshDeskUrl = getURls.data?.freshdeskurl ?? "";
        ApiClient.userManualUrl = getURls.data?.usermanualurl ?? "";
      }
    });
  }

  void sendOTP(BuildContext context) async {
    if (ApiClient.bearerToken.isNotEmpty) {
      var deviceId = await AppComponentBase.getInstance()
          ?.getSharedPreference()
          .getUserDetail(key: SharedPreference().deviceId);
      AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .registerDevice(mobileNo: mobNo.text, deviceId: deviceId)
          .then((commonData) {
        if (commonData != null &&
            commonData.resultflag == ApiClient.resultflagSuccess) {
          AppComponentBase.getInstance()
              ?.getApiInterface()
              .getApiRepository()
              .commonSendOTP(mobileNo: mobNo.text)
              .then((sendOTPData) {
            if (sendOTPData != null &&
                sendOTPData.resultflag == ApiClient.resultflagSuccess) {
              if (kDebugMode) {
                print("OTP : ${sendOTPData.data?.oTP}");
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginVerifyOTP(
                      enteredMobNo: mobNo.text, otp: sendOTPData.data?.oTP);
                }),
              );
            }
          });
        } else {
          CommonToast.getInstance()?.displayToast(
              message: commonData?.messages ?? StringUtils.sendOTPFail);
        }
      });
    } else {
      CommonToast.getInstance()
          ?.displayToast(message: StringUtils.someThingWentWrong);
    }
  }

  Future sendOTPUpdateMobile(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(email: email.text, type: ApiClient.otpTypeEmail)
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${sendOTPData.data?.oTP}");
        }
        updateMobOtp = "${sendOTPData.data?.oTP}";
      }
    });
  }

  void verifyOTPUpdateMobile(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(email: email.text, type: ApiClient.otpTypeEmail)
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        print("OTP : ${sendOTPData.data?.oTP}");
        otp.text = "${sendOTPData.data?.oTP}";
      }
    });
  }

  Future updateMobile(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .updateMobile()
        .then((commonData) {
      if (commonData != null &&
          commonData.resultflag == ApiClient.resultflagSuccess) {
        CommonToast.getInstance()?.displayToast(
            message: commonData.messages ?? StringUtils.updateMobSuccess);
      }
    });
  }

/*
  createPdf() async {
    var bytes = base64Decode(widget.base64String.replaceAll('\n', ''));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/example.pdf");
    await OpenFile.open("${output.path}/example.pdf");
    setState(() {});
  }*/

  @override
  void dispose() {}
}