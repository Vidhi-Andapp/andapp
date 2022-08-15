import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/services/api_client.dart';
import 'package:file_picker/file_picker.dart';
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
  TextEditingController panNumber = TextEditingController();
  TextEditingController panName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController gstPanNumber = TextEditingController();
  TextEditingController gstName = TextEditingController();
  TextEditingController bankAcNo = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankAcHolderName = TextEditingController();
  PlatformFile? aadharFront, aadharBack, gst, pan, academicCerti;

  Future<String?> sendAadharOTP(BuildContext context) async {
    await AppComponentBase.getInstance()
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
        return sendOTPData.resultflag;
      }
    });
    return null;
  }

  Future getAadharData(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAadharData(aadharNo: aadharNumber.text, otp: otp.text)
        .then((getAadharData) {
      if (getAadharData != null &&
          getAadharData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${getAadharData.data?.data}");
        }
        aadharAName.text = getAadharData.data?.data?.fullname ?? "";
        var gender = getAadharData.data?.data?.gender ?? "";
        if (gender == "M") {
          aadharAGender.text = "Male";
        } else {
          aadharAGender.text = "Female";
        }
        aadharABirthDate.text = getAadharData.data?.data?.dob ?? "";
        aadharAAddress.text = getAadharData.data?.data?.address?.address ?? "";
      }
    });
  }

  Future getPanData(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getPanData(panNo: panNumber.text)
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

  Future getGstData(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getGstData(gstNo: gstNumber.text)
        .then((getGstData) {
      if (getGstData != null &&
          getGstData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${getGstData.data?.data}");
        }
        gstName.text = getGstData.data?.data?.gSTName ?? "";
        gstPanNumber.text = getGstData.data?.data?.pANNumber ?? "";
      }
    });
  }

  Future getBankData(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getBankData(acNo: bankAcNo.text, ifsc: ifscCode.text)
        .then((getPanData) {
      if (getPanData != null &&
          getPanData.resultflag == ApiClient.resultflagSuccess) {
        if (kDebugMode) {
          print("OTP : ${getPanData.data?.data}");
        }
        bankAcHolderName.text = getPanData.data?.data?.bankName ?? "";
      }
    });
  }

  Future<String?> registerPosp(BuildContext context) async {
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .registerPosp()
        .then((registerPospData) {
      if (registerPospData != null &&
          registerPospData.resultflag == ApiClient.resultflagSuccess) {
        return registerPospData.resultflag;
      }
    });
    return null;
  }

  @override
  void dispose() {}
}