import 'dart:async';
import 'dart:convert';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/registration_request.dart';
import 'package:andapp/screen/dashboard/dashboard.dart';
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
  String? selectedSalutation = StringUtils.mr;
  String? mobileNo;
  String? selectedGender = StringUtils.male;
  String? selectedCertificateType;
  int? automatedManual = 0;
  bool withGSTA = false;

  Future<String?> sendAadharOTP(BuildContext context) async {
    var result = await AppComponentBase.getInstance()
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
        return sendOTPData.resultflag;
      }
    });
    return result;
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
      } else {
        CommonToast.getInstance()?.displayToast(
            message: getAadharData?.messages ?? StringUtils.verifyOTPFail);
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

  Future registerPosp(BuildContext context) async {
    AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId)
        .then((value) {
      RegistrationRequest registrationRequest = RegistrationRequest();
      PersonalDetails personalDetails = PersonalDetails();
      KYC kyc = KYC();
      personalDetails.pospId = value;
      personalDetails.userName = username.text;
      //personalDetails.salutation = "";
      personalDetails.emailId = email.text;
      if (automatedManual == 0) {
        personalDetails.firstName = aadharAName.text;
        kyc.addressProofName = aadharAName.text;
        /*personalDetails.middleName = middleName.text;
      personalDetails.lastName = lastName.text;*/
        personalDetails.gender = aadharAGender.text;
        personalDetails.address = aadharAAddress.text;
        personalDetails.dateOfBirth = aadharABirthDate.text;
        personalDetails.state = "";
        personalDetails.city = "";
        personalDetails.pincode = " ";
        kyc.preferenceType = "MA";
      } else {
        personalDetails.firstName = firstName.text;
        personalDetails.middleName = middleName.text;
        personalDetails.lastName = lastName.text;

        if (selectedGender == StringUtils.male) {
          personalDetails.gender = "M";
        } else {
          personalDetails.gender = "F";
        }
        kyc.preferenceType = "MM";
        personalDetails.address = "";
        personalDetails.dateOfBirth = "";
        personalDetails.state = "";
        personalDetails.city = "";
        personalDetails.pincode = "";
      }
      personalDetails.referredById = "0";
      //personalDetails.referredType = "";
      kyc.mobileNo = mobileNo;
      kyc.whatsappNo = whatsappNumber.text;
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

      kyc.bankName = bankAcHolderName.text;
      kyc.aadharNo = aadharNumber.text;
      kyc.educationProofType = selectedCertificateType;
      kyc.bankAccountNo = bankAcNo.text;
      kyc.ifsc = ifscCode.text;

      registrationRequest.personalDetails = [];
      registrationRequest.kYC = [];
      registrationRequest.personalDetails!.add(personalDetails);
      registrationRequest.kYC!.add(kyc);
      AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .registerPosp(
              addressProof: aadharFront,
              other: aadharBack,
              pan: pan,
              gst: gst,
              education: academicCerti,
              data: jsonEncode(registrationRequest))
          .then((registerPospData) {
        if (registerPospData != null &&
            registerPospData.resultflag == ApiClient.resultflagSuccess) {
          CommonToast.getInstance()?.displayToast(
              message:
                  registerPospData.messages ?? StringUtils.registerSuccess);
          AppComponentBase.getInstance()
              ?.getSharedPreference()
              .getUserDetail(key: SharedPreference().pospId)
              .then((value) =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Dashboard(
                      pospId: value,
                    );
                  })));
          //return registerPospData.resultflag;
        } else {
          CommonToast.getInstance()?.displayToast(
              message:
                  registerPospData?.messages ?? StringUtils.someThingWentWrong);
        }
      });
    });
    //return null;
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