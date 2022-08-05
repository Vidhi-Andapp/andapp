import 'dart:async';
import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingResultBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<Question>> resultStreamController = StreamController<List<Question>>.broadcast();

  Stream get mainStream => mainStreamController.stream;
  Stream<List<Question>> get resultStream => resultStreamController.stream;

  TextEditingController mobNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  String? updateMobOtp;

  void getResult(BuildContext context) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getQuestions(trainingType: "li")
        .then((submitAnswer) {
      if (submitAnswer != null &&
          submitAnswer.resultflag == ApiClient.resultflagSuccess && submitAnswer.data != null) {
        resultStreamController.sink.add(submitAnswer.data!);
      }
    });
  }

  @override
  void dispose() {}

}
