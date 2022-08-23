import 'dart:convert';

import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/common_data.dart';
import 'package:andapp/model/download_certificate.dart';
import 'package:andapp/model/get_aadhar_data.dart';
import 'package:andapp/model/get_bank_data.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/model/get_gst_data.dart';
import 'package:andapp/model/get_pan_data.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/model/get_status.dart';
import 'package:andapp/model/get_urls.dart';
import 'package:andapp/model/send_otp.dart';
import 'package:andapp/model/submit_answer.dart';
import 'package:andapp/model/token.dart';
import 'package:andapp/services/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ApiServices extends ApiClient {
  Future<Token?> token(String userName, String pass, String grantType) async {
    Map<String, String> body = {
      'username': userName,
      'password': pass,
      'grant_type': grantType
    };
    if (kDebugMode) {
      print(body);
    }
    Map<String, String> updatedBody = Map<String, String>.from(body);
    var response = await posts(ApiClient.token,
        body: updatedBody,
        headers: getUrlEncodedHeader(),
        encoding: Encoding.getByName('utf-8'),
        isProgressBar: false,
        isBackground: true);
    if (response != null) {
      var data = Token.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetUrl?> getUrls() async {
    var response = await posts(ApiClient.getUrls,
        isProgressBar: false, isBackground: true);
    if (response != null) {
      var data = GetUrl.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonData?> requestACallBack(String name, String mobile,
      String subject, String date, String timeFrom, String timeTo) async {
    Map<String, String> body = {
      "name": name,
      "mobile": mobile,
      "subject": subject,
      "date": date,
      "timeFrom": timeFrom,
      "timeTo": timeTo
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.requestACallBack,
        body: jsonString, isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonData?> registerDevice(String mobileNo, String deviceId) async {
    Map<String, String> body = {
      'mobile_no': mobileNo,
      'deviceid': deviceId,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.registerDevice,
        body: jsonString, isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<SendOTP?> commonSendOTP(
      String mobileNo, String type, String aadharNo, String email) async {
    Map body = {
      "mobile_no": mobileNo,
      "type": type,
      "aadhar_no": aadharNo,
      "email_id": email
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.sendOTP,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = SendOTP.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetStatus?> getStatus(String mobileNo) async {
    Map body = {
      "mobile_no": mobileNo,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getStatus,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetStatus.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetAadhar?> getAadharData(String aadharNo, String otp) async {
    Map body = {
      "Aadhar_no": aadharNo,
      "OTP": otp,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getAadharData,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetAadhar.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetPan?> getPanData(String panNo) async {
    Map body = {
      "Pan_no": panNo,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getPanData,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetPan.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetGst?> getGSTData(String gstNo) async {
    Map body = {
      "GST_no": gstNo,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getGstData,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetGst.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetBank?> getBankData(String acNo, String ifsc) async {
    Map body = {
      "Account_no": acNo,
      "IFSC": ifsc,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getBankData,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetBank.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetDashboard?> registerPosp(
      {PlatformFile? addressProof,
      PlatformFile? pan,
      PlatformFile? account,
      PlatformFile? education,
      PlatformFile? gst,
      PlatformFile? other,
      PlatformFile? profile,
      String? data}) async {
    Map body = {
      "id": data,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.registerPosp,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetDashboard.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetDashboard?> getDashboard(String id) async {
    Map body = {
      "id": id,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getDashboard,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      AppComponentBase.getInstance()
          ?.getSharedPreference()
          .setUserDetail(key: SharedPreference().dashboard, value: response);
      var data = GetDashboard.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetProfile?> getProfile(String id) async {
    Map body = {
      "id": id,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getProfile,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      AppComponentBase.getInstance()
          ?.getSharedPreference()
          .setUserDetail(key: SharedPreference().dashboard, value: response);
      var data = GetProfile.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonData?> completeTrainingDay(
      String trainingType, String day, String pospId) async {
    Map body = {"training_type": trainingType, "day": day, "posp_id": pospId};
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.completeTrainingDay,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetQuestionList?> getQuestions(String trainingType) async {
    Map body = {
      "training_type": trainingType,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getQuestionAnswerList,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = GetQuestionList.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<SubmitAnswer?> submitAnswers(String trainingType, String pospId,
      {required List<AnswerList> ansList}) async {
    Map body = {
      "training_type": trainingType,
      "posp_id": pospId,
      "answerlist": (ansList)
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.submitAnswers,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = SubmitAnswer.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<DownloadCertificate?> downloadCertificate(
      String id, String trainingType) async {
    Map body = {
      "posp_id": id,
      "training_type": trainingType,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.downloadCerti,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = DownloadCertificate.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonData?> reExam(String id, String trainingType) async {
    Map body = {
      "posp_id": id,
      "training_type": trainingType,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.reExam,
        body: jsonString,
        headers: getJsonHeader(),
        encoding: Encoding.getByName('utf-8'),
        isBackground: true);
    if (response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future submitForm(dynamic data) async {
    String body = jsonEncode(data);
    if (kDebugMode) {
      print(body);
    }
    var response = await posts('', body: body, isBackground: true);
    return response;
  }
}