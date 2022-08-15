import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
import 'package:andapp/screen/login/login_verify_otp_bloc.dart';
import 'package:andapp/screen/login/timer_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'custom_speed_dial.dart';

class LoginVerifyOTP extends StatefulWidget {
  final String? enteredMobNo;
  final int? otp;

  const LoginVerifyOTP({Key? key, @required this.enteredMobNo, this.otp})
      : super(key: key);

  @override
  State<LoginVerifyOTP> createState() => _LoginVerifyOTPState();
}

class _LoginVerifyOTPState extends State<LoginVerifyOTP>
    with CodeAutoFill, TickerProviderStateMixin {
  final LoginVerifyOTPBloc bloc = LoginVerifyOTPBloc();
  bool isOpened = false;
  late AnimationController _animationController;
  final verifyOTPKey = GlobalKey<FormState>();
  String signature = "{{ app signature }}";
  String? appSignature, _code;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    //getSignature();
    // listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });

    super.initState();
  }

  void animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  void getSignature() async {
    signature = await SmsAutoFill().getAppSignature;
    setState(() {});
  }

  @override
  void codeUpdated() {
    setState(() {
      _code = code!;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    bloc.otp.text = "${widget.otp}";
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        backgroundColor: const Color(0xff222222),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: verifyOTPKey,
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 40),
                                child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            "Enter the 5 digit number that we have sent to ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.color,
                                            fontSize: 16),
                                      ),
                                      TextSpan(
                                        text: " ${widget.enteredMobNo}",
                                        style: TextStyle(
                                            color: appTheme.primaryColor,
                                            fontSize: 16),
                                      )
                                    ]),
                                    textAlign: TextAlign.center),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                                child:
                                    /* TextFormField(
                                      controller: bloc.otp,
                                      decoration: InputDecoration(
                                        labelText: StringUtils.otp,
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
                                            .border,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      validator: (val) {
                                        String pattern = r'^(?:[0-9])?[0-9]{3,5}$';
                                        RegExp regExp = RegExp(pattern);
                                        if (val == null || val.isEmpty) {
                                          return "Please enter OTP";
                                        }
                                        else if (
                                        val.length != 5 ||
                                            !regExp.hasMatch(val)) {
                                          return "Please enter valid OTP";
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      maxLength: 5,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(signed: true),
                                      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly]),
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        //color: Colors.white
                                      ),
                                    ),*/
                                    TextFieldPinAutoFill(
                                  decoration: InputDecoration(
                                    labelText: StringUtils.otp,
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
                                        .border,
                                  ),
                                  codeLength: 5,
                                  currentCode: _code,
                                  onCodeSubmitted: (code) {},
                                  onCodeChanged: (code) {
                                    if (code.length == 6) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  },
                                ),
                              ),
                              TimerButton(
                                label: "Resend OTP",
                                timeOutInSeconds: 120,
                                onPressed: () {
                                  bloc.reSendOTP(
                                      context, widget.enteredMobNo ?? "");
                                },
                                disabledColor: appTheme.dtBlackColor,
                                color: appTheme.dtBlackColor,
                                disabledTextStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: appTheme.resendColor),
                                activeTextStyle: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child: PinkBorderButton(
                                      isEnabled: true,
                                      content: "Verify",
                                      onPressed: () {
                                        final form = verifyOTPKey.currentState;
                                        if (form!.validate()) {
                                          form.save();
                                          //bloc.verifyOTP(context);
                                          if (widget.otp != null &&
                                              bloc.otp.text ==
                                                  widget.otp.toString()) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return const DocumentPage();
                                              }),
                                            );
                                          }
                                        }
                                      })),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "By continuing, you agree to our",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color)),
                            TextSpan(
                                text: " Terms and conditions",
                                style: TextStyle(color: appTheme.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          // <-- SEE HERE
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16.0),
                                          ),
                                        ),
                                        builder: (context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Column(
                                              //mainAxisSize: MainAxisSize.max,
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
                                                        const Text(
                                                            'Terms and Conditions',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
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
                                                const Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Text(
                                                    StringUtils.termsConditions,
                                                    /* style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.normal),*/
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                          ])),
                        )
                      ]),
                ),
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