import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/screen/dashboard/dashboard.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
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

  void getStatus(BuildContext context, bool mounted, String mobileNo) async {
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
        if (getStatusData.data?.data?.pospStatus == 0) {
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const DocumentPage()),
                (Route<dynamic> route) => false);
          }
        } else if (getStatusData.data?.data?.pospStatus == 1) {
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                        pospId:
                            getStatusData.data?.data?.pospId.toString() ?? "")),
                (Route<dynamic> route) => false);
          }
        }
      }
    }
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