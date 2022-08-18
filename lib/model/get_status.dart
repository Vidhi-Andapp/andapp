class GetStatus {
  String? resultflag;
  String? messages;
  GetStatusData? data;

  GetStatus({this.resultflag, this.messages, this.data});

  GetStatus.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? GetStatusData.fromJson(json['Data']) : null;
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

class GetStatusData {
  DataGetStatus? data;

  GetStatusData({this.data});

  GetStatusData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataGetStatus.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataGetStatus {
  int? pospStatus;
  int? pospId;

  DataGetStatus({this.pospStatus, this.pospId});

  DataGetStatus.fromJson(Map<String, dynamic> json) {
    pospStatus = json['posp_status'];
    pospId = json['posp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posp_status'] = pospStatus;
    data['posp_id'] = pospId;
    return data;
  }
}