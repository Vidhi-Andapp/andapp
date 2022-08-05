import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class LoginVerifyOTPBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;
  TextEditingController otp = TextEditingController();

  void verifyOTP(BuildContext context) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(mobileNo: otp.text)  //verify otp here
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                return const DocumentPage();
              }),
        );
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
