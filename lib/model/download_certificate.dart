class DownloadCertificate {
  String? resultflag;
  String? messages;
  DownloadCertificateData? data;

  DownloadCertificate({this.resultflag, this.messages, this.data});

  DownloadCertificate.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? DownloadCertificateData.fromJson(json['Data']) : null;
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

class DownloadCertificateData {
  DownloadCertificateImageData? data;

  DownloadCertificateData({this.data});

  DownloadCertificateData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DownloadCertificateImageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DownloadCertificateImageData {
  String? image;

  DownloadCertificateImageData({this.image});

  DownloadCertificateImageData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}