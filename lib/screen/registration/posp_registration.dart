import 'package:andapp/common/string_utils.dart';
import 'package:andapp/enum/font_type.dart';
import 'package:andapp/screen/login/login_verify_otp_page.dart';
import 'package:andapp/screen/registration/account_details.dart';
import 'package:andapp/screen/registration/registration_phases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';

class PoSPRegistration extends StatefulWidget {
  const PoSPRegistration({Key? key}) : super(key: key);

  @override
  State<PoSPRegistration> createState() => _PoSPRegistrationState();
}

class _PoSPRegistrationState extends State<PoSPRegistration>{
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("PoSP Registration",textAlign : TextAlign.left
          ,style: Theme.of(context).appBarTheme.titleTextStyle,),
          backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
          centerTitle: true,
          elevation: 0,
          // give the app bar rounded corners
          leading:
    Builder(
    builder: (BuildContext context) {
    return IconButton(
    icon: const Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: () {  Navigator.pop(
        context); },
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
    },)),
         /*
          const Icon(
            Icons.arrow_back,
            color: Colors.white
          ),),*/
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor, //const Color(0xff222222),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  //height: 320,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 32),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: StringUtils.userName,
                              labelStyle: TextStyle(color: Theme
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
                                  .border
                          ),
                          validator: (val) {
                            // ignore: prefer_is_empty
                            if (val?.length == 0 &&
                                val?.length != 10) {
                              return "Please enter valid mobile number";
                            }
                            else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
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
                          decoration: InputDecoration(
                              labelText: StringUtils.emailID,
                              labelStyle: TextStyle(color: Theme
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
                                  .border
                          ),
                          validator: (val) {
                            // ignore: prefer_is_empty
                            if (val?.length == 0 &&
                                val?.length != 10) {
                              return "Please enter valid mobile number";
                            }
                            else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
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
                          decoration: InputDecoration(
                              labelText: StringUtils.whatsappNumber,
                              labelStyle: TextStyle(color: Theme
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
                                  .border
                          ),
                          validator: (val) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = RegExp(pattern);
                            if (val == null || val.isEmpty) {
                              return "Please enter whatsapp number";
                            }
                            else if (
                            val.length != 10 ||
                                !regExp.hasMatch(val)) {
                              return "Please enter valid whatsapp number";
                            }
                            else {
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

                      const RegistrationPhases(index:1),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 32),
                  child:
                  SizedBox(
                      height: 50,
                      child:TabBar(
                        indicatorColor: _appTheme.primaryColor,
                        labelColor: _appTheme.primaryColor,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        labelStyle: const TextStyle(fontSize: 16),
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 16),
                        tabs: const [
                          Tab(text: "Automated"),
                          Tab(text: "Manual"),
                        ],
                      )
                  ),
                ),

                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: StringUtils.aadharNumber,
                                    labelStyle: TextStyle(color: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: PinkBorderButton(
                                        isEnabled: true,
                                        content: StringUtils.otp,
                                        onPressed: () {},),
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    color: _appTheme.speedDialLabelBgDT
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: StringUtils.otp,
                                    labelStyle: TextStyle(color: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: PinkBorderButton(
                                        isEnabled: true,
                                        content: StringUtils.validate,
                                        onPressed: () {},),
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 5) {
                                    return "Please enter valid otp";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: _appTheme.speedDialLabelBgDT
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0, 0, 12),
                              child: Text(
                                StringUtils
                                    .regOtpContent,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: _appTheme.separatorColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: StringUtils.name,
                                  labelStyle: TextStyle(color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color),
                                  border: Theme
                                      .of(context)
                                      .inputDecorationTheme
                                      .border,
                                  enabled:
                                  false,
                                  fillColor: _appTheme.speedDialLabelBgDT,
                                  filled: true,
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.name,
                                style: const TextStyle(
                                  fontFamily: "Popp"
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      ""
                                      "ins",
                                  //color: Colors.white
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: StringUtils.gender,
                                  labelStyle: TextStyle(color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color),
                                  border: Theme
                                      .of(context)
                                      .inputDecorationTheme
                                      .border,
                                  enabled:
                                  false,
                                  fillColor: _appTheme.speedDialLabelBgDT,
                                  filled: true,
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.name,
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
                                decoration: InputDecoration(
                                  labelText: StringUtils.birthdate,
                                  labelStyle: TextStyle(color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color),
                                  border: Theme
                                      .of(context)
                                      .inputDecorationTheme
                                      .border,
                                  enabled:
                                  false,
                                  fillColor: _appTheme.speedDialLabelBgDT,
                                  filled: true,
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.name,
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
                                decoration: InputDecoration(
                                  labelText: StringUtils.address,
                                  labelStyle: TextStyle(color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color),
                                  border: Theme
                                      .of(context)
                                      .inputDecorationTheme
                                      .border,
                                  enabled:
                                  false,
                                  fillColor: _appTheme.speedDialLabelBgDT,
                                  filled: true,
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.name,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  //color: Colors.white
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: StringUtils.salutation,
                                    labelStyle: TextStyle(color: Theme
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
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
                                decoration: InputDecoration(
                                    labelText: StringUtils.firstName,
                                    labelStyle: TextStyle(color: Theme
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
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
                                decoration: InputDecoration(
                                    labelText: StringUtils.middleName,
                                    labelStyle: TextStyle(color: Theme
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
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
                                decoration: InputDecoration(
                                    labelText: StringUtils.lastName,
                                    labelStyle: TextStyle(color: Theme
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
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
                                decoration: InputDecoration(
                                    labelText: StringUtils.gender,
                                    labelStyle: TextStyle(color: Theme
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
                                        .border
                                ),
                                validator: (val) {
                                  // ignore: prefer_is_empty
                                  if (val?.length == 0 &&
                                      val?.length != 10) {
                                    return "Please enter valid mobile number";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.phone,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  //color: Colors.white
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(8))
                                      ),
                                      child : Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: (MediaQuery.of(context).size.width / 2) - 108,
                                            child: const Text(StringUtils.front, maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                            child: SvgPicture.asset(SvgImages.iconAttachment, height: 20,width : 20),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(8))
                                        ),
                                        child : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context).size.width / 2) - 108,
                                              child: const Text(StringUtils.back, maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                                              child: SvgPicture.asset(SvgImages.iconAttachment, height: 20,width : 20),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0, 0, 12),
                              child: Text(
                                StringUtils
                                    .uploadContent,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: _appTheme.separatorColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: PinkBorderButton(
                            isEnabled: true,
                            content: "Previous",
                            onPressed: () {
                             /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginVerifyOTP();
                                    }),
                              );*/
                            },)
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: PinkBorderButton(
                            isEnabled: true,
                            content: "Next",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return const AccountDetails();
                                    }),
                              );
                            },)
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
        /*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/
      ),
    );
  }
}
