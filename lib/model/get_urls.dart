class GetUrl {
  String? resultflag;
  String? messages;
  Data? data;

  GetUrl({this.resultflag, this.messages, this.data});

  GetUrl.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
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
  String? freshdeskurl;
  String? usermanualurl;

  Data({this.freshdeskurl, this.usermanualurl});

  Data.fromJson(Map<String, dynamic> json) {
    freshdeskurl = json['freshdeskurl'];
    usermanualurl = json['usermanualurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['freshdeskurl'] = freshdeskurl;
    data['usermanualurl'] = usermanualurl;
    return data;
  }
}
