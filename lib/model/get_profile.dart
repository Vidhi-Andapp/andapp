class GetProfile {
  String? resultflag;
  String? messages;
  GetProfileData? data;

  GetProfile({this.resultflag, this.messages, this.data});

  GetProfile.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data = json['Data'] != null ? GetProfileData.fromJson(json['Data']) : null;
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

class GetProfileData {
  ProfileData? data;

  GetProfileData({this.data});

  GetProfileData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? qrLink;
  String? referralLink;
  PersonalDetails? personalDetails;
  KycDetails? kycDetails;
  BankDetails? bankDetails;

  ProfileData(
      {this.qrLink,
      this.referralLink,
      this.personalDetails,
      this.kycDetails,
      this.bankDetails});

  ProfileData.fromJson(Map<String, dynamic> json) {
    qrLink = json['qr_link'];
    referralLink = json['referral_link'];
    personalDetails = json['personal_details'] != null
        ? PersonalDetails.fromJson(json['personal_details'])
        : null;
    kycDetails = json['kyc_details'] != null
        ? KycDetails.fromJson(json['kyc_details'])
        : null;
    bankDetails = json['bank_details'] != null
        ? BankDetails.fromJson(json['bank_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qr_link'] = qrLink;
    data['referral_link'] = referralLink;
    if (personalDetails != null) {
      data['personal_details'] = personalDetails!.toJson();
    }
    if (kycDetails != null) {
      data['kyc_details'] = kycDetails!.toJson();
    }
    if (bankDetails != null) {
      data['bank_details'] = bankDetails!.toJson();
    }
    return data;
  }
}

class PersonalDetails {
  String? pospName;
  String? pospCode;
  String? gender;
  String? pospPhoto;
  String? pospPhotoType;
  String? userName;
  String? birthdate;
  String? emailId;
  bool? emailVerified;
  String? mobileNo;
  String? whatsappNo;
  ChildNo? childNo;

  PersonalDetails(
      {this.pospName,
      this.pospCode,
      this.gender,
      this.pospPhoto,
      this.pospPhotoType,
      this.userName,
      this.birthdate,
      this.emailId,
      this.emailVerified,
      this.mobileNo,
      this.whatsappNo,
      this.childNo});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    pospName = json['posp_name'];
    pospCode = json['posp_code'];
    gender = json['gender'];
    pospPhoto = json['posp_photo'];
    pospPhotoType = json['posp_photo_type'];
    userName = json['user_name'];
    birthdate = json['birthdate'];
    emailId = json['email_id'];
    emailVerified = json['emailverified'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    childNo =
        json['child_no'] != null ? ChildNo.fromJson(json['child_no']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posp_name'] = pospName;
    data['posp_code'] = pospCode;
    data['gender'] = gender;
    data['posp_photo'] = pospPhoto;
    data['posp_photo_type'] = pospPhotoType;
    data['user_name'] = userName;
    data['birthdate'] = birthdate;
    data['email_id'] = emailId;
    data['emailverified'] = emailVerified;
    data['mobile_no'] = mobileNo;
    data['whatsapp_no'] = whatsappNo;
    if (childNo != null) {
      data['child_no'] = childNo!.toJson();
    }
    return data;
  }
}

class ChildNo {
  List<ChildNo>? objChild;

  ChildNo({this.objChild});

  ChildNo.fromJson(Map<String, dynamic> json) {
    if (json['objChild'] != null) {
      objChild = <ChildNo>[];
      json['objChild'].forEach((v) {
        objChild!.add(ChildNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (objChild != null) {
      data['objChild'] = objChild!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KycDetails {
  String? aadharNo;
  String? panNo;
  String? gstNo;

  KycDetails({this.aadharNo, this.panNo, this.gstNo});

  KycDetails.fromJson(Map<String, dynamic> json) {
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    gstNo = json['gst_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aadhar_no'] = aadharNo;
    data['pan_no'] = panNo;
    data['gst_no'] = gstNo;
    return data;
  }
}

class BankDetails {
  int? bankVerified;
  String? bankHolderName;
  String? bankAccountNo;
  String? ifsc;

  BankDetails(
      {this.bankVerified, this.bankHolderName, this.bankAccountNo, this.ifsc});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankVerified = json['Bank_verified'];
    bankHolderName = json['bank_holder_name'];
    bankAccountNo = json['bank_account_no'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Bank_verified'] = bankVerified;
    data['bank_holder_name'] = bankHolderName;
    data['bank_account_no'] = bankAccountNo;
    data['ifsc'] = ifsc;
    return data;
  }
}