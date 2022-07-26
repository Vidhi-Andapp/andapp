import 'package:andapp/model/get_aadhar_data.dart';
import 'package:andapp/model/common_data.dart';
import 'package:andapp/model/get_bank_data.dart';
import 'package:andapp/model/get_gst_data.dart';
import 'package:andapp/model/get_pan_data.dart';
import 'package:andapp/model/get_urls.dart';
import 'package:andapp/model/send_otp.dart';
import 'package:andapp/model/token.dart';
import 'package:andapp/services/api_client.dart';
import 'package:andapp/services/api_services.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();
  @override
  Future<Token?> token({String? userName, String? pass,String? grantType}) async {
    return await _apiServices.token(userName ?? 'andapp', pass ?? 'andapp@2021','password');
  }

  @override
  Future<GetUrl?> getURls() async {
    return await _apiServices.getUrls();
  }

  @override
  Future<CommonData?> requestACallBack({String? name, String? mobile,String? subject,String? date, String? timeFrom,String? timeTo}) async {
    return await _apiServices.requestACallBack(name ?? "",mobile ?? "",subject ?? "",date ?? "",timeFrom ?? "",timeTo ?? "");
  }

  @override
  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId}) {
    return _apiServices.registerDevice(mobileNo ?? '9408878267', deviceId ?? 'ABCFSH635468-6541388adkj!@');
  }
  @override
  Future<CommonData?> updateMobile({String? mobileNo, String? deviceId}) {
    return _apiServices.registerDevice(mobileNo ?? '9408878267', deviceId ?? 'ABCFSH635468-6541388adkj!@');
  }

  @override
  Future<SendOTP?> commonSendOTP({String? mobileNo, String? type, String? aadharNo, String? email}) {
    return _apiServices.commonSendOTP(mobileNo ?? '', type ?? ApiClient.otpTypeSMS,aadharNo ?? "",email ?? "");
  }

  @override
  Future<GetAadhar?> getAadharData({String? aadharNo, String? otp}) {
    return _apiServices.getAadharData(aadharNo ?? '', otp ?? "");
  }

  @override
  Future<GetPan?> getPanData({String? panNo}) {
    return _apiServices.getPanData(panNo ?? '');
  }

  @override
  Future<GetGst?> getGstData({String? gstNo}) {
    return _apiServices.getGSTData(gstNo ?? '');
  }

  @override
  Future<GetBank?> getBankData({String? acNo, String? ifsc}) {
    return _apiServices.getBankData(acNo ?? '', ifsc ?? "");
  }

/*  @override
  Future<Map<String, dynamic>> commonValidateOTP({String? mobileNo, String? type, String? otp, String? email}) {
    return _apiServices.commonSendOTP(mobileNo ?? '', ApiClient.otpTypeSMS,"","");
  }
  @override
  Future<Map<String, dynamic>> registerPosp({String? acNo, String? ifsc}) {
    // TODO: implement registerPosp
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getDashboard() {
    // TODO: implement getDashboard
    throw UnimplementedError();
  }*/
}

abstract class ApiRepository {
  Future<Token?> token({String? userName, String? pass,String? grantType});
  Future<GetUrl?> getURls();
  Future<CommonData?> requestACallBack({String? name, String? mobile,String? subject,String? date, String? timeFrom,String? timeTo});
  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId});
  Future<CommonData?> updateMobile({String? mobileNo, String? deviceId});
  Future<SendOTP?> commonSendOTP({String? mobileNo, String? type, String? aadharNo, String? email});
  Future<GetAadhar?> getAadharData({String? aadharNo, String? otp});
  Future<GetPan?> getPanData({String? panNo});
  Future<GetGst?> getGstData({String? gstNo});
  Future<GetBank?> getBankData({String? acNo, String? ifsc});
  /*Future<Map<String, dynamic>> commonValidateOTP({String? mobileNo, String? type, String? otp, String? email});
  Future<Map<String, dynamic>> registerPosp({String? acNo, String? ifsc});
  Future<Map<String, dynamic>> getDashboard();*/
}
