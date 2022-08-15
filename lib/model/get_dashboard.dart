class GetDashboard {
  String? resultflag;
  String? messages;
  GetDashboardData? data;

  GetDashboard({this.resultflag, this.messages, this.data});

  GetDashboard.fromJson(Map<String, dynamic> json) {
    resultflag = json['resultflag'];
    messages = json['Messages'];
    data =
        json['Data'] != null ? GetDashboardData.fromJson(json['Data']) : null;
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

class GetDashboardData {
  DashboardData? data;
  String? statusCode;
  String? message;
  bool? success;

  GetDashboardData({this.data, this.statusCode, this.message, this.success});

  GetDashboardData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
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

class DashboardData {
  String? pospRegistrationStatus;
  String? trainingStatus;
  PospRegistration? pospRegistration;
  Training? training;

  DashboardData(
      {this.pospRegistrationStatus, this.trainingStatus, this.training});

  DashboardData.fromJson(Map<String, dynamic> json) {
    pospRegistrationStatus = json['posp_registration_status'];
    trainingStatus = json['training_status'];
    pospRegistration = json['posp_registration'] != null
        ? PospRegistration.fromJson(json['posp_registration'])
        : null;
    training =
        json['training'] != null ? Training.fromJson(json['training']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posp_registration_status'] = pospRegistrationStatus;
    data['training_status'] = trainingStatus;
    if (pospRegistration != null) {
      data['posp_registration'] = pospRegistration!.toJson();
    }
    if (training != null) {
      data['training'] = training!.toJson();
    }
    return data;
  }
}

class PospRegistration {
  String? kycDetail;
  String? panDetail;
  String? gstDetail;
  String? bankDetail;
  String? academicDetail;
  String? iib;
  PersonalDetail? presonalDetail;
  KYCDetails? kYCDetails;
  PanDetails? panDetails;
  GstDetails? gstDetails;
  BankDetails? bankDetails;
  AcademicDetails? academicDetails;

  PospRegistration(
      {this.kycDetail,
      this.panDetail,
      this.gstDetail,
      this.bankDetail,
      this.academicDetail,
      this.iib,
      this.presonalDetail,
      this.kYCDetails,
      this.panDetails,
      this.gstDetails,
      this.bankDetails,
      this.academicDetails});

  PospRegistration.fromJson(Map<String, dynamic> json) {
    kycDetail = json['kyc_details'];
    panDetail = json['pan_details'];
    gstDetail = json['gst_details'];
    bankDetail = json['bank_details'];
    academicDetail = json['academic_details'];
    iib = json['iib'];
    presonalDetail = json['PresonalDetail'] != null
        ? PersonalDetail.fromJson(json['PresonalDetail'])
        : null;
    kYCDetails = json['KYC_details'] != null
        ? KYCDetails.fromJson(json['KYC_details'])
        : null;
    panDetails = json['Pan_details'] != null
        ? PanDetails.fromJson(json['Pan_details'])
        : null;
    gstDetails = (json['Gst_detail'] != null
        ? GstDetails.fromJson(json['Gst_detail'])
        : null);
    bankDetails = json['Bank_detail'] != null
        ? BankDetails.fromJson(json['Bank_detail'])
        : null;
    academicDetails = json['Academic_details'] != null
        ? AcademicDetails.fromJson(json['Academic_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kyc_details'] = kycDetail;
    data['pan_details'] = panDetail;
    data['gst_details'] = gstDetail;
    data['bank_details'] = bankDetail;
    data['academic_details'] = academicDetail;
    data['iib'] = iib;
    if (presonalDetail != null) {
      data['PresonalDetail'] = presonalDetail!.toJson();
    }
    if (kYCDetails != null) {
      data['KYC_details'] = kYCDetails!.toJson();
    }
    if (panDetails != null) {
      data['Pan_details'] = panDetails!.toJson();
    }
    if (gstDetail != null) {
      data['Gst_detail'] = gstDetails!.toJson();
    }
    if (bankDetail != null) {
      data['Bank_detail'] = bankDetails!.toJson();
    }
    if (academicDetails != null) {
      data['Academic_details'] = academicDetails!.toJson();
    }
    return data;
  }
}

class PersonalDetail {
  String? userName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? dateOfBirth;
  String? gender;
  String? emailId;
  String? state;
  String? city;
  String? pinCode;
  int? referredById;

  PersonalDetail(
      {this.userName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.dateOfBirth,
      this.gender,
      this.emailId,
      this.state,
      this.city,
      this.pinCode,
      this.referredById});

  PersonalDetail.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    firstName = json['first_name'];
    middleName = json['middel_name'];
    lastName = json['last_name'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    emailId = json['email_id'];
    state = json['state'];
    city = json['city'];
    pinCode = json['pincode'];
    referredById = json['referred_by_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['middel_name'] = middleName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['email_id'] = emailId;
    data['state'] = state;
    data['city'] = city;
    data['pincode'] = pinCode;
    data['referred_by_Id'] = referredById;
    return data;
  }
}

class KYCDetails {
  String? addressProffName;
  String? mobileNo;
  String? whatsappNo;
  String? aadharNo;
  String? preferredType;

  KYCDetails(
      {this.addressProffName,
      this.mobileNo,
      this.whatsappNo,
      this.aadharNo,
      this.preferredType});

  KYCDetails.fromJson(Map<String, dynamic> json) {
    addressProffName = json['address_proff_name'];
    mobileNo = json['mobile_no'];
    whatsappNo = json['whatsapp_no'];
    aadharNo = json['aadhar_no'];
    preferredType = json['preferred_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_proff_name'] = addressProffName;
    data['mobile_no'] = mobileNo;
    data['whatsapp_no'] = whatsappNo;
    data['aadhar_no'] = aadharNo;
    data['preferred_type'] = preferredType;
    return data;
  }
}

class PanDetails {
  String? accountType;
  String? panName;
  String? panNo;

  PanDetails({this.accountType, this.panName, this.panNo});

  PanDetails.fromJson(Map<String, dynamic> json) {
    accountType = json['account_type'];
    panName = json['pan_name'];
    panNo = json['pan_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_type'] = accountType;
    data['pan_name'] = panName;
    data['pan_no'] = panNo;
    return data;
  }
}

class GstDetails {
  String? gSTName;
  String? gstNo;
  String? gstStatus;

  GstDetails({this.gSTName, this.gstNo, this.gstStatus});

  GstDetails.fromJson(Map<String, dynamic> json) {
    gSTName = json['GST_Name'];
    gstNo = json['gst_no'];
    gstStatus = json['gst_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GST_Name'] = gSTName;
    data['gst_no'] = gstNo;
    data['gst_status'] = gstStatus;
    return data;
  }
}

class BankDetails {
  String? bankName;
  String? bankAccountNo;
  String? ifsc;

  BankDetails({this.bankName, this.bankAccountNo, this.ifsc});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccountNo = json['bank_account_no'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['bank_account_no'] = bankAccountNo;
    data['ifsc'] = ifsc;
    return data;
  }
}

class AcademicDetails {
  String? educationProofType;

  AcademicDetails({this.educationProofType});

  AcademicDetails.fromJson(Map<String, dynamic> json) {
    educationProofType = json['education_proof_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['education_proof_type'] = educationProofType;
    return data;
  }
}

class Training {
  GeneralInsurance? generalInsurance;
  GeneralInsurance? lifeInsurance;

  Training({this.generalInsurance, this.lifeInsurance});

  Training.fromJson(Map<String, dynamic> json) {
    generalInsurance = json['general_insurance'] != null
        ? GeneralInsurance.fromJson(json['general_insurance'])
        : null;
    lifeInsurance = json['life_insurance'] != null
        ? GeneralInsurance.fromJson(json['life_insurance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (generalInsurance != null) {
      data['general_insurance'] = generalInsurance!.toJson();
    }
    if (lifeInsurance != null) {
      data['life_insurance'] = lifeInsurance!.toJson();
    }
    return data;
  }
}

class GeneralInsurance {
  String? day1;
  String? day2;
  String? day3;
  String? exam;
  String? latestTime;

  GeneralInsurance(
      {this.day1, this.day2, this.day3, this.exam, this.latestTime});

  GeneralInsurance.fromJson(Map<String, dynamic> json) {
    day1 = json['day1'];
    day2 = json['day2'];
    day3 = json['day3'];
    exam = json['exam'];
    latestTime = json['latest_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day1'] = day1;
    data['day2'] = day2;
    data['day3'] = day3;
    data['exam'] = exam;
    data['latest_time'] = latestTime;
    return data;
  }
}