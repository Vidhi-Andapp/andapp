import 'dart:async';
import 'package:andapp/common/bloc_provider.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/screen/training/training_result.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';

class TrainingStatusBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();
  StreamController<List<Question>> questionStreamController = StreamController<List<Question>>.broadcast();

  Stream get mainStream => mainStreamController.stream;
  Stream<List<Question>> get questionStream => questionStreamController.stream;

  TextEditingController mobNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();


  void getQuestions(BuildContext context,String trainingType) {
    AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getQuestions(trainingType: trainingType == StringUtils.generalInsurance ? ApiClient.trainingTypeGI : ApiClient.trainingTypeLI)
        .then((getQuestionList) {
      if (getQuestionList != null &&
          getQuestionList.resultflag == ApiClient.resultflagSuccess && getQuestionList.data != null) {
        questionStreamController.sink.add(getQuestionList.data!);
      }
    });
  }

  Future submitAnswers(BuildContext context,String trainingType,List<Question>? lstQuestions) async{
    List<AnswerList> listAnswer = [];
    for(Question question in lstQuestions ?? [])
      {
        AnswerList objAnswer = AnswerList();
        objAnswer.queId = question.questionId.toString();
        objAnswer.ans = question.attemptedAns;
        listAnswer.add(objAnswer);
      }
    await AppComponentBase
        .getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .submitAnswers(trainingType: trainingType == StringUtils.generalInsurance ? ApiClient.trainingTypeGI : ApiClient.trainingTypeLI ,ansList: listAnswer)
        .then((submitAnswer) {
          print("in : submitAnswer : ${submitAnswer?.messages}");
      if (submitAnswer != null &&
          submitAnswer.resultflag == ApiClient.resultflagSuccess && submitAnswer.data != null) {
        print("if : submitAnswer : ${submitAnswer.messages}");
        //return submitAnswer;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) {
                return TrainingResult(title: trainingType,answerData: submitAnswer.data?.data,);
              }),
        );
      }
      else {
        CommonToast.getInstance()?.displayToast(
            message: submitAnswer?.messages ?? "Fail");
        print("else : submitAnswer : ${submitAnswer?.messages}");
        //return null;
      }
    });
    print("out : submitAnswer is null");
  }
  @override
  void dispose() {}

}
