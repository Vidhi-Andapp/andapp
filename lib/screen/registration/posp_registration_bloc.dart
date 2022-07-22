import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class PospRegistrationBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsappNumber = TextEditingController();
  TextEditingController aadharNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController panName = TextEditingController();
  /* TextEditingController gender = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController gender = TextEditingController();*/

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
  @override
  void dispose() {}

}
