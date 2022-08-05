class SubmitAnswer {
  String? resultflag;
  String? messages;
  SubmitAnswerData? data;

  SubmitAnswer({this.resultflag, this.messages, this.data});

  SubmitAnswer.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = (json['Data'] != null && json['Data'] != "") ? SubmitAnswerData.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultflag'] = resultflag;
    data['Messages'] = messages;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubmitAnswerData {
  AnswerData? data;

  SubmitAnswerData({this.data});

  SubmitAnswerData.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? AnswerData.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class AnswerData {
  int? totalQuestions;
  int? totalCorrectAnswer;
  String? percentage;
  String? result;

  AnswerData(
      {this.totalQuestions,
        this.totalCorrectAnswer,
        this.percentage,
        this.result});

  AnswerData.fromJson(Map<String, dynamic> json) {
    totalQuestions = json['Total_questions'];
    totalCorrectAnswer = json['Total_correct_answer'];
    percentage = json['Percentage'];
    result = json['Result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total_questions'] = totalQuestions;
    data['Total_correct_answer'] = totalCorrectAnswer;
    data['Percentage'] = percentage;
    data['Result'] = result;
    return data;
  }
}
