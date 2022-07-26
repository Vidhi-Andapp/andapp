class GetBank {
  String? resultflag;
  String? messages;
  GetBankData? data;

  GetBank({this.resultflag, this.messages, this.data});

  GetBank.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? GetBankData.fromJson(json['Data']) : null;
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

class GetBankData {
  BankData? data;
  String? statusCode;
  String? message;
  bool? success;

  GetBankData({this.data, this.statusCode, this.message, this.success});

  GetBankData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? BankData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = statusCode;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class BankData {
  String? bankName;

  BankData({this.bankName});

  BankData.fromJson(Map<String, dynamic> json) {
    bankName = json['Bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Bank_name'] = bankName;
    return data;
  }
}
