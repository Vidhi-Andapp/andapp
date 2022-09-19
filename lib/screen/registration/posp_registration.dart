import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/govt_validator.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/screen/dashboard/dashboard.dart';
import 'package:andapp/screen/registration/posp_registration_bloc.dart';
import 'package:andapp/screen/registration/registration_phases.dart';
import 'package:andapp/services/api_client.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PoSPRegistration extends StatefulWidget {
  const PoSPRegistration({Key? key}) : super(key: key);

  @override
  State<PoSPRegistration> createState() => _PoSPRegistrationState();
}

class _PoSPRegistrationState extends State<PoSPRegistration> {
  final PospRegistrationBloc bloc = PospRegistrationBloc();
  static int selectedIndex = 1;
  bool
  isPersonalDetailsVisible = true,
      isAadharOtpEnabled = false;
  String nextButton = StringUtils.next;
  final GlobalKey<RegistrationPhasesState> _keyRPhases = GlobalKey();
  final personalDetailsKey = GlobalKey<FormState>(),
      sendAadharOTPKey = GlobalKey<FormState>(),
      validateAadharOTPKey = GlobalKey<FormState>(),
      panValidateKey = GlobalKey<FormState>(),
      gstValidateKey = GlobalKey<FormState>(),
      bankValidateKey = GlobalKey<FormState>(),
      kycAutomateKey = GlobalKey<FormState>(),
      kycManualKey = GlobalKey<FormState>(),
  /* accountAutomateKey = GlobalKey<FormState>(),
      accountManualKey = GlobalKey<FormState>(),*/
      bankKey = GlobalKey<FormState>();

  String titleAadharFront = StringUtils.aadharFront,
      titleAadharBack = StringUtils.aadharBack,
      titleGst = StringUtils.gstCertification,
      titlePan = StringUtils.panCard,
      titleAcademicCertificate = StringUtils.uploadCertification;

  final List<String> itemsSalutation = [
    StringUtils.mr,
    StringUtils.ms,
    StringUtils.mrs,
    StringUtils.dr,
  ];

  final List<String> itemsGender = [
    StringUtils.male,
    StringUtils.female,
  ];

  final List<String> itemsCertificateType = [
    StringUtils.ssc,
    StringUtils.hsc,
    StringUtils.graduation,
    StringUtils.postGraduation,
    StringUtils.phd,
    StringUtils.other,
  ];

  void _refresh(int index) {
    if (index != 1) {
      isPersonalDetailsVisible = false;
    } else {
      isPersonalDetailsVisible = true;
    }
    if (index == 4) {
      nextButton = StringUtils.submit;
    } else {
      nextButton = StringUtils.next;
    }
    setState(() {
      selectedIndex = index;
    });
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = [];
    //final appTheme = AppTheme.of(context);
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          /*if (item != items.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: ,
            ),*/
        ],
      );
    }
    return menuItems;
  }

