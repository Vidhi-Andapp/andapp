import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class MyProfileBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<Question>> profileStreamController =
      StreamController<List<Question>>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<List<Question>> get dashboardStream => profileStreamController.stream;

  void getProfile(BuildContext context) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getProfile(id: "")
        .then((getProfile) {
      if (getProfile != null &&
          getProfile.resultflag == ApiClient.resultflagSuccess &&
          getProfile.data != null) {
        //profileStreamController.sink.add();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}