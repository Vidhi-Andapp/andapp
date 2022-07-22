import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/enum/font_type.dart';
import 'package:andapp/screen/nav_bar.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();
  int groupValue = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final StepperType _type = StepperType.vertical;

  List<Tuple3> tuples = const [
    Tuple3(Icons.add, StringUtils.accCreated, StepState.complete,),
    Tuple3(Icons.add, StringUtils.pospReg, StepState.editing,),
    Tuple3(Icons.add, StringUtils.training, StepState.disabled,),
    Tuple3(Icons.add, StringUtils.startEarning, StepState.disabled,),
  ];

  final int _index = 2;

  Widget pospReg(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(width: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.kycDetails)),
            //const SizedBox(width: 56,),
            SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(width: 10,),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.acDetails)),
            //const SizedBox(width: 28,),
            SvgPicture.asset(SvgImages.iconReject, height: 20, width: 20),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
          child: PinkBorderButton(
            isEnabled: true,
            content: "Re-Fill",
            onPressed: () {
              /*   final form = sendOTPKey
                        .currentState;*/
              /* if (form?.validate() ?? false) {
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
                    }*/
            },),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(width: 10,),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.bankDetails)),
            //const SizedBox(width: 42,),
            SvgPicture.asset(SvgImages.iconPending, height: 30, width: 30),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(width: 10,),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.academicDetails)),
            //const SizedBox(width: 14),
            SvgPicture.asset(SvgImages.iconPending, height: 30, width: 30),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(width: 10,),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.iibApproved)),
            SvgPicture.asset(SvgImages.iconPending, height: 30, width: 30),
          ],
        ),
      ],
    );
  }

  Widget training(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
                const SizedBox(width: 10,),
                const Text(StringUtils.generalInsurance,style: TextStyle(fontSize: 15),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day1),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day2),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day3),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
              child: PinkBorderButton(
                isEnabled: true,
                content: "Start Exam",
                onPressed: () {
                    /* final form = sendOTPKey
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
                        }*/
                },),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
                const SizedBox(width: 10,),
                const Text(StringUtils.lifeInsurance,style: TextStyle(fontSize: 15),),
              ],
            ),
            const SizedBox(height: 10,),
            /*
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day1),
              ],
            ),
            const SizedBox(height: 10,),
           Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day2),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                SvgPicture.asset(SvgImages.iconApprove, height: 16, width: 16),
                const SizedBox(width: 10,),
                const Text(StringUtils.day3),
              ],
            ),
            const SizedBox(height: 10,),*/
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
              child: PinkBorderButton(
                isEnabled: true,
                content: "Start Course",
                onPressed: () {
                  /* final form = sendOTPKey
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
                        }*/
                },),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStepperCustom(BuildContext context) {
    return EnhanceStepper(
        stepIconSize: 30,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: _index,
        physics: const ClampingScrollPhysics(),
        steps: tuples.map((e) =>
            EnhanceStep(
              icon:
              e.item3 == StepState.complete ?
              SvgPicture.asset(
                  SvgImages.dashboardCompleted, height: 40, width: 40)
                  :
              SvgPicture.asset(
                  SvgImages.dashboardPending, height: 40, width: 40),
              state: StepState.values[tuples.indexOf(e)],
              isActive: _index == tuples.indexOf(e),
              title: Text(e.item2.toString(), style: TextStyle(fontSize: 18,
                  fontWeight: FontType.getFontWeightType(
                      FontWeightType.medium)),),
              //subtitle: Text(e.item2.toString().split(".").last,),
              content: _index == 1 ? pospReg(context) : _index == 2 ? training(context) : Container(),
            )).toList(),
        onStepCancel: () {
          //go(-1);
        },
        onStepContinue: () {
          //go(1);
        },
        onStepTapped: (index) {
          // ddlog(index);
         /* setState(() {
            _index = index;
          });*/
        },
        controlsBuilder: (BuildContext context, ControlsDetails controlsDetails,
            { VoidCallback? onStepContinue, VoidCallback? onStepCancel }) {
          return Container();
          /*Row(
            children: [
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: onStepContinue,
                child: const Text("Next"),
              ),
              const SizedBox(width: 8,),
              TextButton(
                onPressed: onStepCancel,
                child: const Text("Back"),
              ),
            ],
          );*/
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Dashboard", textAlign: TextAlign.left
                , style: Theme
                    .of(context)
                    .appBarTheme
                    .titleTextStyle,),
            ),
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
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  iconSize: 30,
                  tooltip: MaterialLocalizations
                      .of(context)
                      .showMenuTooltip,
                );
              },)
        ),
        //backgroundColor: const Color(0xff222222),
        drawer: const NavBar(),
        body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Welcome!",
                            style: TextStyle(fontSize: 25,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Text(
                              "Complete the following steps to become a PoSP advisor with AndApp",
                              style: TextStyle(fontSize: 17,
                                  fontWeight: FontType.getFontWeightType(
                                      FontWeightType.regular)),
                              maxLines: 3,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 24,),
                        Container(
                          decoration: BoxDecoration(
                              color: AppThemeState().greyColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(18.0),
                                  topLeft: Radius.circular(18.0)),
                          boxShadow: [
                            BoxShadow(
                              color: AppThemeState().separatorColor,
                              spreadRadius: 2,
                              blurRadius: 2,
                              //offset: Offset(0, 0),
                            )
                          ]),
                          child: Container(
                            //elevation: 2,
                            margin: const EdgeInsetsDirectional.only(start: 1, end: 1, top: 1),
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18.0),
                                topRight: Radius.circular(18.0),
                              ),// BorderRadius

                            ),
                              /*shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white, width: 0.8),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(18.0),
                                    topLeft: Radius.circular(18.0))),*/

                            //Wrap with IntrinsicHeight
                            child:
                            buildStepperCustom(context),
                          ),
                        ),
                      ]),
                ),
              );
            }
        ),
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
