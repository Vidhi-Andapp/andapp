import 'dart:async';

import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/model/submit_answer.dart';
import 'package:andapp/screen/training/training_result.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TrainingExamBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<Question>> questionStreamController =
      StreamController<List<Question>>.broadcast();

  Stream get mainStream => mainStreamController.stream;

  Stream<List<Question>> get questionStream => questionStreamController.stream;

  TextEditingController mobNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();

  void getQuestions(BuildContext context, String trainingType) {
    AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getQuestions(
            trainingType: trainingType == StringUtils.generalInsurance
                ? ApiClient.trainingTypeGI
                : ApiClient.trainingTypeLI)
        .then((getQuestionList) {
      if (getQuestionList != null &&
          getQuestionList.resultflag == ApiClient.resultflagSuccess &&
          getQuestionList.data != null) {
        questionStreamController.sink.add(getQuestionList.data!);
      }
    });
  }

  Future<AnswerData?> submitAnswers(BuildContext context, String trainingType,
      List<Question>? lstQuestions) async {
    List<AnswerList> listAnswer = [];
    for (Question question in lstQuestions ?? []) {
      AnswerList objAnswer = AnswerList();
      objAnswer.queId = question.questionId.toString();
      objAnswer.ans = question.attemptedAns;
      listAnswer.add(objAnswer);
    }
    var pospId = await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().pospId);
    if(pospId != null) {
      var submitAnswer = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .submitAnswers(
          trainingType: trainingType == StringUtils.generalInsurance
              ? ApiClient.trainingTypeGI
              : ApiClient.trainingTypeLI,
          ansList: listAnswer,
          pospId: pospId);
      if (submitAnswer != null) {
        if (kDebugMode) {
          print("in : submitAnswer : ${submitAnswer.messages}");
        }
        if (submitAnswer.resultflag == ApiClient.resultflagSuccess &&
            submitAnswer.data != null) {
          if (kDebugMode) {
            print("if : submitAnswer : ${submitAnswer.messages}");
          }
        } else {
          CommonToast.getInstance()
              ?.displayToast(message: submitAnswer.messages ?? "Fail");
          if (kDebugMode) {
            print("else : submitAnswer : ${submitAnswer.messages}");
          }
          //return null;
        }
        return submitAnswer.data?.data;
      }
    }
    if (kDebugMode) {
      print("out : submitAnswer is null");
    }
    return null;
  }

  @override
  void dispose() {}
}