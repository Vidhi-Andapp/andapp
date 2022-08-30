class GetAadhar {
  String? resultflag;
  String? messages;
  GetAadharData? data;

  GetAadhar({this.resultflag, this.messages, this.data});

  GetAadhar.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data =
    (json['Data'] != null && json['Data'] != '') ? GetAadharData.fromJson(
        json['Data']) : null;
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

class GetAadharData {
  AadharData? data;
  String? statusCode;
  String? message;
  bool? success;
  String? type;

  GetAadharData(
      {this.data, this.statusCode, this.message, this.success, this.type});

  GetAadharData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AadharData.fromJson(json['data']) : null;
    statusCode = json['status_code'];
    message = json['message'];
    success = json['success'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = statusCode;
    data['message'] = message;
    data['success'] = success;
    data['type'] = type;
    return data;
  }
}

class AadharData {
  String? fullname;
  String? gender;
  Address? address;
  String? aadhaarNumber;
  String? dob;

  AadharData(
      {this.fullname, this.gender, this.address, this.aadhaarNumber, this.dob});

  AadharData.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    gender = json['gender'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    aadhaarNumber = json['aadhaar_number'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['gender'] = gender;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['aadhaar_number'] = aadhaarNumber;
    data['dob'] = dob;
    return data;
  }
}

class Address {
  String? address;

  Address({this.address});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    return data;
  }
}