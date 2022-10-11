/*
import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/download_certificate.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingResultBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<DownloadCertificate> resultStreamController =
      StreamController<DownloadCertificate>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<DownloadCertificate> get resultStream => resultStreamController.stream;

  void downloadCertificate(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .downloadCertificate(trainingType: "li")
        .then((downloadCertificate) {
      if (downloadCertificate != null &&
          downloadCertificate.resultflag == ApiClient.resultflagSuccess &&
          downloadCertificate.data != null) {
        //resultStreamController.sink.add(downloadCertificate);
      }
    });
  }

  @override
  void dispose() {}
}*/