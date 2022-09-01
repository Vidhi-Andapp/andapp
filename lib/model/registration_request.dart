class RegistrationRequest {
  List<PersonalDetails>? personalDetails;
  List<KYC>? kYC;

  RegistrationRequest({this.personalDetails, this.kYC});

  RegistrationRequest.fromJson(Map<String, dynamic> json) {
    if (json['PersonalDetails'] != null) {
      personalDetails = <PersonalDetails>[];
      json['PersonalDetails'].forEach((v) {
        personalDetails!.add(PersonalDetails.fromJson(v));
      });
    }
    if (json['KYC'] != null) {
      kYC = <KYC>[];
      json['KYC'].forEach((v) {
        kYC!.add(KYC.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (personalDetails != null) {
      data['PersonalDetails'] =
          personalDetails!.map((v) => v.toJson()).toList();
    }
    if (kYC != null) {
      data['KYC'] = kYC!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonalDetails {
  String? pospId;
  String? userName;
  String? firstName;
  String? middleName = "";
  String? lastName;
  String? address = "";
  String? dateOfBirth = "";
  String? gender;
  String? emailId;
  String? state = "";
  String? city = "";
  String? pincode = "";
  String? referredById;

  PersonalDetails(
      {this.pospId,
      this.userName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.dateOfBirth,
      this.gender,
      this.emailId,
      this.state,
      this.city,
      this.pincode,
      this.referredById});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    pospId = json['posp_id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    emailId = json['email_id'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    referredById = json['referred_by_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posp_id'] = pospId;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['email_id'] = emailId;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pincode;
    data['referred_by_Id'] = referredById;
    return data;
  }
}

class KYC {
  String? addressProofName;
  String? mobileNo;
  String? whatsappNo;
  String? accountType;
  String? panName = "";
  String? bankName;
  String? gSTName = "";
  String? aadharNo;
  String? panNo;
  String? educationProofType;
  String? bankAccountNo;
  String? gstNo = "";
  String? gstStatus = "";
  String? ifsc;
  String? preferenceType;

  KYC(
      {this.addressProofName,
      this.mobileNo,
      this.whatsappNo,
      this.accountType,
      this.panName,
      this.bankName,
      this.gSTName,
      this.aadharNo,
      this.panNo,
      this.educationProofType,
      this.bankAccountNo,
      this.gstNo,
      this.gstStatus,
      this.ifsc,
      this.preferenceType});

  KYC.fromJson(Map<String, dynamic> json) {
    addressProofName = json['address_proof_name'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    accountType = json['account_type'];
    panName = json['pan_name'];
    bankName = json['bank_name'];
    gSTName = json['GST_Name'];
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    educationProofType = json['education_proof_type'];
    bankAccountNo = json['bank_account_no'];
    gstNo = json['gst_no'];
    gstStatus = json['gst_status'];
    ifsc = json['ifsc'];
    preferenceType = json['preference_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_proof_name'] = addressProofName;
    data['mobile_no'] = mobileNo;
    data['whatsapp_no'] = whatsappNo;
    data['account_type'] = accountType;
    data['pan_name'] = panName;
    data['bank_name'] = bankName;
    data['GST_Name'] = gSTName;
    data['aadhar_no'] = aadharNo;
    data['pan_no'] = panNo;
    data['education_proof_type'] = educationProofType;
    data['bank_account_no'] = bankAccountNo;
    data['gst_no'] = gstNo;
    data['gst_status'] = gstStatus;
    data['ifsc'] = ifsc;
    data['preference_type'] = preferenceType;
    return data;
  }
}