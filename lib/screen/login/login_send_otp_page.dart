import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/login/login_verify_otp_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';
import 'custom_speed_dial.dart';
import 'package:email_validator/email_validator.dart';

class LoginSendOTP extends StatefulWidget {
  const LoginSendOTP({Key? key}) : super(key: key);

  @override
  State<LoginSendOTP> createState() => _LoginSendOTPState();
}

class _LoginSendOTPState extends State<LoginSendOTP> with TickerProviderStateMixin {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();
TextEditingController mobNo = TextEditingController();
final sendOTPKey = GlobalKey<FormState>(),updateMobNoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        //backgroundColor: const Color(0xff222222),
        body: LayoutBuilder(
            builder: (context, constraint) {
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
                              child: Center(child: SvgPicture.asset(
                                SvgImages.imageLoginLight, height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.5,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2.5,))
                          ),

                          Expanded(
                            child: Container(
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
                                            controller: mobNo,
                                            decoration: InputDecoration(
                                                labelText: "Mobile Number",
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
                                                return "Please enter mobile number";
                                              }
                                              else if (
                                              val.length != 10 ||
                                                  !regExp.hasMatch(val)) {
                                                return "Please enter valid mobile number";
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

                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 12.0),
                                            child: PinkBorderButton(
                                              isEnabled: true,
                                              content: "OTP",
                                              onPressed: () {
                                                final form = sendOTPKey
                                                    .currentState;
                                                if (form?.validate() ?? false) {
                                                  form?.save();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return LoginVerifyOTP(
                                                            enteredMobNo: mobNo
                                                                .text,);
                                                        }),
                                                  );
                                                }
                                              },)
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: _appTheme
                                              .greyBgColor,
                                          shape: const RoundedRectangleBorder( // <-- SEE HERE
                                            borderRadius: BorderRadius
                                                .vertical(
                                              top: Radius.circular(16.0),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Form(
                                              key: updateMobNoKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize
                                                    .min,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .stretch,
                                                children: <Widget>[
                                                  Container(
                                                      height: 50,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width,
                                                      padding: const EdgeInsets
                                                          .all(16),
                                                      decoration: ShapeDecoration(
                                                          shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                            borderRadius: BorderRadius
                                                                .vertical(
                                                              top: Radius
                                                                  .circular(
                                                                  16.0),
                                                            ),
                                                          ),
                                                          color: _appTheme
                                                              .primaryColor),
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                                'Update Mobile Number',
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight
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
                                                    padding: const EdgeInsets
                                                        .all(16.0),
                                                    child: Text(
                                                      StringUtils
                                                          .updateMobileTitle,
                                                      style: TextStyle(
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        16, 8, 16, 8),
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          labelText: "Email ID",
                                                          hintStyle: TextStyle(
                                                              color: _appTheme
                                                                  .primaryColor,
                                                              fontWeight: FontWeight.bold
                                                            //color: Colors.white
                                                          ),
                                                          labelStyle: TextStyle(
                                                              color: _appTheme
                                                                  .primaryColor,
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
                                                              content: StringUtils.otp,
                                                              onPressed: () {
                                                                final form = updateMobNoKey
                                                                    .currentState;
                                                                if (form
                                                                    ?.validate() ??
                                                                    false) {
                                                                  form
                                                                      ?.save();
                                                                  /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginVerifyOTP(enteredMobNo: mobNo.text,);
        }),
      );*/
                                                                }
                                                              },),
                                                          ),
                                                          fillColor: Colors
                                                              .white,
                                                          filled: true,
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
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return "Please enter email Id";
                                                        }
                                                        else
                                                        if (!EmailValidator
                                                            .validate(
                                                            val, true)) {
                                                          return "Please enter valid email Id";
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },

                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      style: TextStyle(
                                                          color: _appTheme
                                                              .speedDialLabelBgDT
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        16, 8, 16, MediaQuery
                                                        .of(context)
                                                        .viewInsets
                                                        .bottom),
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                          labelText: StringUtils
                                                              .otp,
                                                          labelStyle: const TextStyle(
                                                              color: Colors
                                                                  .white),
                                                          suffixIcon: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal: 12.0),
                                                            child: PinkBorderButton(
                                                              isEnabled: true,
                                                              content: "Verify",
                                                              onPressed: () {},),
                                                          ),
                                                          fillColor: _appTheme
                                                              .speedDialLabelBgDT,
                                                          filled: true,
                                                          enabled: false,
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
                                                        if (val?.length ==
                                                            0 &&
                                                            val?.length !=
                                                                10) {
                                                          return "Please enter valid mobile number";
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                      keyboardType: TextInputType
                                                          .phone,
                                                      style: const TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        16.0, 16, 16, 32),
                                                    child: Text(
                                                      StringUtils
                                                          .updateMobileContent,
                                                      textAlign: TextAlign
                                                          .center,
                                                      style: TextStyle(
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Text(
                                      "Update Mobile Number",
                                      style: TextStyle(fontSize: 14),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "By continuing, you agree to our",
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color)),
                                  TextSpan(text: " Terms and conditions",
                                      style: TextStyle(
                                          color: _appTheme.primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showModalBottomSheet(
                                              context: context,
                                              shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                borderRadius: BorderRadius
                                                    .vertical(
                                                  top: Radius.circular(16.0),
                                                ),
                                              ),

                                              builder: (context) {
                                                return SizedBox(
                                                  height: 200,
                                                  child: Column(
                                                    //mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .stretch,
                                                    children: <Widget>[
                                                      Container(
                                                          height: 50,
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width,
                                                          padding: const EdgeInsets
                                                              .all(16),
                                                          decoration: ShapeDecoration(
                                                              shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                                borderRadius: BorderRadius
                                                                    .vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                      16.0),
                                                                ),
                                                              ),
                                                              color: _appTheme
                                                                  .primaryColor),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              const Expanded(
                                                                child: Text(
                                                                    'Terms and Conditions',
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight
                                                                            .bold)),
                                                              ),

                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .pop(
                                                                      context);
                                                                },
                                                                child: const Icon(
                                                                    Icons
                                                                        .clear),
                                                              ),
                                                            ],
                                                          )),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(16.0),
                                                        child: Text(
                                                          StringUtils
                                                              .termsConditionsContent,
                                                          style: TextStyle(
                                                              color: Theme
                                                                  .of(context)
                                                                  .primaryColor,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight
                                                                  .normal),),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        }),
                                ])),
                          )
                        ]
                    ),
                  ),
                ),
              );
            }
        ),

        floatingActionButtonLocation: const CustomFloatingActionButtonLocation(
            0,
            -24),
        floatingActionButton:
        const CustomSpeedDial(),
        /*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/
      ),
    );
  }
  /*Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return Scaffold(
      //appBar: AppBar(),
      //backgroundColor: const Color(0xff222222),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top : 100.0),
              child: Center(child: SvgPicture.asset(SvgImages.imageLoginLight , height: 300,width: 300,)),
            ),

             Padding(
               padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 32),
               child: TextFormField(
                decoration:  InputDecoration(
                  labelText: "Mobile Number",
                  labelStyle: const TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:  const BorderSide(
                      width: 1,
                      //color: Colors.white
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                     width: 1,
                     //color: Colors.white
                 ),
               ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  // ignore: prefer_is_empty
                  if(val?.length==0 && val?.length != 10) {
                    return "Please enter valid mobile number";
                  }
                  else{
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
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
              child: PinkBorderButton(isEnabled: true,content: "OTP",onPressed: (){},)
*//*
OutlinedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.pink,width: 1),
                    shape: RoundedRectangleBorder(borderRadius : BorderRadius.circular(30))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("OTP",textAlign: TextAlign.center,style: TextStyle(color: Colors.pink),),
                  )
              ),
*//*

            ),
            const Text("Update Mobile Number",style: TextStyle(fontSize: 14),),
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: RichText(text: TextSpan(children: <TextSpan>[
                const TextSpan(text: "By continuing, you agree to our"),
                TextSpan(text: " Terms and conditions",style: TextStyle(color: _appTheme.primaryColor),recognizer:  TapGestureRecognizer()..onTap=(){
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder( // <-- SEE HERE
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),

                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Photo'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                }),
              ])),
            )
          ]
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          MediaQuery.of(context).size.width - 36,
          MediaQuery.of(context).size.height - 100),
      floatingActionButton:

      SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        // / This is ignored if animatedIcon is non null
        // child: Text("open"),
        // activeChild: Text("close"),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        dialRoot:(ctx, open, toggleChildren) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: SizedBox(
              height: 36,
              width: 36,
              child: FloatingActionButton(
                onPressed: toggleChildren,
                backgroundColor: _appTheme.primaryColor,
                child: Center(child: SvgPicture.asset(SvgImages.iconCall)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),bottomLeft: Radius.circular(8.0))
                ),
              ),
            ),
          );
ElevatedButton(
            onPressed: toggleChildren,
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[900],
              padding: const EdgeInsets.symmetric(
                  horizontal: 22, vertical: 18),
            ),

            child: const Text(
              "Custom Dial Root",
              style: TextStyle(fontSize: 17),
            ),
          );

        }
          ,
        buttonSize:
        buttonSize, // it's the SpeedDial size which defaults to 56 itself
        // iconTheme: IconThemeData(size: 22),
        label: extend
            ? const Text("Open")
            : null, // The label of the main button.
        /// The active label of the main button, Defaults to label if not specified.
        activeLabel: extend ? const Text("Close") : null,

        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the SpeedDial childrens size
        childrenButtonSize: childrenButtonSize,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,

        /// If true user is forced to close dial manually
        closeManually: closeManually,

        /// If false, backgroundOverlay will not be rendered.
        renderOverlay: renderOverlay,
        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        animationDuration: const Duration(milliseconds: 1500),
        shape: const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmicons ? Center(child: SvgPicture.asset(SvgImages.iconCall)) : null,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            label: 'Raise a ticket',
            labelBackgroundColor: _appTheme.speedDialLabelBgLT,
            onTap: () => setState(() => rmicons = !rmicons),
            //onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: !rmicons ? Center(child: SvgPicture.asset(SvgImages.iconCall)) : null,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            label: 'Request a callback',
            onTap: () => debugPrint('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: !rmicons ? Center(child: SvgPicture.asset(SvgImages.iconCall)) : null,
            backgroundColor: _appTheme.primaryColor,
            foregroundColor: Colors.white,
            label: 'Call',
            visible: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(("Third Child Pressed")))),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
*//*
StreamBuilder(
        stream: _bloc.mainStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Container();
        },
      ),
*//*

    );
  }*/
}

class CustomFloatingActionButtonLocation implements FloatingActionButtonLocation {
  final double x;
  final double y;
  const CustomFloatingActionButtonLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);

  }
}
