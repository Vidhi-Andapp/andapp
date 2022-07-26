import 'dart:convert';

import 'package:andapp/model/get_aadhar_data.dart';
import 'package:andapp/model/common_data.dart';
import 'package:andapp/model/get_bank_data.dart';
import 'package:andapp/model/get_gst_data.dart';
import 'package:andapp/model/get_pan_data.dart';
import 'package:andapp/model/get_urls.dart';
import 'package:andapp/model/send_otp.dart';
import 'package:andapp/model/token.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';

class ApiServices extends ApiClient {
  Future<Token?> token(String userName, String pass, String grantType) async {
    Map<String, String> body = {
      'username': userName,
      'password': pass,
      'grant_type': grantType
    };
    print(body);
    Map<String, String> updatedBody = Map<String, String>.from(body);
    var response = await posts(ApiClient.token,body: updatedBody,headers: getUrlEncodedHeader(),encoding: Encoding.getByName('utf-8'),isProgressBar: false, isBackground: true);
    if(response != null) {
      var data = Token.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetUrl?> getUrls() async {
    var response = await gets(ApiClient.getUrls,isProgressBar: false, isBackground: true);
    if(response != null) {
      var data = GetUrl.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<CommonData?> requestACallBack(String name, String mobile,String subject,String date, String timeFrom,String timeTo) async {
    Map<String, String> body = {
      "name" : name,
      "mobile" : mobile,
      "subject" : subject,
      "date" : date,
      "timeFrom" : timeFrom,
      "timeTo" : timeTo
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.requestACallBack,body: jsonString, isBackground: true);
    if(response != null) {
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
    var response = await posts(ApiClient.registerDevice,body: jsonString, isBackground: true);
    if(response != null) {
      var data = CommonData.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<SendOTP?> commonSendOTP(String mobileNo,String type, String aadharNo, String email) async {
    Map body = {
      "mobile_no" : mobileNo,
      "type" : type,
      "aadhar_no" : aadharNo,
      "email_id" : email
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.sendOTP,body: jsonString,headers: getJsonHeader(),encoding: Encoding.getByName('utf-8'), isBackground: true);
    if(response != null) {
      var data = SendOTP.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetAadhar?> getAadharData(String aadharNo,String otp) async {
    Map body = {
      "Aadhar_no" : aadharNo,
      "OTP" : otp,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getAadharData,body: jsonString,headers: getJsonHeader(),encoding: Encoding.getByName('utf-8'), isBackground: true);
    if(response != null) {
      var data = GetAadhar.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetPan?> getPanData(String panNo) async {
    Map body = {
      "Pan_no" : panNo,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getPanData,body: jsonString,headers: getJsonHeader(),encoding: Encoding.getByName('utf-8'), isBackground: true);
    if(response != null) {
      var data = GetPan.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetGst?> getGSTData(String gstNo) async {
    Map body = {
      "GST_no" : gstNo,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getGstData,body: jsonString,headers: getJsonHeader(),encoding: Encoding.getByName('utf-8'), isBackground: true);
    if(response != null) {
      var data = GetGst.fromJson(json.decode(response));
      return data;
    }
    return null;
  }

  Future<GetBank?> getBankData(String acNo,String ifsc) async {
    Map body = {
      "Account_no" : acNo,
      "IFSC" : ifsc,
    };
    String jsonString = json.encode(body);
    var response = await posts(ApiClient.getBankData,body: jsonString,headers: getJsonHeader(),encoding: Encoding.getByName('utf-8'), isBackground: true);
    if(response != null) {
      var data = GetBank.fromJson(json.decode(response));
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
