import 'dart:async';

import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/login/login_send_otp_bloc.dart';
import 'package:andapp/screen/support/custom_speed_dial.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginSendOTP extends StatefulWidget {
  const LoginSendOTP({Key? key}) : super(key: key);

  @override
  State<LoginSendOTP> createState() => _LoginSendOTPState();
}

class _LoginSendOTPState extends State<LoginSendOTP>
    with TickerProviderStateMixin {
  final LoginSendOTPBloc bloc = LoginSendOTPBloc();

  final sendOTPKey = GlobalKey<FormState>(),
      updateMobNoKey = GlobalKey<FormState>(),
      updateMOTPKey = GlobalKey<FormState>();
  bool isOtpEnabled = false;

/*
  Future<void> loadHtmlFromAssets() async {
    htmlTerms = await decodeStringFromAssets(
        AssetImages.htmlTerms);
    //document = htmlParser.parse(htmlTerms);
  }*/

  @override
  void initState() {
    super.initState();
    //loadHtmlFromAssets();
/*
    bloc.getToken(context, mounted);*/
  }

  Future<String> decodeStringFromAssets(String path) async {
    ByteData byteData = await PlatformAssetBundle().load(path);
    String htmlString = String.fromCharCodes(byteData.buffer.asUint8List());
    return htmlString;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        //backgroundColor: const Color(0xff222222),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(
                              child: SvgPicture.asset(
                            SvgImages.imageLoginLight,
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.height / 2.5,
                          ))),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Form(
                              key: sendOTPKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 32),
                                    child: TextFormField(
                                      controller: bloc.mobNo,
                                      decoration: InputDecoration(
                                          labelText: "Mobile Number",
                                          labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          fillColor: Colors.white,
                                          enabledBorder: Theme.of(context)
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder: Theme.of(context)
                                              .inputDecorationTheme
                                              .border),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      validator: (val) {
                                        String pattern =
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                        RegExp regExp = RegExp(pattern);
                                        if (val == null || val.isEmpty) {
                                          return "Please enter mobile number";
                                        } else if (val.length != 10 ||
                                            !regExp.hasMatch(val)) {
                                          return "Please enter valid mobile number";
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
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: PinkBorderButton(
                                        isEnabled: true,
                                        content: StringUtils.otp,
                                        onPressed: () async {
                                          final form = sendOTPKey.currentState;
                                          if (form?.validate() ?? false) {
                                            form?.save();
                                            SmsAutoFill().getAppSignature;
                                            SmsAutoFill().listenForCode;
                                            bloc.sendOTP(context);
                                          }
                                        },
                                      )),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.email.clear();
                                bloc.otp.clear();
                                isOtpEnabled = false;
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: appTheme.greyBgColor,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.all(16),
                                              decoration: ShapeDecoration(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    // <-- SEE HERE
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  color: appTheme.primaryColor),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                        'Update Mobile Number',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Icon(Icons.clear),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              StringUtils.updateMobileTitle,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Form(
                                            key: updateMobNoKey,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 8, 16, 8),
                                              child: TextFormField(
                                                controller: bloc.email,
                                                decoration: InputDecoration(
                                                    labelText: "Email ID",
                                                    hintStyle: TextStyle(
                                                        color: appTheme
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //color: Colors.white
                                                        ),
                                                    labelStyle: TextStyle(
                                                      color:
                                                          appTheme.primaryColor,
                                                      //fontWeight: FontWeight.w500
                                                      //color: Colors.white
                                                    ),
                                                    suffixIcon: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 12.0),
                                                      child: PinkBorderButton(
                                                        isEnabled: true,
                                                        content:
                                                            StringUtils.otp,
                                                        onPressed: () async {
                                                          final form =
                                                              updateMobNoKey
                                                                  .currentState;
                                                          if (form?.validate() ??
                                                              false) {
                                                            form?.save();
                                                            await bloc
                                                                .sendOTPUpdateMobile(
                                                                    context)
                                                                .then((value) {
                                                              if (bloc.updateMobOtp !=
                                                                  null) {
                                                                bloc.otp.text =
                                                                    bloc.updateMobOtp!;
                                                                isOtpEnabled =
                                                                    true;
                                                              }
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    enabledBorder: Theme.of(
                                                            context)
                                                        .inputDecorationTheme
                                                        .border,
                                                    focusedBorder: Theme.of(
                                                            context)
                                                        .inputDecorationTheme
                                                        .border),
                                                validator: (val) {
                                                  // ignore: prefer_is_empty
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "Please enter email Id";
                                                  } else if (!EmailValidator
                                                      .validate(val, true)) {
                                                    return "Please enter valid email Id";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                style: TextStyle(
                                                    color: appTheme
                                                        .speedDialLabelBgDT),
                                              ),
                                            ),
                                          ),
                                          Form(
                                            key: updateMOTPKey,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16,
                                                  8,
                                                  16,
                                                  MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: TextFormField(
                                                controller: bloc.otp,
                                                decoration: InputDecoration(
                                                    labelText: StringUtils.otp,
                                                    labelStyle: const TextStyle(
                                                        color: Colors.white),
                                                    suffixIcon: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 12.0),
                                                      child: PinkBorderButton(
                                                        isEnabled: true,
                                                        content: "Verify",
                                                        onPressed: () async {
                                                          final form =
                                                              updateMOTPKey
                                                                  .currentState;
                                                          if (form?.validate() ??
                                                              false) {
                                                            form?.save();
                                                            if (bloc.otp.text ==
                                                                bloc.updateMobOtp!) {
                                                              await bloc
                                                                  .updateMobile(
                                                                      context)
                                                                  .then(
                                                                      (value) {});
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    fillColor: appTheme
                                                        .speedDialLabelBgDT,
                                                    filled: true,
                                                    enabled: isOtpEnabled,
                                                    enabledBorder: Theme.of(
                                                            context)
                                                        .inputDecorationTheme
                                                        .border,
                                                    focusedBorder: Theme.of(
                                                            context)
                                                        .inputDecorationTheme
                                                        .border),
                                                validator: (val) {
                                                  // ignore: prefer_is_empty
                                                  if (val?.length == 0 &&
                                                      val?.length != 5) {
                                                    return "Please enter valid OTP";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.phone,
                                                style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16.0, 16, 16, 32),
                                            child: Text(
                                              StringUtils.updateMobileContent,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Text(
                                "Update Mobile Number",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: StringUtils.termsConditionsByContinue,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color)),
                          TextSpan(
                              text: " ${StringUtils.termsConditions}",
                              style: TextStyle(color: appTheme.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        // <-- SEE HERE
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.5,
                                          maxChildSize: 0.75,
                                          builder: (_, controller) =>
                                              SingleChildScrollView(
                                            controller: controller,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    decoration: ShapeDecoration(
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          // <-- SEE HERE
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    16.0),
                                                          ),
                                                        ),
                                                        color: appTheme
                                                            .primaryColor),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                              StringUtils
                                                                  .termsConditions,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Icon(
                                                              Icons.clear),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: HtmlWidget(
                                                    // the first parameter (`html`) is required
                                                    StringUtils.htmlTerms,
                                                    // turn on selectable if required (it's disabled by default)
                                                    isSelectable: true,
                                                    customStylesBuilder:
                                                        (element) {
                                                      if (element.classes
                                                          .contains(
                                                              'modal-body')) {
                                                        return {
                                                          'color': 'black'
                                                        };
                                                      }
                                                      return null;
                                                    },

                                                    // these callbacks are called when a complicated element is loading
                                                    // or failed to render allowing the app to render progress indicator
                                                    // and fallback widget
                                                    onErrorBuilder: (context,
                                                            element, error) =>
                                                        Text(
                                                            '$element error: $error'),
                                                    /*    onLoadingBuilder: (
                                                                    context,
                                                                    element,
                                                                    loadingProgress) => AppComponentBase.getInstance()?.showProgressDialog(true),*/
                                                    // this callback will be triggered when user taps a link
                                                    //onTapUrl: (url) => print('tapped $url'),

                                                    // select the render mode for HTML body
                                                    // by default, a simple `Column` is rendered
                                                    // consider using `ListView` or `SliverList` for better performance
                                                    renderMode:
                                                        RenderMode.column,

                                                    // set the default styling for text
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black45),

                                                    // turn on `webView` if you need IFRAME support (it's disabled by default)
                                                    //webView: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }),
                        ])),
                      )
                    ]),
              ),
            ),
          );
        }),
        floatingActionButtonLocation:
            const CustomFloatingActionButtonLocation(0, -24),
        floatingActionButton: const CustomSpeedDial(),
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

class CustomFloatingActionButtonLocation
    implements FloatingActionButtonLocation {
  final double x;
  final double y;

  const CustomFloatingActionButtonLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);
  }
}