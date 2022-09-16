import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

import '../../model/download_certificate.dart';

class DashboardBloc extends BlocBase {
  static DashboardBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  StreamController<GetDashboardData> dashboardStreamController =
      StreamController<GetDashboardData>.broadcast();

  Stream<GetDashboardData> get dashboardStream =>
      dashboardStreamController.stream;

  StreamController<DownloadCertificate> resultStreamController =
      StreamController<DownloadCertificate>.broadcast();

  Stream<DownloadCertificate> get resultStream => resultStreamController.stream;

  StreamController<ProfileData?> profileStreamController =
      StreamController<ProfileData?>.broadcast();

  Stream<ProfileData?> get profileStream => profileStreamController.stream;

  static DashboardBloc getInstance() {
    _instance ??= DashboardBloc();
    return _instance!;
  }

  Future getDashboard(BuildContext context, String pospId) async {
    var getDashboard = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getDashboard(id: pospId);
    if (getDashboard != null &&
        getDashboard.resultflag == ApiClient.resultflagSuccess &&
        getDashboard.data != null) {
      dashboardStreamController.sink.add(getDashboard.data!);
      //await getProfile(pospId);
    }
  }

  Future getProfile(String pospId) async {
    var getProfile = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProfile(id: pospId);
    if (getProfile != null &&
        getProfile.resultflag == ApiClient.resultflagSuccess &&
        getProfile.data != null) {
      profileStreamController.sink.add(getProfile.data?.data);
    }
  }

  void downloadCertificate(
      BuildContext context, String pospId, String trainingType) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .downloadCertificate(
          id: pospId,
          trainingType: trainingType == StringUtils.generalInsurance
              ? ApiClient.trainingTypeGI
              : ApiClient.trainingTypeLI,
        )
        .then((downloadCertificate) {
      if (downloadCertificate != null &&
          downloadCertificate.resultflag == ApiClient.resultflagSuccess &&
          downloadCertificate.data != null) {
        resultStreamController.sink.add(downloadCertificate);
      }
    });
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