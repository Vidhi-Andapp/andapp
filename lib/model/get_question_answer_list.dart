class GetQuestionList {
  String? resultflag;
  String? messages;
  List<Question>? data;

  GetQuestionList({this.resultflag, this.messages, this.data});

  GetQuestionList.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    if (json['Data'] != null) {
      data = <Question>[];
      json['Data'].forEach((v) {
        data!.add(Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultflag'] = resultflag;
    data['Messages'] = messages;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int? questionId;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? attemptedAns;

  Question(
      {this.questionId,
        this.question,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.attemptedAns});

  Question.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    optionA = json['option_a'];
    optionB = json['option_b'];
    optionC = json['option_c'];
    optionD = json['option_d'];
    attemptedAns = json['ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question'] = question;
    data['option_a'] = optionA;
    data['option_b'] = optionB;
    data['option_c'] = optionC;
    data['option_d'] = optionD;
    data['ans'] = attemptedAns;
    return data;
  }
}

class AnswerList {
  String? queId;
  String? ans;

  AnswerList({this.queId, this.ans});

  AnswerList.fromJson(Map<String, dynamic> json) {
    queId = json['queid'];
    ans = json['ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queid'] = queId;
    data['ans'] = ans;
    return data;
  }
}
