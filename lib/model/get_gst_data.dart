class GetGst {
  String? resultflag;
  String? messages;
  GetGstData? data;

  GetGst({this.resultflag, this.messages, this.data});

  GetGst.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? GetGstData.fromJson(json['Data']) : null;
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

class GetGstData {
  GstData? data;
  String? statusCode;
  String? message;
  bool? success;

  GetGstData({this.data, this.statusCode, this.message, this.success});

  GetGstData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? GstData.fromJson(json['data']) : null;
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

class GstData {
  String? gSTName;
  String? pANNumber;

  GstData({this.gSTName, this.pANNumber});

  GstData.fromJson(Map<String, dynamic> json) {
    gSTName = json['GST_name'];
    pANNumber = json['PAN_Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GST_name'] = gSTName;
    data['PAN_Number'] = pANNumber;
    return data;
  }
}
