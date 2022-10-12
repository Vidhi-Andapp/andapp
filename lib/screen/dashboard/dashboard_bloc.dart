import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/download_certificate.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';

class DashboardBloc extends BlocBase {
  static DashboardBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  StreamController<GetDashboardData> dashboardStreamController =
      StreamController<GetDashboardData>.broadcast();

  Stream<GetDashboardData> get dashboardStream =>
      dashboardStreamController.stream;

  StreamController<
      DownloadCertificate> resultStreamController =
      StreamController<DownloadCertificate>.broadcast();

  Stream<DownloadCertificate> get resultStream => resultStreamController.stream;

  StreamController<ProfileData?> profileStreamController =
      StreamController<ProfileData?>.broadcast();

  Stream<ProfileData?> get profileStream => profileStreamController.stream;

  static DashboardBloc getInstance() {
    _instance ??= DashboardBloc();
    return _instance!;
  }

  Future getDashboard(BuildContext context, String pospId,
      {bool isProgressBar = true}) async {
    if (await AppComponentBase.getInstance()
        ?.getNetworkManager()
        .isConnected() ??
        false) {
      var getDashboard = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .getDashboard(id: pospId,isProgressBar: isProgressBar);
      if (getDashboard != null &&
          getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
        //await getProfile(pospId);
      }
    }
    else {
      var dashboard = await AppComponentBase.getInstance()
          ?.getSharedPreference()
          .getUserDetail(key: SharedPreference().dashboard);
      var getDashboard = GetDashboard.fromJson(json.decode(dashboard));
      if (getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
      }
    }
  }

  Future getProfile(String pospId) async {
    if (await AppComponentBase.getInstance()
        ?.getNetworkManager()
        .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .getProfile(id: pospId,isProgressBar: false);
      /*if (getProfile != null &&
          getProfile.resultflag == ApiClient.resultflagSuccess &&
          getProfile.data != null && !isBackground) {
        profileStreamController.sink.add(getProfile.data?.data);
      }*/
    }
  /*  else {
      var profile = await AppComponentBase.getInstance()
          ?.getSharedPreference()
          .getUserDetail(key: SharedPreference().profile);
      var getProfile = GetProfile.fromJson(json.decode(profile));
      if (getProfile.resultflag == ApiClient.resultflagSuccess &&
          getProfile.data != null && !isBackground) {
        profileStreamController.sink.add(getProfile.data?.data);
      }
    }*/
  }

  void downloadCertificate(
      BuildContext context, String pospId, String trainingType) async {
    var downloadCertificate = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .downloadCertificate(
          id: pospId,
          trainingType: trainingType == StringUtils.generalInsurance
              ? ApiClient.trainingTypeGI
              : ApiClient.trainingTypeLI,
        );
      if (downloadCertificate != null &&
          downloadCertificate.resultflag == ApiClient.resultflagSuccess &&
          downloadCertificate.data != null) {
        await createPdf(downloadCertificate.data?.data?.image ?? "",trainingType);
        CommonToast.getInstance()?.displayToast(
            message: StringUtils.downloadSuccess);
        resultStreamController.sink.add(downloadCertificate);
      }
    }

  Future createPdf(String source,String trainingType) async {
//    String dir = (await getApplicationDocumentsDirectory()).path;
    /*File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");*/
    var type = trainingType == StringUtils.generalInsurance
        ? ApiClient.trainingTypeGI
        : ApiClient.trainingTypeLI;
    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    var bytes = base64Decode(source.replaceAll('\n', ''));
    var file = io.File("$path/posp_certificate_$type.png");
    var raf = file.openSync(mode: io.FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(bytes);
    await raf.close();

//    await file.writeAsBytes(bytes);

// or
    //file.writeAsBytesSync(bytes);

    /* final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());

    print("${output.path}/example.pdf");
    await OpenFile.open("${output.path}/example.pdf");*/
    //setState(() {});
  }

  Future<bool> reExam(
      BuildContext context, String pospId, String trainingType) async {
    var commonData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .reExam(
          id: pospId,
          trainingType: trainingType == StringUtils.generalInsurance
              ? ApiClient.trainingTypeGI
              : ApiClient.trainingTypeLI,
        );
    if (commonData != null &&
        commonData.resultflag == ApiClient.resultflagSuccess &&
        commonData.data != null) {
      return true;
      //resultStreamController.sink.add(commonData);
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}