import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/get_status.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginVerifyOTPBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  TextEditingController otp = TextEditingController();

  Future<int?>? reSendOTP(BuildContext context, String mobNo) async {
    var sendOTPData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(mobileNo: mobNo);
    if (sendOTPData != null &&
        sendOTPData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${sendOTPData.data?.oTP}");
        //otp.text = "${sendOTPData.data?.oTP}";
        return sendOTPData.data?.oTP;
      }
    }
    return null;
  }

  Future<GetStatus?> getStatus(BuildContext context, bool mounted, String mobileNo) async {
    await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .setUserDetail(key: SharedPreference().mobileNumber, value: mobileNo);

    var getStatusData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getStatus(mobileNo: mobileNo); //verify otp here
    if (getStatusData != null &&
        getStatusData.resultflag == ApiClient.resultflagSuccess) {
      if (getStatusData.data != null && getStatusData.data?.data != null) {
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(
                key: SharedPreference().pospId,
                value: getStatusData.data?.data?.pospId.toString());
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(
                key: SharedPreference().pospStatus,
                value: getStatusData.data?.data?.pospStatus.toString());
        return getStatusData;
        }
      }
    return null;
    }

  @override
  void dispose() {
    // TODO: implement dispose
  }
  }