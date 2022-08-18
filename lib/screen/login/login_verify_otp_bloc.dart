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

  Future<int?>? reSendOTP(BuildContext context, String mobNo) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(mobileNo: mobNo)
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${sendOTPData.data?.oTP}");
          //otp.text = "${sendOTPData.data?.oTP}";
          return sendOTPData.data?.oTP;
        }
      }
    });
    return null;
  }

  void getStatus(BuildContext context, String mobileNo) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getStatus(mobileNo: mobileNo) //verify otp here
        .then((getStatusData) {
      if (getStatusData != null &&
          getStatusData.resultflag == ApiClient.resultflagSuccess) {
        if (getStatusData.data != null && getStatusData.data?.data != null) {
          AppComponentBase.getInstance()?.getSharedPreference().setUserDetail(
              key: SharedPreference().pospId,
              value: getStatusData.data?.data?.pospId.toString());
          if (getStatusData.data?.data?.pospStatus == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const DocumentPage();
              }),
            );
          } else if (getStatusData.data?.data?.pospStatus == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Dashboard(
                    pospId: getStatusData.data?.data?.pospId.toString() ?? "");
              }),
            );
          }
        }
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