import 'dart:async';
import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/screen/training/training_result.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingDashboardBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<Question>> dashboardStreamController = StreamController<List<Question>>.broadcast();

  Stream get mainStream => mainStreamController.stream;
  Stream<List<Question>> get dashboardStream => dashboardStreamController.stream;

  void getDashboard(BuildContext context,String trainingType) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getQuestions(trainingType: trainingType == StringUtils.generalInsurance ? ApiClient.trainingTypeGI : ApiClient.trainingTypeLI)
        .then((getQuestionList) {
      if (getQuestionList != null &&
          getQuestionList.resultflag == ApiClient.resultflagSuccess && getQuestionList.data != null) {
        dashboardStreamController.sink.add(getQuestionList.data!);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
