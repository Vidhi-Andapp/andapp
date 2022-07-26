class GetPan {
  String? resultflag;
  String? messages;
  GetPanData? data;

  GetPan({this.resultflag, this.messages, this.data});

  GetPan.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? GetPanData.fromJson(json['Data']) : null;
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

class GetPanData {
  PanData? data;
  String? statusCode;
  String? message;
  bool? success;

  GetPanData({this.data, this.statusCode, this.message, this.success});

  GetPanData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? PanData.fromJson(json['data']) : null;
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

class PanData {
  String? panName;

  PanData({this.panName});

  PanData.fromJson(Map<String, dynamic> json) {
    panName = json['Pan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Pan_name'] = panName;
    return data;
  }
}
