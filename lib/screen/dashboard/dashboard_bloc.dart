import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

import '../../model/download_certificate.dart';

class DashboardBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<GetDashboardData> dashboardStreamController =
      StreamController<GetDashboardData>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<GetDashboardData> get dashboardStream =>
      dashboardStreamController.stream;
  StreamController<DownloadCertificate> resultStreamController =
      StreamController<DownloadCertificate>.broadcast();

  Stream<DownloadCertificate> get resultStream => resultStreamController.stream;

  void getDashboard(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getDashboard(id: "29")
        .then((getDashboard) {
      if (getDashboard != null &&
          getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
      }
    });
  }

  void downloadCertificate(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .downloadCertificate(id: "24", trainingType: "li")
        .then((downloadCertificate) {
      if (downloadCertificate != null &&
          downloadCertificate.resultflag == ApiClient.resultflagSuccess &&
          downloadCertificate.data != null) {
        resultStreamController.sink.add(downloadCertificate);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}