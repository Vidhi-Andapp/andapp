import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

import '../../model/download_certificate.dart';

class DashboardBloc extends BlocBase {
  static DashboardBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<GetDashboardData> dashboardStreamController =
      StreamController<GetDashboardData>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<GetDashboardData> get dashboardStream =>
      dashboardStreamController.stream;
  StreamController<DownloadCertificate> resultStreamController =
      StreamController<DownloadCertificate>.broadcast();

  Stream<DownloadCertificate> get resultStream => resultStreamController.stream;

  static DashboardBloc getInstance() {
    _instance ??= DashboardBloc();
    return _instance!;
  }

  void getDashboard(BuildContext context, String pospId) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getDashboard(id: pospId)
        .then((getDashboard) {
      if (getDashboard != null &&
          getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
      }
    });
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
    await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .reExam(
          id: pospId,
          trainingType: trainingType == StringUtils.generalInsurance
              ? ApiClient.trainingTypeGI
              : ApiClient.trainingTypeLI,
        )
        .then((commonData) {
      if (commonData != null &&
          commonData.resultflag == ApiClient.resultflagSuccess &&
          commonData.data != null) {
        return true;
        //resultStreamController.sink.add(commonData);
      }
    });
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}