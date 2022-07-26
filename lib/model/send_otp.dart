class SendOTP {
  String? resultflag;
  String? messages;
  Data? data;

  SendOTP({this.resultflag, this.messages, this.data});

  SendOTP.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = (json['Data'] != null && json['Data'] != "") ? Data.fromJson(json['Data']) : null;
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

class Data {
  int? oTP;

  Data({this.oTP});

  Data.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = oTP;
    return data;
  }
}