/*

  List<int> _getDividersIndexes() {
    List<int> dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        dividersIndexes.add(i);
      }
    }
    return dividersIndexes;
  }
*/

  Future<PlatformFile?> _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowCompression: true,
    );
    // if no file is picked
    if (result == null) return null;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    /*print(result.files.first.name);
    print("Size in Bytes : ${result.files.first.size}");
    print(result.files.first.path);*/
    var bytes = result.files.first.size;
    double sizeInMB = bytes / (1024 * 1024);
    if (kDebugMode) {
      print("sizeInMB : $sizeInMB");
    }
    if (sizeInMB > 4) {
      CommonToast.getInstance()
          ?.displayToast(message: StringUtils.uploadContent);
      return null;
    }
    return result.files.first;
  }

  @override
  void initState() {
    super.initState();
    assignValues();
  }

  void assignValues() async {
    bloc.mobileNo = bloc.whatsappNumber.text =
    await AppComponentBase.getInstance()
        ?.getSharedPreference()
        .getUserDetail(key: SharedPreference().mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          onBack(false);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                StringUtils.pospReg,
                textAlign: TextAlign.left,
                style: Theme
                    .of(context)
                    .appBarTheme
                    .titleTextStyle,
              ),
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              centerTitle: true,
              elevation: 0,
              // give the app bar rounded corners
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onBack(false);
                    },
                    tooltip:
                    MaterialLocalizations
                        .of(context)
                        .backButtonTooltip,
                  );
                },
              )),
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor, //const Color(0xff222222),
          body: LayoutBuilder(builder: (context, constraint) {
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            isPersonalDetailsVisible
                                ? Form(
                              key: personalDetailsKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: TextFormField(
                                      controller:
                                      bloc.username,
                                      decoration: InputDecoration(
                                          labelText: StringUtils.userName,
                                          labelStyle: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          fillColor: Colors.white,
                                          enabledBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border),
                                      validator: (val) {
                                        String pattern =
                                            r'^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){0,15}[a-zA-Z0-9]$';
                                        RegExp regExp = RegExp(pattern);
                                        if (val == null || val.isEmpty) {
                                          return StringUtils
                                              .valEmptyUsername;
                                        } else if (
                                        !regExp.hasMatch(val)) {
                                          return StringUtils
                                              .valValidUsername;
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.name,
                                      maxLength: 15,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        //color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: TextFormField(
                                      controller:
                                      bloc.email,
                                      decoration: InputDecoration(
                                          labelText: StringUtils.emailID,
                                          labelStyle: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          fillColor: Colors.white,
                                          enabledBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return StringUtils.valEmptyEmailId;
                                        } else if (!EmailValidator.validate(
                                            val, true)) {
                                          return StringUtils.valValidEmailId;
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        //color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: TextFormField(
                                      controller:
                                      bloc.whatsappNumber,
                                      decoration: InputDecoration(
                                          labelText:
                                          StringUtils.whatsappNumber,
                                          labelStyle: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          fillColor: Colors.white,
                                          enabledBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border),
                                      validator: (val) {
                                        String pattern =
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                        RegExp regExp = RegExp(pattern);
                                        if (val == null || val.isEmpty) {
                                          return StringUtils
                                              .valEmptyWhatsappNumber;
                                        } else if (val.length != 10 ||
                                            !regExp.hasMatch(val)) {
                                          return StringUtils
                                              .valValidWhatsappNumber;
                                        } else {
                                          return null;
                                        }
                                      },
                                      maxLength: 10,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        //color: Colors.white
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            RegistrationPhases(
                                key: _keyRPhases,
                                index: selectedIndex,
                                refresh: _refresh),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (selectedIndex == 1)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 32),
                                        child: SizedBox(
                                            height: 50,
                                            child: TabBar(
                                                indicatorColor:
                                                appTheme.primaryColor,
                                                labelColor: appTheme
                                                    .primaryColor,
                                                indicatorPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                isScrollable: true,
                                                unselectedLabelColor:
                                                Colors.white,
                                                labelStyle:
                                                const TextStyle(fontSize: 16),
                                                unselectedLabelStyle:
                                                const TextStyle(fontSize: 16),
                                                tabs: const [
                                                  Tab(text: "Automated"),
                                                  Tab(text: "Manual"),
                                                ],
                                                onTap: (int? value) {
                                                  bloc.automatedManual = value;
                                                }
                                            )),
                                      ),
                                      SizedBox(
                                        height: 564,
                                        child: TabBarView(
                                          children: [
                                            Column(
                                              children: [
                                                Form(
                                                  key: sendAadharOTPKey,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 32),
                                                    child: TextFormField(
                                                      controller:
                                                      bloc.aadharNumber,
                                                      onEditingComplete: () {
                                                        bloc.otp.clear();
                                                        bloc.aadharAName
                                                            .clear();
                                                        bloc.aadharAGender
                                                            .clear();
                                                        bloc.aadharABirthDate
                                                            .clear();
                                                        bloc.aadharAAddress
                                                            .clear();
                                                        isAadharOtpEnabled =
                                                        false;
                                                        setState(() {

                                                        });
                                                      },
                                                      decoration:
                                                      InputDecoration(
                                                          labelText: StringUtils
                                                              .aadharNumber,
                                                          labelStyle: TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.color),
                                                          suffixIcon:
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                8.0,
                                                                horizontal:
                                                                12.0),
                                                            child:
                                                            PinkBorderButton(
                                                              isEnabled:
                                                              true,
                                                              content:
                                                              StringUtils
                                                                  .otp,
                                                              onPressed:
                                                                  () async {
                                                                final form =
                                                                    sendAadharOTPKey
                                                                        .currentState;
                                                                if (form
                                                                    ?.validate() ??
                                                                    false) {
                                                                  form?.save();
                                                                  var value = await bloc
                                                                      .sendAadharOTP(
                                                                      context);
                                                                  if (value ==
                                                                      ApiClient
                                                                          .resultflagSuccess) {
                                                                    isAadharOtpEnabled =
                                                                    true;
                                                                    setState(() {

                                                                    });
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          enabledBorder: Theme
                                                              .of(
                                                              context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border),
                                                      validator: (val) {
                                                        AadharValidator
                                                        aadharValidator =
                                                        AadharValidator();
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return StringUtils
                                                              .valEmptyAadharNumber;
                                                        } else if (val.length <
                                                            12 ||
                                                            !aadharValidator
                                                                .validate(
                                                                val)) {
                                                          return StringUtils
                                                              .valValidAadharNumber;
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      maxLength: 12,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      style: TextStyle(
                                                          color: appTheme
                                                              .speedDialLabelBgDT),
                                                    ),
                                                  ),
                                                ),
                                                Form(
                                                  key: validateAadharOTPKey,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(32, 8, 32, 0),
                                                    child: TextFormField(
                                                      controller: bloc.otp,
                                                      decoration:
                                                      InputDecoration(
                                                          labelText:
                                                          StringUtils
                                                              .otp,
                                                          labelStyle: TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.color),
                                                          suffixIcon:
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                8.0,
                                                                horizontal:
                                                                12.0),
                                                            child:
                                                            PinkBorderButton(
                                                              isEnabled:
                                                              true,
                                                              content:
                                                              StringUtils
                                                                  .validate,
                                                              onPressed:
                                                                  () async {
                                                                final form =
                                                                    validateAadharOTPKey
                                                                        .currentState;
                                                                if (form
                                                                    ?.validate() ??
                                                                    false) {
                                                                  form?.save();
                                                                  await bloc
                                                                      .getAadharData(
                                                                      context)
                                                                      .then((
                                                                      value) =>
                                                                  {});
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          fillColor: appTheme
                                                              .speedDialLabelBgDT,
                                                          filled:
                                                          !isAadharOtpEnabled,
                                                          enabled:
                                                          isAadharOtpEnabled,
                                                          enabledBorder: Theme
                                                              .of(
                                                              context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border),
                                                      validator: (val) {
                                                        String pattern = r"^[0-9]{6}$";
                                                        RegExp regExp = RegExp(
                                                            pattern);
                                                        if (val == null || val
                                                            .isEmpty) {
                                                          return StringUtils
                                                              .valEmptyOtp;
                                                        } else if (
                                                        !regExp.hasMatch(
                                                            val)) {
                                                          return StringUtils
                                                              .valValidOtp;
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      onFieldSubmitted: (
                                                          value) {
                                                        bloc.aadharAName
                                                            .clear();
                                                        bloc.aadharAGender
                                                            .clear();
                                                        bloc.aadharABirthDate
                                                            .clear();
                                                        bloc.aadharAAddress
                                                            .clear();
                                                      },
                                                      maxLength: 6,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      style: TextStyle(
                                                          color: appTheme
                                                              .speedDialLabelBgDT),
                                                    ),
                                                  ),
                                                ),
                                                Form(
                                                  key: kycAutomateKey,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 16),
                                                        child: Text(
                                                          StringUtils
                                                              .regOtpContent,
                                                          textAlign:
                                                          TextAlign.start,
                                                          style: TextStyle(
                                                              color: appTheme
                                                                  .separatorColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal: 32),
                                                        child: TextFormField(
                                                          controller:
                                                          bloc.aadharAName,
                                                          autovalidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                          decoration:
                                                          InputDecoration(
                                                            labelText:
                                                            StringUtils
                                                                .name,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            border: Theme
                                                                .of(
                                                                context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            enabled: false,
                                                            fillColor: appTheme
                                                                .speedDialLabelBgDT,
                                                            filled: true,
                                                            errorStyle:
                                                            TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .errorColor,
                                                            ),
                                                          ),
                                                          style:
                                                          const TextStyle(
                                                            fontFamily:
                                                            "Poppins",
                                                            //color: Colors.white
                                                          ),
                                                          validator: (val) {
                                                            if (val == null ||
                                                                val.isEmpty) {
                                                              return StringUtils
                                                                  .valEmptyAadharDetails;
                                                            } else if (
                                                            !ApiClient
                                                                .nameRegExp
                                                                .hasMatch(
                                                                val)) {
                                                              return StringUtils
                                                                  .valEmptyAadharDetails;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal: 32),
                                                        child: TextFormField(
                                                            controller: bloc
                                                                .aadharAGender,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              StringUtils
                                                                  .gender,
                                                              labelStyle: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyText2
                                                                      ?.color),
                                                              border: Theme
                                                                  .of(
                                                                  context)
                                                                  .inputDecorationTheme
                                                                  .border,
                                                              enabled: false,
                                                              fillColor: appTheme
                                                                  .speedDialLabelBgDT,
                                                              filled: true,
                                                            ),
                                                            style:
                                                            const TextStyle(
                                                              fontFamily:
                                                              "Poppins",
                                                              //color: Colors.white
                                                            ),
                                                            validator: (val) {
                                                              if (val == null ||
                                                                  val.isEmpty) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else if (
                                                              !ApiClient
                                                                  .nameRegExp
                                                                  .hasMatch(
                                                                  val)) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else {
                                                                return null;
                                                              }
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal: 32),
                                                        child: TextFormField(
                                                            controller: bloc
                                                                .aadharABirthDate,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              StringUtils
                                                                  .birthdate,
                                                              labelStyle: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyText2
                                                                      ?.color),
                                                              border: Theme
                                                                  .of(
                                                                  context)
                                                                  .inputDecorationTheme
                                                                  .border,
                                                              enabled: false,
                                                              fillColor: appTheme
                                                                  .speedDialLabelBgDT,
                                                              filled: true,
                                                            ),
                                                            style:
                                                            const TextStyle(
                                                              fontFamily:
                                                              "Poppins",
                                                              //color: Colors.white
                                                            ),
                                                            validator: (val) {
                                                              if (val == null ||
                                                                  val.isEmpty) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else if (
                                                              !ApiClient
                                                                  .nameRegExp
                                                                  .hasMatch(
                                                                  val)) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else {
                                                                return null;
                                                              }
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal: 32),
                                                        child: TextFormField(
                                                            controller: bloc
                                                                .aadharAAddress,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              StringUtils
                                                                  .address,
                                                              labelStyle: TextStyle(
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .bodyText2
                                                                      ?.color),
                                                              border: Theme
                                                                  .of(
                                                                  context)
                                                                  .inputDecorationTheme
                                                                  .border,
                                                              enabled: false,
                                                              fillColor: appTheme
                                                                  .speedDialLabelBgDT,
                                                              filled: true,
                                                            ),
                                                            style:
                                                            const TextStyle(
                                                              fontFamily:
                                                              "Poppins",
                                                              //color: Colors.white
                                                            ),
                                                            maxLines: 2,
                                                            validator: (val) {
                                                              if (val == null ||
                                                                  val.isEmpty) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else if (
                                                              !ApiClient
                                                                  .nameRegExp
                                                                  .hasMatch(
                                                                  val)) {
                                                                return StringUtils
                                                                    .valEmptyAadharDetails;
                                                              } else {
                                                                return null;
                                                              }
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Form(
                                              key: kycManualKey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 16,
                                                        horizontal: 32),
                                                    child:
                                                    DropdownButtonHideUnderline(
                                                      child:
                                                      DropdownButtonFormField2(
                                                        decoration: InputDecoration(
                                                            labelText: StringUtils
                                                                .salutation,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            hintStyle: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            fillColor:
                                                            Colors.white,
                                                            contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                16),
                                                            enabledBorder:
                                                            Theme
                                                                .of(context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            focusedBorder:
                                                            Theme
                                                                .of(context)
                                                                .inputDecorationTheme
                                                                .border),
                                                        dropdownDecoration:
                                                        BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                            border:
                                                            Border.all(
                                                              width: 1,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8))),
                                                        isExpanded: true,
                                                        icon: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 8.0,
                                                              bottom: 8.0),
                                                          child:
                                                          SvgPicture.asset(
                                                              SvgImages
                                                                  .dropdown,
                                                              height: 28,
                                                              width: 28),
                                                        ),
                                                        hint: bloc
                                                            .selectedSalutation ==
                                                            null
                                                            ? const Text(
                                                            StringUtils
                                                                .salutation,
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                            style: TextStyle(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white))
                                                            : Text(
                                                            bloc
                                                                .selectedSalutation ??
                                                                "",
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                            style: const TextStyle(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white)),
                                                        selectedItemBuilder:
                                                            (BuildContext
                                                        context) {
                                                          return itemsSalutation
                                                              .map<Widget>(
                                                                  (String
                                                              item) {
                                                                return Text(
                                                                    item,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        color: Colors
                                                                            .white));
                                                              }).toList();
                                                        },
                                                        items:
                                                        _addDividersAfterItems(
                                                            itemsSalutation),
                                                        /*items: items.map((String item) {
                                                  return DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text('Log $item'),
                                                  );
                                                }).toList(),
                                                customItemsIndexes: _getDividersIndexes(),
                                                customItemsHeight: 4,*/
                                                        customItemsHeight: 1,
                                                        value:
                                                        bloc.selectedSalutation,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            bloc
                                                                .selectedSalutation =
                                                            value as String;
                                                          });
                                                        },
                                                        buttonHeight: 55,
                                                        buttonWidth:
                                                        MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width -
                                                            64,
                                                        itemHeight: 55,
                                                        itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            8.0),
                                                        selectedItemHighlightColor:
                                                        appTheme
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 32),
                                                    child: TextFormField(
                                                      controller:
                                                      bloc.firstName,
                                                      decoration: InputDecoration(
                                                          labelText: StringUtils
                                                              .firstName,
                                                          labelStyle: TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.color),
                                                          fillColor:
                                                          Colors.white,
                                                          enabledBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border),
                                                      validator: (val) {
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return StringUtils
                                                              .valEmptyFirstName;
                                                        } else if (!ApiClient
                                                            .nameRegExp
                                                            .hasMatch(
                                                            val)) {
                                                          return StringUtils
                                                              .valValidFirstName;
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                      TextInputType.name,
                                                      style: const TextStyle(
                                                        fontFamily: "Poppins",
                                                        //color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 32),
                                                    child: TextFormField(
                                                      controller:
                                                      bloc.middleName,
                                                      decoration: InputDecoration(
                                                          labelText: StringUtils
                                                              .middleName,
                                                          labelStyle: TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.color),
                                                          fillColor:
                                                          Colors.white,
                                                          enabledBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border),
                                                      validator: (val) {
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return StringUtils
                                                              .valEmptyMiddleName;
                                                        } else if (!ApiClient
                                                            .nameRegExp
                                                            .hasMatch(
                                                            val)) {
                                                          return StringUtils
                                                              .valValidMiddleName;
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                      TextInputType.name,
                                                      style: const TextStyle(
                                                        fontFamily: "Poppins",
                                                        //color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 32),
                                                    child: TextFormField(
                                                      controller:
                                                      bloc.lastName,
                                                      decoration: InputDecoration(
                                                          labelText: StringUtils
                                                              .lastName,
                                                          labelStyle: TextStyle(
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.color),
                                                          fillColor:
                                                          Colors.white,
                                                          enabledBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border),
                                                      validator: (val) {
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return StringUtils
                                                              .valEmptyLastName;
                                                        } else if (!ApiClient
                                                            .nameRegExp
                                                            .hasMatch(
                                                            val)) {
                                                          return StringUtils
                                                              .valValidLastName;
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                      TextInputType.name,
                                                      style: const TextStyle(
                                                        fontFamily: "Poppins",
                                                        //color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 16,
                                                        horizontal: 32),
                                                    child:
                                                    DropdownButtonHideUnderline(
                                                      child:
                                                      DropdownButtonFormField2(
                                                        decoration: InputDecoration(
                                                            labelText:
                                                            StringUtils
                                                                .gender,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            hintStyle: TextStyle(
                                                                color: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            fillColor:
                                                            Colors.white,
                                                            contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                16),
                                                            enabledBorder:
                                                            Theme
                                                                .of(context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            focusedBorder:
                                                            Theme
                                                                .of(context)
                                                                .inputDecorationTheme
                                                                .border),
                                                        dropdownDecoration:
                                                        BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                            border:
                                                            Border.all(
                                                              width: 1,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8))),
                                                        isExpanded: true,
                                                        icon: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 8.0,
                                                              bottom: 8.0),
                                                          child:
                                                          SvgPicture.asset(
                                                              SvgImages
                                                                  .dropdown,
                                                              height: 28,
                                                              width: 28),
                                                        ),
                                                        hint: bloc
                                                            .selectedGender ==
                                                            null
                                                            ? const Text(
                                                            StringUtils
                                                                .gender,
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                            style: TextStyle(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white))
                                                            : Text(
                                                            bloc
                                                                .selectedGender ??
                                                                "",
                                                            maxLines: 2,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                            style: const TextStyle(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .white)),
                                                        selectedItemBuilder:
                                                            (BuildContext
                                                        context) {
                                                          return itemsGender
                                                              .map<Widget>(
                                                                  (String
                                                              item) {
                                                                return Text(
                                                                    item,
                                                                    maxLines: 2,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        color: Colors
                                                                            .white));
                                                              }).toList();
                                                        },
                                                        items:
                                                        _addDividersAfterItems(
                                                            itemsGender),
                                                        /*items: items.map((String item) {
                                                  return DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text('Log $item'),
                                                  );
                                                }).toList(),
                                                customItemsIndexes: _getDividersIndexes(),
                                                customItemsHeight: 4,*/
                                                        customItemsHeight: 1,
                                                        value: bloc
                                                            .selectedGender,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            bloc
                                                                .selectedGender =
                                                            value as String;
                                                          });
                                                        },
                                                        buttonHeight: 55,
                                                        buttonWidth:
                                                        MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width -
                                                            64,
                                                        itemHeight: 55,
                                                        itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            8.0),
                                                        selectedItemHighlightColor:
                                                        appTheme
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8,
                                                        horizontal: 32),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          child:
                                                          GestureDetector(
                                                            onTap: () async {
                                                              bloc.aadharFront =
                                                              await _pickFile();
                                                              if (bloc
                                                                  .aadharFront !=
                                                                  null) {
                                                                titleAadharFront =
                                                                    StringUtils
                                                                        .fileUploaded;
                                                              } else {
                                                                titleAadharFront =
                                                                    StringUtils
                                                                        .aadharFront;
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                    16),
                                                                decoration:
                                                                BoxDecoration(
                                                                    border: Border
                                                                        .all(
                                                                      width:
                                                                      1,
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            8))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: (MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .width /
                                                                          2) -
                                                                          108,
                                                                      child:
                                                                      Text(
                                                                        titleAadharFront,
                                                                        maxLines:
                                                                        2,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                          8.0,
                                                                          bottom:
                                                                          8.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                          SvgImages
                                                                              .iconAttachment,
                                                                          height:
                                                                          20,
                                                                          width:
                                                                          20),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child:
                                                          GestureDetector(
                                                            onTap: () async {
                                                              bloc.aadharBack =
                                                              await _pickFile();
                                                              if (bloc
                                                                  .aadharBack !=
                                                                  null) {
                                                                titleAadharBack =
                                                                    StringUtils
                                                                        .fileUploaded;
                                                              } else {
                                                                titleAadharBack =
                                                                    StringUtils
                                                                        .aadharBack;
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                    16),
                                                                decoration:
                                                                BoxDecoration(
                                                                    border: Border
                                                                        .all(
                                                                      width:
                                                                      1,
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            8))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: (MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .width /
                                                                          2) -
                                                                          108,
                                                                      child:
                                                                      Text(
                                                                        titleAadharBack,
                                                                        maxLines:
                                                                        2,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                          8.0,
                                                                          bottom:
                                                                          8.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                          SvgImages
                                                                              .iconAttachment,
                                                                          height:
                                                                          20,
                                                                          width:
                                                                          20),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        0.0, 0, 0, 12),
                                                    child: Text(
                                                      StringUtils.uploadContent,
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: appTheme
                                                              .separatorColor,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  selectedIndex == 2
                                      ? Column(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 32),
                                        child: SizedBox(
                                            height: 50,
                                            child: TabBar(
                                                indicatorColor:
                                                appTheme.primaryColor,
                                                labelColor:
                                                appTheme.primaryColor,
                                                indicatorPadding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 16),
                                                isScrollable: true,
                                                unselectedLabelColor:
                                                Colors.white,
                                                labelStyle: const TextStyle(
                                                    fontSize: 16),
                                                unselectedLabelStyle:
                                                const TextStyle(
                                                    fontSize: 16),
                                                tabs: const [
                                                  Tab(text: "Automated"),
                                                  Tab(text: "Manual"),
                                                ],
                                                onTap: (int? value) {
                                                  bloc.automatedManual = value;
                                                }
                                            )),
                                      ),
                                      SizedBox(
                                        height: 320,
                                        child: TabBarView(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  child: MergeSemantics(
                                                    child: ListTile(
                                                      title: const Text(
                                                          StringUtils
                                                              .personalWithGST),
                                                      trailing:
                                                      CupertinoSwitch(
                                                        activeColor: appTheme
                                                            .primaryColor,
                                                        trackColor: appTheme
                                                            .speedDialLabelBgDT,
                                                        value: bloc.withGSTA,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            bloc.withGSTA =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          bloc.withGSTA =
                                                          !bloc.withGSTA;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                if (bloc.withGSTA)
                                                  Column(
                                                    children: [
                                                      Form(
                                                        key:
                                                        gstValidateKey,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 0,
                                                              horizontal:
                                                              32),
                                                          child:
                                                          TextFormField(
                                                            controller: bloc
                                                                .gstNumber,
                                                            decoration: InputDecoration(
                                                                labelText: StringUtils
                                                                    .gstNumber,
                                                                labelStyle: TextStyle(
                                                                    color: Theme
                                                                        .of(
                                                                        context)
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.color),
                                                                suffixIcon: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      8.0,
                                                                      horizontal:
                                                                      12.0),
                                                                  child:
                                                                  PinkBorderButton(
                                                                    isEnabled:
                                                                    true,
                                                                    content:
                                                                    StringUtils
                                                                        .validate,
                                                                    onPressed:
                                                                        () async {
                                                                      final form =
                                                                          gstValidateKey
                                                                              .currentState;
                                                                      if (form
                                                                          ?.validate() ??
                                                                          false) {
                                                                        form
                                                                            ?.save();
                                                                        await bloc
                                                                            .getGstData(
                                                                            context);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                /*  fillColor: Colors.white,
                                                                      filled: true,*/
                                                                enabledBorder: Theme
                                                                    .of(context)
                                                                    .inputDecorationTheme
                                                                    .border,
                                                                focusedBorder: Theme
                                                                    .of(context)
                                                                    .inputDecorationTheme
                                                                    .border),
                                                            validator:
                                                                (val) {
                                                              GSTValidator
                                                              gstValidator =
                                                              GSTValidator();
                                                              if (val ==
                                                                  null ||
                                                                  val.isEmpty) {
                                                                return StringUtils
                                                                    .valEmptyGstDetails;
                                                              } else if (
                                                              !gstValidator
                                                                  .validate(
                                                                  val)) {
                                                                return StringUtils
                                                                    .valValidGSTNumber;
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            inputFormatters: [
                                                              UpperCaseTextFormatter(),
                                                            ],
                                                            onFieldSubmitted: (
                                                                value) {
                                                              bloc.gstName
                                                                  .clear();
                                                              bloc.gstPanNumber
                                                                  .clear();
                                                            },
                                                            maxLength: 15,
                                                            keyboardType:
                                                            TextInputType
                                                                .text,
                                                            style: TextStyle(
                                                                color: appTheme
                                                                    .speedDialLabelBgDT),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal:
                                                            32),
                                                        child:
                                                        TextFormField(
                                                          controller: bloc
                                                              .gstName,
                                                          decoration:
                                                          InputDecoration(
                                                            labelText:
                                                            StringUtils
                                                                .name,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            border: Theme
                                                                .of(
                                                                context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            enabled:
                                                            false,
                                                            fillColor:
                                                            appTheme
                                                                .speedDialLabelBgDT,
                                                            filled: true,
                                                          ),
                                                          validator:
                                                              (val) {
                                                            if (val == null ||
                                                                val.isEmpty) {
                                                              return StringUtils
                                                                  .valEmptyGSTName;
                                                            } else
                                                            if (!ApiClient
                                                                .nameRegExp
                                                                .hasMatch(
                                                                val)) {
                                                              return StringUtils
                                                                  .valValidGSTName;
                                                            }
                                                            return null;
                                                          },
                                                          keyboardType:
                                                          TextInputType
                                                              .name,
                                                          style:
                                                          const TextStyle(
                                                            fontFamily:
                                                            "Poppins",
                                                            //color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal:
                                                            32),
                                                        child:
                                                        TextFormField(
                                                          controller: bloc
                                                              .gstPanNumber,
                                                          decoration:
                                                          InputDecoration(
                                                            labelText:
                                                            StringUtils
                                                                .panNumber,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            border: Theme
                                                                .of(
                                                                context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            enabled:
                                                            false,
                                                            fillColor:
                                                            appTheme
                                                                .speedDialLabelBgDT,
                                                            filled: true,
                                                          ),
                                                          validator:
                                                              (val) {
                                                            PANValidator
                                                            panValidator =
                                                            PANValidator();
                                                            if (val ==
                                                                null ||
                                                                val.isEmpty) {
                                                              return StringUtils
                                                                  .valEmptyPANNumber;
                                                            } else if (
                                                            !panValidator
                                                                .validate(
                                                                val)) {
                                                              return StringUtils
                                                                  .valValidPANNumber;
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          inputFormatters: [
                                                            UpperCaseTextFormatter(),
                                                          ],
                                                          onFieldSubmitted: (
                                                              value) {
                                                            bloc.panNumber
                                                                .clear();
                                                          },
                                                          keyboardType:
                                                          TextInputType
                                                              .name,
                                                          style:
                                                          const TextStyle(
                                                            fontFamily:
                                                            "Poppins",
                                                            //color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  Column(
                                                    children: [
                                                      Form(
                                                        key:
                                                        panValidateKey,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              32),
                                                          child:
                                                          TextFormField(
                                                            controller: bloc
                                                                .panNumber,
                                                            decoration: InputDecoration(
                                                                labelText: StringUtils
                                                                    .panNumber,
                                                                labelStyle: TextStyle(
                                                                    color: Theme
                                                                        .of(
                                                                        context)
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.color),
                                                                suffixIcon: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      8.0,
                                                                      horizontal:
                                                                      12.0),
                                                                  child:
                                                                  PinkBorderButton(
                                                                    isEnabled:
                                                                    true,
                                                                    content:
                                                                    StringUtils
                                                                        .validate,
                                                                    onPressed:
                                                                        () {
                                                                      final form =
                                                                          panValidateKey
                                                                              .currentState;
                                                                      if (form
                                                                          ?.validate() ??
                                                                          false) {
                                                                        form
                                                                            ?.save();
                                                                        bloc
                                                                            .getPanData(
                                                                            context);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                enabledBorder: Theme
                                                                    .of(context)
                                                                    .inputDecorationTheme
                                                                    .border,
                                                                focusedBorder: Theme
                                                                    .of(context)
                                                                    .inputDecorationTheme
                                                                    .border),
                                                            validator:
                                                                (val) {
                                                              PANValidator
                                                              panValidator =
                                                              PANValidator();
                                                              if (val ==
                                                                  null ||
                                                                  val.isEmpty) {
                                                                return StringUtils
                                                                    .valEmptyPANNumber;
                                                              } else if (
                                                              !panValidator
                                                                  .validate(
                                                                  val)) {
                                                                return StringUtils
                                                                    .valValidPANNumber;
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            inputFormatters: [
                                                              UpperCaseTextFormatter(),
                                                            ],
                                                            maxLength: 10,
                                                            keyboardType:
                                                            TextInputType
                                                                .text,
                                                            style: TextStyle(
                                                                color: appTheme
                                                                    .speedDialLabelBgDT),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8,
                                                            horizontal:
                                                            32),
                                                        child:
                                                        TextFormField(
                                                          controller: bloc
                                                              .panName,
                                                          decoration:
                                                          InputDecoration(
                                                            labelText:
                                                            StringUtils
                                                                .name,
                                                            labelStyle: TextStyle(
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.color),
                                                            border: Theme
                                                                .of(
                                                                context)
                                                                .inputDecorationTheme
                                                                .border,
                                                            enabled:
                                                            false,
                                                            fillColor:
                                                            appTheme
                                                                .speedDialLabelBgDT,
                                                            filled: true,
                                                          ),
                                                          validator:
                                                              (val) {
                                                            if (val == null ||
                                                                val.isEmpty) {
                                                              return StringUtils
                                                                  .valEmptyPANName;
                                                            } else
                                                            if (!ApiClient
                                                                .nameRegExp
                                                                .hasMatch(
                                                                val)) {
                                                              return StringUtils
                                                                  .valValidPANName;
                                                            }
                                                            return null;
                                                          },
                                                          keyboardType:
                                                          TextInputType
                                                              .name,
                                                          style:
                                                          const TextStyle(
                                                            fontFamily:
                                                            "Poppins",
                                                            //color: Colors.white
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  child: MergeSemantics(
                                                    child: ListTile(
                                                      title: const Text(
                                                          StringUtils
                                                              .personalWithGST),
                                                      trailing:
                                                      CupertinoSwitch(
                                                        activeColor: appTheme
                                                            .primaryColor,
                                                        trackColor: appTheme
                                                            .speedDialLabelBgDT,
                                                        value: bloc.withGSTA,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            bloc.withGSTA =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          bloc.withGSTA =
                                                          !bloc.withGSTA;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    bloc.withGSTA
                                                        ?
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              32),
                                                          child:
                                                          GestureDetector(
                                                            onTap:
                                                                () async {
                                                              bloc.gst =
                                                              await _pickFile();
                                                              if (bloc
                                                                  .gst !=
                                                                  null) {
                                                                titleGst =
                                                                    StringUtils
                                                                        .fileUploaded;
                                                              } else {
                                                                titleGst =
                                                                    StringUtils
                                                                        .gstCertification;
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 8,
                                                                    horizontal: 16),
                                                                decoration: BoxDecoration(
                                                                    border: Border
                                                                        .all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius: const BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            8))),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Text(
                                                                      titleGst,
                                                                      maxLines: 2,
                                                                      overflow: TextOverflow
                                                                          .ellipsis,
                                                                      textAlign: TextAlign
                                                                          .start,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top: 8.0,
                                                                          bottom: 8.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                          SvgImages
                                                                              .iconAttachment,
                                                                          height: 20,
                                                                          width: 20),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                      ],
                                                    )
                                                        :
                                                    Container(),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          32),
                                                      child:
                                                      GestureDetector(
                                                        onTap:
                                                            () async {
                                                          bloc.pan =
                                                          await _pickFile();
                                                          if (bloc
                                                              .pan !=
                                                              null) {
                                                            titlePan =
                                                                StringUtils
                                                                    .fileUploaded;
                                                          } else {
                                                            titlePan =
                                                                StringUtils
                                                                    .panCard;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                            decoration: BoxDecoration(
                                                                border: Border
                                                                    .all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    8))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  titlePan,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                  textAlign: TextAlign
                                                                      .start,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 8.0,
                                                                      bottom: 8.0),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                      SvgImages
                                                                          .iconAttachment,
                                                                      height: 20,
                                                                      width: 20),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .fromLTRB(
                                                          32,
                                                          8,
                                                          32,
                                                          12),
                                                      child: Text(
                                                        StringUtils
                                                            .uploadContent,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                        style: TextStyle(
                                                            color: appTheme
                                                                .separatorColor,
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                /*: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          32),
                                                      child:
                                                      GestureDetector(
                                                        onTap:
                                                            () async {
                                                          bloc.pan =
                                                          await _pickFile();
                                                          if (bloc.pan !=
                                                              null) {
                                                            titlePan =
                                                            "file selected";
                                                          }
                                                        },
                                                        child: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                            decoration: BoxDecoration(
                                                                border: Border
                                                                    .all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    8))),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  titlePan,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                  textAlign: TextAlign
                                                                      .start,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 8.0,
                                                                      bottom: 8.0),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                      SvgImages
                                                                          .iconAttachment,
                                                                      height: 20,
                                                                      width: 20),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .fromLTRB(
                                                          32,
                                                          8,
                                                          32,
                                                          12),
                                                      child: Text(
                                                        StringUtils
                                                            .uploadContent,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                        style: TextStyle(
                                                            color: appTheme
                                                                .separatorColor,
                                                            fontSize:
                                                            12,
                                                            fontWeight:
                                                            FontWeight.normal),
                                                      ),
                                                    ),
                                                  ],
                                                )*/
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                      : selectedIndex == 3
                                      ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Form(
                                        key: bankValidateKey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  vertical: 8,
                                                  horizontal: 32),
                                              child: TextFormField(
                                                controller:
                                                bloc.bankAcNo,
                                                decoration: InputDecoration(
                                                    labelText: StringUtils
                                                        .bankAcNumber,
                                                    labelStyle: TextStyle(
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.color),
                                                    enabledBorder: Theme
                                                        .of(
                                                        context)
                                                        .inputDecorationTheme
                                                        .border,
                                                    focusedBorder: Theme
                                                        .of(context)
                                                        .inputDecorationTheme
                                                        .border),
                                                validator: (val) {
                                                  String pattern =
                                                      r'^\d{9,18}$';
                                                  RegExp regExp =
                                                  RegExp(pattern);
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return StringUtils
                                                        .valEmptyBankAcNumber;
                                                  } else if (val
                                                      .length <
                                                      9 ||
                                                      !regExp
                                                          .hasMatch(
                                                          val)) {
                                                    return StringUtils
                                                        .valValidBankAcNumber;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                maxLength: 18,
                                                keyboardType:
                                                TextInputType
                                                    .number,
                                                style: TextStyle(
                                                    color: appTheme
                                                        .speedDialLabelBgDT),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  vertical: 8,
                                                  horizontal: 32),
                                              child: TextFormField(
                                                controller:
                                                bloc.ifscCode,
                                                decoration:
                                                InputDecoration(
                                                    labelText:
                                                    StringUtils
                                                        .ifscCode,
                                                    labelStyle: TextStyle(
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.color),
                                                    suffixIcon:
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical:
                                                          8.0,
                                                          horizontal:
                                                          12.0),
                                                      child:
                                                      PinkBorderButton(
                                                        isEnabled:
                                                        true,
                                                        content:
                                                        StringUtils
                                                            .validate,
                                                        onPressed:
                                                            () {
                                                          final form =
                                                              bankValidateKey
                                                                  .currentState;
                                                          if (form
                                                              ?.validate() ??
                                                              false) {
                                                            form?.save();
                                                            bloc.getBankData(
                                                                context);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    /*  fillColor: Colors.white,
                                                                        filled: true,*/
                                                    enabledBorder: Theme
                                                        .of(
                                                        context)
                                                        .inputDecorationTheme
                                                        .border,
                                                    focusedBorder: Theme
                                                        .of(
                                                        context)
                                                        .inputDecorationTheme
                                                        .border),
                                                validator: (val) {
                                                  String pattern =
                                                      r'/^[A-Za-z]{4}[a-zA-Z0-9]{7}$/';
                                                  RegExp regExp =
                                                  RegExp(pattern);
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return StringUtils
                                                        .valEmptyIFSCCode;
                                                  } else if (val
                                                      .length !=
                                                      11 ||
                                                      regExp
                                                          .hasMatch(
                                                          val)) {
                                                    return StringUtils
                                                        .valValidIFSCCode;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                inputFormatters: [
                                                  UpperCaseTextFormatter(),
                                                ],
                                                onFieldSubmitted: (value) {
                                                  bloc.bankAcHolderName.clear();
                                                },
                                                maxLength: 11,
                                                keyboardType:
                                                TextInputType
                                                    .text,
                                                style: TextStyle(
                                                    color: appTheme
                                                        .speedDialLabelBgDT),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            vertical: 8,
                                            horizontal: 32),
                                        child: TextFormField(
                                          controller:
                                          bloc.bankAcHolderName,
                                          decoration: InputDecoration(
                                            labelText: StringUtils
                                                .bankAcHolder,
                                            labelStyle: TextStyle(
                                                color:
                                                Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.color),
                                            border: Theme
                                                .of(context)
                                                .inputDecorationTheme
                                                .border,
                                            enabled: false,
                                            fillColor: appTheme
                                                .speedDialLabelBgDT,
                                            filled: true,
                                          ),
                                          validator: (val) {
                                            if (val == null ||
                                                val.isEmpty) {
                                              return StringUtils
                                                  .valEmptyACHolderName;
                                            } else if (!ApiClient
                                                .nameRegExp
                                                .hasMatch(
                                                val)) {
                                              return StringUtils
                                                  .valValidACHolderName;
                                            }
                                            return null;
                                          },
                                          keyboardType:
                                          TextInputType.name,
                                          style: const TextStyle(
                                            fontFamily: "Poppins",
                                            //color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            vertical: 16,
                                            horizontal: 32),
                                        child:
                                        DropdownButtonHideUnderline(
                                          child:
                                          DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                                labelText: StringUtils
                                                    .certificationType,
                                                labelStyle: TextStyle(
                                                    color: Theme
                                                        .of(
                                                        context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.color),
                                                hintStyle: TextStyle(
                                                    color:
                                                    Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.color),
                                                fillColor:
                                                Colors.white,
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal:
                                                    16),
                                                enabledBorder:
                                                Theme
                                                    .of(context)
                                                    .inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                Theme
                                                    .of(context)
                                                    .inputDecorationTheme
                                                    .border),
                                            dropdownDecoration:
                                            BoxDecoration(
                                                color:
                                                Colors.white,
                                                border:
                                                Border.all(
                                                  width: 1,
                                                  color: Colors
                                                      .white,
                                                ),
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        8))),
                                            isExpanded: true,
                                            icon: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: SvgPicture.asset(
                                                  SvgImages.dropdown,
                                                  height: 28,
                                                  width: 28),
                                            ),
                                            hint: bloc
                                                .selectedCertificateType == null
                                                ? const Text(
                                                StringUtils
                                                    .selectCertificationType,
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                textAlign:
                                                TextAlign
                                                    .start,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .white))
                                                : Text(
                                                bloc.selectedCertificateType!,
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                textAlign:
                                                TextAlign
                                                    .start,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .white)),
                                            selectedItemBuilder:
                                                (BuildContext
                                            context) {
                                              return itemsCertificateType
                                                  .map<Widget>(
                                                      (String item) {
                                                    return Text(item,
                                                        maxLines: 2,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                        TextAlign
                                                            .start,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .white));
                                                  }).toList();
                                            },
                                            items:
                                            _addDividersAfterItems(
                                                itemsCertificateType),
                                            /*items: items.map((String item) {
                                                  return DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text('Log $item'),
                                                  );
                                                }).toList(),
                                                customItemsIndexes: _getDividersIndexes(),
                                                customItemsHeight: 4,*/
                                            customItemsHeight: 1,
                                            value: bloc.selectedCertificateType,
                                            onChanged: (value) {
                                              setState(() {
                                                bloc.selectedCertificateType =
                                                value as String;
                                              });
                                            },
                                            buttonHeight: 55,
                                            buttonWidth:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width -
                                                64,
                                            itemHeight: 55,
                                            itemPadding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 8.0),
                                            selectedItemHighlightColor:
                                            appTheme.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 32),
                                        child: GestureDetector(
                                          onTap: () async {
                                            bloc.academicCertificate =
                                            await _pickFile();
                                            if (bloc
                                                .academicCertificate !=
                                                null) {
                                              titleAcademicCertificate =
                                                  StringUtils
                                                      .fileUploaded;
                                            } else {
                                              titleAcademicCertificate =
                                                  StringUtils
                                                      .uploadCertification;
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  vertical: 8,
                                                  horizontal: 16),
                                              decoration:
                                              BoxDecoration(
                                                  border:
                                                  Border.all(
                                                    width: 1,
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius
                                                      .all(
                                                      Radius.circular(
                                                          8))),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    titleAcademicCertificate,
                                                    maxLines: 2,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    textAlign:
                                                    TextAlign
                                                        .start,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        top: 8.0,
                                                        bottom:
                                                        8.0),
                                                    child: SvgPicture
                                                        .asset(
                                                        SvgImages
                                                            .iconAttachment,
                                                        height:
                                                        20,
                                                        width:
                                                        20),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            32, 8, 32, 12),
                                        child: Text(
                                          StringUtils.uploadContent,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: appTheme
                                                  .separatorColor,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: PinkBorderButton(
                                isEnabled: false,
                                content: StringUtils.previous,
                                onPressed: () {
                                  onBack(true);
                                },
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: PinkBorderButton(
                                isEnabled: true,
                                content: nextButton,
                                onPressed: () {
                                  goNext(context);
                                  /*switch (selectedIndex) {
                                    case 0:
                                      if (DefaultTabController.of(context)
                                              ?.index ==
                                          0) {
                                        if (kycAutomateKey.currentState
                                                ?.validate() ==
                                            false) {
                                          CommonToast.getInstance()
                                              ?.displayToast(
                                                  message: StringUtils
                                                      .valEmptyAadharDetails);
                                        }
                                      } else if (DefaultTabController.of(
                                                      context)
                                                  ?.index ==
                                              1 &&
                                          kycManualKey.currentState
                                                  ?.validate() ==
                                              true) {
                                        if (bloc.aadharFront == null ||
                                            bloc.aadharBack == null) {
                                          CommonToast.getInstance()
                                              ?.displayToast(
                                                  message: StringUtils
                                                      .valUploadAadharDetails);
                                        } else {

                                        }
                                      } else {
                                        CommonToast.getInstance()?.displayToast(
                                            message: StringUtils
                                                .valEmptyAadharDetails);
                                      }
                                      return;
                                    case 1:
                                      return;
                                    case 2:
                                      return;
                                    case 3:
                                      return;
                                    default:
                                      return;
                                  }*/

                                  //older trial
                                  /* if ((selectedIndex == 0 &&
                                          DefaultTabController
                                                      .of(context)
                                                  ?.index ==
                                              0 &&
                                          kycAutomateKey
                                                  .currentState
                                                  ?.validate() ==
                                              true) ||
                                      (selectedIndex ==
                                              0 &&
                                          DefaultTabController
                                                      .of(context)
                                                  ?.index ==
                                              1 &&
                                          kycManualKey
                                                  .currentState
                                                  ?.validate() ==
                                              true) ||
                                      (selectedIndex ==
                                              1 &&
                                          DefaultTabController
                                                      .of(context)
                                                  ?.index ==
                                              0 &&
                                          accountAutomateKey
                                                  .currentState
                                                  ?.validate() ==
                                              true) ||
                                      (selectedIndex == 1 &&
                                          DefaultTabController.of(context)
                                                  ?.index ==
                                              1 &&
                                          accountManualKey.currentState
                                                  ?.validate() ==
                                              true) ||
                                      (selectedIndex == 2 &&
                                          bankKey.currentState?.validate() ==
                                              true)) {}*/
                                },
                              )),
                        ],
                      ),
                    ),
                  )
                  ,
                ]
                ,
              )
              ,
            );
          }),
          /*StreamBuilder(
              stream: _bloc.mainStream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Container();
              },
            ),*/
        ),
      ),
    );
  }

  void onBack(bool previous) {
    if (selectedIndex != 1) {
      selectedIndex--;
      if (selectedIndex != 4) {
        nextButton = StringUtils.next;
      }
      if (selectedIndex == 1) {
        isPersonalDetailsVisible = true;
      }
      setState(() {});
      _keyRPhases.currentState!.methodInChild(selectedIndex);
    } else if (!previous) {
      Navigator.pop(context);
    }
  }

  void goNext(BuildContext context) async {
    if (selectedIndex != 4) {
      switch (selectedIndex) {
        case 1:
          {
            if (bloc.automatedManual == 0) {
              if (!(personalDetailsKey
                  .currentState
                  ?.validate() ??
                  false)) {
                return;
              }
              else if (!((sendAadharOTPKey.currentState?.validate() ?? false) &&
                  (validateAadharOTPKey.currentState?.validate() ?? false)) ||
                  bloc.aadharAName.text.isEmpty) {
                CommonToast.getInstance()
                    ?.displayToast(
                    message: StringUtils.valEmptyAadharDetails);
                return;
              }
            }
            else {
              if (!(kycManualKey
                  .currentState
                  ?.validate() ??
                  false)) {
                return;
              }
              else if (bloc.aadharFront == null || bloc.aadharBack == null) {
                CommonToast.getInstance()
                    ?.displayToast(
                    message: StringUtils.valUploadAadharDetails);
                return;
              }
            }
            selectedIndex++;
            isPersonalDetailsVisible = false;
            setState(() {});
            _keyRPhases.currentState!.methodInChild(selectedIndex);
          }
          break;

        case 2:
          {
            if (bloc.automatedManual == 0) {
              if (bloc.withGSTA) {
                if (!(gstValidateKey
                    .currentState
                    ?.validate() ??
                    false)) {
                  return;
                }
                else if (bloc.gstName.text.isEmpty) {
                  CommonToast.getInstance()
                      ?.displayToast(
                      message: StringUtils.valEmptyGstDetails);
                  return;
                }
              }
              else {
                if (!(panValidateKey
                    .currentState
                    ?.validate() ??
                    false)) {
                  return;
                }
                else if (bloc.panName.text.isEmpty) {
                  CommonToast.getInstance()
                      ?.displayToast(
                      message: StringUtils.valEmptyPanDetails);
                  return;
                }
              }
            }
            else {
              if (bloc.withGSTA && bloc.gst == null) {
                CommonToast.getInstance()
                    ?.displayToast(
                    message: StringUtils.valUploadGSTDetails);
                return;
              }
              else if (bloc.pan == null) {
                CommonToast.getInstance()
                    ?.displayToast(
                    message: StringUtils.valUploadPanDetails);
                return;
              }
            }
            selectedIndex++;
            isPersonalDetailsVisible = false;
            setState(() {});
            _keyRPhases.currentState!.methodInChild(selectedIndex);
          }
          break;
        case 3:
          {
            if (!(bankValidateKey
                .currentState
                ?.validate() ??
                false)) {
              return;
            }
            else if (bloc.bankAcHolderName.text.isEmpty) {
              CommonToast.getInstance()
                  ?.displayToast(
                  message: StringUtils.valEmptyGstDetails);
              return;
            }
            selectedIndex++;
            isPersonalDetailsVisible = false;
            /* if (selectedIndex == 4) {*/
            nextButton = StringUtils.submit;
            //}
            setState(() {});
            _keyRPhases.currentState!.methodInChild(selectedIndex);
          }
          break;

        default:
          {
            //statements;
          }
          break;
      }
    } else {
      if (bloc.selectedCertificateType != null &&
          bloc.academicCertificate != null) {
        var pospId = await bloc.registerPosp(context);
        if (pospId != null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  Dashboard(pospId: pospId)), (Route<dynamic> route) => false);
        }
      }
      else {
        CommonToast.getInstance()
            ?.displayToast(message: StringUtils.uploadAcademicCertificate);
      }
    }
  }

}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}