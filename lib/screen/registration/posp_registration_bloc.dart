import 'dart:async';
import 'dart:convert';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/registration_request.dart';
import 'package:andapp/services/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  PlatformFile? aadharFront, aadharBack, gst, pan, academicCertificate;
  String? selectedSalutation = StringUtils.mr;
  String? mobileNo;
  String? selectedGender = StringUtils.male;
  String? selectedCertificateType;
  int? automatedManual = 0;
  bool withGSTA = false;

  Future<String?> sendAadharOTP(BuildContext context) async {
    var sendOTPData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .commonSendOTP(
            aadharNo: aadharNumber.text, type: ApiClient.otpTypeAadhar);
    if (sendOTPData != null &&
        sendOTPData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${sendOTPData.data?.oTP}");
      }
      return sendOTPData.resultflag;
    }
    return null;
  }

  Future getAadharData(BuildContext context) async {
    var getAadharData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getAadharData(aadharNo: aadharNumber.text, otp: otp.text);
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
    } else {
      CommonToast.getInstance()?.displayToast(
          message: getAadharData?.messages ?? StringUtils.verifyOTPFail);
    }
  }

  Future getPanData(BuildContext context) async {
    var getPanData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getPanData(panNo: panNumber.text);

    if (getPanData != null &&
        getPanData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${getPanData.data?.data}");
      }
      panName.text = getPanData.data?.data?.panName ?? "";
    }
  }

  Future getGstData(BuildContext context) async {
    var getGstData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getGstData(gstNo: gstNumber.text);
    if (getGstData != null &&
        getGstData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${getGstData.data?.data}");
      }
      gstName.text = getGstData.data?.data?.gSTName ?? "";
      gstPanNumber.text = getGstData.data?.data?.pANNumber ?? "";
    }
  }

  Future getBankData(BuildContext context) async {
    var getPanData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getBankData(acNo: bankAcNo.text, ifsc: ifscCode.text);
    if (getPanData != null &&
        getPanData.resultflag == ApiClient.resultflagSuccess) {
      if (kDebugMode) {
        print("OTP : ${getPanData.data?.data}");
      }
      bankAcHolderName.text = getPanData.data?.data?.bankName ?? "";
    }
  }

  Future<String?> registerPosp(BuildContext context) async {
    var pospId = await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId);
    if (pospId != null) {
      RegistrationRequest registrationRequest = RegistrationRequest();
      PersonalDetails personalDetails = PersonalDetails();
      KYC kyc = KYC();
      personalDetails.pospId = pospId;
      personalDetails.userName = username.text;
      //personalDetails.salutation = "";
      personalDetails.emailId = email.text;
      if (automatedManual == 0) {
        personalDetails.firstName = aadharAName.text;
        kyc.aadharNo = aadharNumber.text;
        kyc.addressProofName = aadharAName.text;
        /*personalDetails.middleName = middleName.text;
      personalDetails.lastName = lastName.text;*/
        if (aadharAGender.text == StringUtils.male) {
          personalDetails.gender = "M";
        } else {
          personalDetails.gender = "F";
        }
        personalDetails.address = aadharAAddress.text;
        if (aadharABirthDate.text.isNotEmpty) {
          DateTime birthDate =
              DateFormat("dd-MMM-yyyy").parse(aadharABirthDate.text);
          var outputFormat = DateFormat('yyyy-MM-dd');
          personalDetails.dateOfBirth = outputFormat.format(birthDate);
        }
        personalDetails.state = "";
        personalDetails.city = "";
        personalDetails.pincode = " ";
        if (withGSTA) {
          kyc.accountType = StringUtils.personalWithGST;
          kyc.panNo = gstPanNumber.text;
          kyc.gSTName = gstName.text;
          kyc.gstNo = gstNumber.text;
          kyc.gstStatus = "";
        } else {
          kyc.accountType = StringUtils.personal;
          kyc.panNo = panNumber.text;
          kyc.panName = panName.text;
        }
        kyc.preferenceType = "A";
      } else {
        personalDetails.firstName = firstName.text;
        personalDetails.middleName = middleName.text;
        personalDetails.lastName = lastName.text;

        if (selectedGender == StringUtils.male) {
          personalDetails.gender = "M";
        } else {
          personalDetails.gender = "F";
        }
        personalDetails.address = "";
        personalDetails.dateOfBirth = "";
        personalDetails.state = "";
        personalDetails.city = "";
        personalDetails.pincode = "";
        if (withGSTA) {
          kyc.accountType = StringUtils.personalWithGST;
        } else {
          kyc.accountType = StringUtils.personal;
        }
        kyc.preferenceType = "M";
      }

      personalDetails.referredById = "0";
      //personalDetails.referredType = "";
      kyc.mobileNo = mobileNo;
      kyc.whatsappNo = whatsappNumber.text;
      kyc.bankName = bankAcHolderName.text;
      kyc.educationProofType = selectedCertificateType;
      kyc.bankAccountNo = bankAcNo.text;
      kyc.ifsc = ifscCode.text;

      registrationRequest.personalDetails = [];
      registrationRequest.kYC = [];
      registrationRequest.personalDetails!.add(personalDetails);
      registrationRequest.kYC!.add(kyc);
      var registerPospData = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .registerPosp(
              addressProof: aadharFront,
              other: aadharBack,
              pan: pan,
              gst: gst,
              education: academicCertificate,
              data: jsonEncode(registrationRequest));
      if (registerPospData != null &&
          registerPospData.resultflag == ApiClient.resultflagSuccess) {
        CommonToast.getInstance()?.displayToast(
            message: registerPospData.messages ?? StringUtils.registerSuccess);
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(key: SharedPreference().pospId, value: "1");
      }
      //return registerPospData.resultflag;
      else {
        CommonToast.getInstance()?.displayToast(
            message:
                registerPospData?.messages ?? StringUtils.someThingWentWrong);
        return pospId;
      }
    }
    return null;
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    whatsappNumber.dispose();
    aadharNumber.dispose();
    otp.dispose();
    aadharAName.dispose();
    aadharAGender.dispose();
    aadharABirthDate.dispose();
    aadharAAddress.dispose();
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    aadharMGender.dispose();
    panNumber.dispose();
    panName.dispose();
    gstNumber.dispose();
    gstPanNumber.dispose();
    gstName.dispose();
    bankAcNo.dispose();
    ifscCode.dispose();
    bankAcHolderName.dispose();
  }
}