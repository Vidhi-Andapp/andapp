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
import 'package:andapp/services/api_services.dart';
import 'package:file_picker/file_picker.dart';

class ApiRepositoryIml extends ApiRepository {
  final ApiServices _apiServices = ApiServices();

  @override
  Future<Token?> token(
      {String? userName, String? pass, String? grantType}) async {
    return await _apiServices.token(
        userName ?? 'andapp', pass ?? 'andapp@2021', 'password');
  }

  @override
  Future<GetUrl?> getURls() async {
    return await _apiServices.getUrls();
  }

  @override
  Future<CommonData?> requestACallBack(
      {String? name,
      String? mobile,
      String? subject,
      String? date,
      String? timeFrom,
      String? timeTo}) async {
    return await _apiServices.requestACallBack(name ?? "", mobile ?? "",
        subject ?? "", date ?? "", timeFrom ?? "", timeTo ?? "");
  }

  @override
  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId}) {
    return _apiServices.registerDevice(mobileNo ?? '', deviceId ?? '');
  }

  @override
  Future<CommonData?> updateMobile({String? mobileNo, String? deviceId}) {
    return _apiServices.registerDevice(mobileNo ?? '', deviceId ?? '');
  }

  @override
  Future<SendOTP?> commonSendOTP(
      {String? mobileNo, String? type, String? aadharNo, String? email}) {
    return _apiServices.commonSendOTP(mobileNo ?? '',
        type ?? ApiClient.otpTypeSMS, aadharNo ?? "", email ?? "");
  }

  @override
  Future<GetStatus?> getStatus({String? mobileNo}) {
    return _apiServices.getStatus(mobileNo ?? '');
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

  @override
  Future<GetQuestionList?> getQuestions({String? trainingType}) {
    return _apiServices.getQuestions(trainingType ?? '');
  }

  @override
  Future<SubmitAnswer?> submitAnswers(
      {String? trainingType,
      required String pospId,
      required List<AnswerList> ansList}) {
    return _apiServices.submitAnswers(trainingType ?? '', pospId,
        ansList: ansList);
  }

  @override
  Future<CommonData?> registerPosp(
      {PlatformFile? addressProof,
      PlatformFile? pan,
      PlatformFile? account,
      PlatformFile? education,
      PlatformFile? gst,
      PlatformFile? other,
      PlatformFile? profile,
      String? data}) {
    return _apiServices.registerPosp(
        addressProof: addressProof,
        pan: pan,
        account: account,
        education: education,
        gst: gst,
        other: other,
        profile: profile,
        data: data);
  }

  @override
  Future<GetDashboard?> getDashboard({String? id}) {
    return _apiServices.getDashboard(id ?? "");
  }

  @override
  Future<GetProfile?> getProfile({String? id}) {
    return _apiServices.getProfile(id ?? "");
  }

  @override
  Future<CommonData?> updateProfilePhoto(
      {String? id, required PlatformFile profilePhoto}) {
    return _apiServices.updateProfilePhoto(
      id: id ?? "",
      profilePhoto: profilePhoto,
    );
  }

  @override
  Future<CommonData?> completeTrainingDay(
      {String? trainingType, String? day, String? pospId}) {
    return _apiServices.completeTrainingDay(
        trainingType ?? "", day ?? "", pospId ?? "");
  }

  @override
  Future<DownloadCertificate?> downloadCertificate(
      {String? id, String? trainingType}) {
    return _apiServices.downloadCertificate(id ?? "", trainingType ?? '');
  }

  @override
  Future<CommonData?> reExam({String? id, String? trainingType}) {
    return _apiServices.reExam(id ?? "", trainingType ?? '');
  }
}

abstract class ApiRepository {
  Future<Token?> token({String? userName, String? pass, String? grantType});

  Future<GetUrl?> getURls();

  Future<CommonData?> requestACallBack(
      {String? name,
      String? mobile,
      String? subject,
      String? date,
      String? timeFrom,
      String? timeTo});

  Future<CommonData?> registerDevice({String? mobileNo, String? deviceId});

  Future<CommonData?> updateMobile({String? mobileNo, String? deviceId});

  Future<SendOTP?> commonSendOTP(
      {String? mobileNo, String? type, String? aadharNo, String? email});

  Future<GetStatus?> getStatus({String? mobileNo});

  Future<GetAadhar?> getAadharData({String? aadharNo, String? otp});

  Future<GetPan?> getPanData({String? panNo});

  Future<GetGst?> getGstData({String? gstNo});

  Future<GetBank?> getBankData({String? acNo, String? ifsc});

  Future<GetQuestionList?> getQuestions({String? trainingType});

  Future<SubmitAnswer?> submitAnswers(
      {String? trainingType,
      required String pospId,
      required List<AnswerList> ansList});

  Future<CommonData?> registerPosp(
      {PlatformFile? addressProof,
      PlatformFile? pan,
      PlatformFile? account,
      PlatformFile? education,
      PlatformFile? gst,
      PlatformFile? other,
      PlatformFile? profile,
      String? data});

  Future<GetDashboard?> getDashboard({String? id});

  Future<GetProfile?> getProfile({String? id});

  Future<CommonData?> updateProfilePhoto(
      {String? id, required PlatformFile profilePhoto});

  Future<CommonData?> completeTrainingDay(
      {String trainingType, String day, String pospId});

  Future<DownloadCertificate?> downloadCertificate(
      {String? id, String? trainingType});

  Future<CommonData?> reExam({String? id, String? trainingType});
/*Future<Map<String, dynamic>> commonValidateOTP({String? mobileNo, String? type, String? otp, String? email});*/
}