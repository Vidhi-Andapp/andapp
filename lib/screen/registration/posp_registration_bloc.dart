import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PospRegistrationBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  Stream get mainStream => mainStreamController.stream;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsappNumber = TextEditingController();
  TextEditingController aadharNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController aadharAName = TextEditingController();
  TextEditingController aadharAGender = TextEditingController();
  TextEditingController aadharABirthDate = TextEditingController();
  TextEditingController aadharAAddress = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController aadharMGender = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController panName = TextEditingController();
   TextEditingController gstNumber = TextEditingController();
  TextEditingController bankAcNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankAcHolderName = TextEditingController();


  void sendAadharOTP(BuildContext context) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(
        aadharNo: aadharNumber.text, type: ApiClient.otpTypeAadhar)
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${sendOTPData.data?.oTP}");
        }
        //otp.text = "${sendOTPData.data?.oTP}";
      }
    });
  }
/*
  void validateOTP(BuildContext context) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(mobileNo: otp.text)  //verify otp here
        .then((sendOTPData) {
      if (sendOTPData != null &&
          sendOTPData.resultflag == ApiClient.resultflagSuccess) {
        *//*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                return const DocumentPage();
              }),
        );*//*
      }
    });
  }*/

  Future getAadharData(BuildContext context) async{
    await AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAadharData(
        aadharNo: aadharNumber.text, otp: otp.text)
        .then((getAadharData) {
      if (getAadharData != null &&
          getAadharData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${getAadharData.data?.data}");
        }
        aadharAName.text = getAadharData.data?.data?.fullname ?? "";
        aadharAGender.text = getAadharData.data?.data?.gender ?? "";
        aadharABirthDate.text = getAadharData.data?.data?.dob ?? "";
        aadharAAddress.text = getAadharData.data?.data?.address?.address ?? "";
      }
    });
  }

  Future getPanData(BuildContext context) async{
    await AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getPanData(
        panNo: panNo.text)
        .then((getPanData) {
      if (getPanData != null &&
          getPanData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${getPanData.data?.data}");
        }
        panName.text = getPanData.data?.data?.panName ?? "";
      }
    });
  }


  @override
  void dispose() {}

}
