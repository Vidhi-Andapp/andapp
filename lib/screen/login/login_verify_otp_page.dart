import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/login/login_verify_otp_bloc.dart';
import 'package:andapp/screen/login/timer_button.dart';
import 'package:andapp/screen/support/custom_speed_dial.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginVerifyOTP extends StatefulWidget {
  final String enteredMobNo;
  final int? otp;

  const LoginVerifyOTP({Key? key, required this.enteredMobNo, this.otp})
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
  String? appSignature, _code;
  int? otpToCompare;

  @override
  void initState() {
    otpToCompare = widget.otp;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });

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

  @override
  void codeUpdated() {
    /*_code = code!;
    print("inside code updated : $code");
    setState(() {});*/
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    //bloc.otp.text = "${widget.otp}";
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
                                        text: StringUtils.verifyOTPTitle,
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
                                    /*  TextFormField(
                                  controller: bloc.otp,
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
                                  validator: (val) {
                                    String pattern = r'^(?:[0-9])?[0-9]{3,5}$';
                                    RegExp regExp = RegExp(pattern);
                                    if (val == null || val.isEmpty) {
                                      return "Please enter OTP";
                                    } else if (val.length != 5 ||
                                        !regExp.hasMatch(val)) {
                                      return "Please enter valid OTP";
                                    } else {
                                      return null;
                                    }
                                  },
                                  */ /* inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                  ],*/ /*
                                  maxLength: 5,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true),
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
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                  ],
                                  /*validator: (val) {
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
                                      },*/
                                  codeLength: 5,
                                  currentCode: _code,
                                  onCodeSubmitted: (code) {
                                    _code = code;
                                    //print("inside code submitted : $code");
                                  },
                                  onCodeChanged: (code) {
                                    //print("code changed: $code");
                                    _code = code;
                                  },
                                ),
                              ),
                              TimerButton(
                                label: StringUtils.resendOtp,
                                timeOutInSeconds: 120,
                                onTimeExpired: () {
                                  otpToCompare = int.tryParse("");
                                  setState(() {});
                                },
                                onPressed: () async {
                                  var otp = await bloc.reSendOTP(
                                      context, widget.enteredMobNo);
                                  if (otp != null) {
                                    otpToCompare = otp;
                                  }
                                  setState(() {});
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
                                      content: StringUtils.verify,
                                      onPressed: () {
                                        final form = verifyOTPKey.currentState;
                                        if (form!.validate()) {
                                          //form.save();
                                          //bloc.verifyOTP(context);
                                          print("otpToCompare : $otpToCompare");
                                          String pattern = r"^[0-9]{5}$";
                                          RegExp regExp = RegExp(pattern);
                                          if (_code == null || _code!.isEmpty) {
                                            CommonToast.getInstance()
                                                ?.displayToast(
                                                    message: StringUtils
                                                        .valEmptyOtp);
                                          } else if (!regExp.hasMatch(_code!)) {
                                            CommonToast.getInstance()
                                                ?.displayToast(
                                                    message: StringUtils
                                                        .valValidOtp);
                                          } else if (otpToCompare == null) {
                                            CommonToast.getInstance()
                                                ?.displayToast(
                                                    message: StringUtils
                                                        .verifyOTPExpired);
                                          } else if (_code ==
                                              otpToCompare.toString()) {
                                            bloc.getStatus(context, mounted,
                                                widget.enteredMobNo);
                                          } else {
                                            CommonToast.getInstance()
                                                ?.displayToast(
                                                    message: StringUtils
                                                        .verifyOTPFail);
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
                                                      decoration:
                                                          ShapeDecoration(
                                                              shape:
                                                                  const RoundedRectangleBorder(
                                                                // <-- SEE HERE
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .vertical(
                                                                  top: Radius
                                                                      .circular(
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
                                                                    fontSize:
                                                                        14,
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
                                                    padding:
                                                        const EdgeInsets.all(
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
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black45),

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