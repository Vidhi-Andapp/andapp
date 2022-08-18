import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/enum/font_type.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/screen/dashboard/dashboard_bloc.dart';
import 'package:andapp/screen/nav_bar.dart';
import 'package:andapp/screen/registration/posp_registration.dart';
import 'package:andapp/screen/training/training_dashboard_gi.dart';
import 'package:andapp/screen/training/training_dashboard_li.dart';
import 'package:andapp/screen/training/training_day.dart';
import 'package:andapp/screen/training/training_exam.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class Dashboard extends StatefulWidget {
  final String pospId;

  const Dashboard({Key? key, required this.pospId}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  int groupValue = 0;
  int? index;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StepperType _type = StepperType.vertical;

  @override
  void initState() {
    super.initState();
    bloc.getDashboard(context, widget.pospId);
    //bloc.downloadCertificate(context);
  }

  List<Tuple3> tuples = const [
    Tuple3(
      Icons.add,
      StringUtils.accCreated,
      StepState.complete,
    ),
    Tuple3(
      Icons.add,
      StringUtils.pospReg,
      StepState.editing,
    ),
    Tuple3(
      Icons.add,
      StringUtils.training,
      StepState.disabled,
    ),
    Tuple3(
      Icons.add,
      StringUtils.startEarning,
      StepState.disabled,
    ),
  ];

  Widget pospReg(BuildContext context, GetDashboardData? dashboardData) {
    var pospData = dashboardData?.data?.pospRegistration;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.kycDetails)),
            //const SizedBox(width: 56,),

            SvgPicture.asset(
                pospData?.kycDetail == "approve"
                    ? SvgImages.iconApprove
                    : pospData?.kycDetail == "reject"
                        ? SvgImages.iconReject
                        : SvgImages.iconPending,
                height: 16,
                width: 16),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.acDetails)),
            //const SizedBox(width: 28,),
            SvgPicture.asset(
                (pospData?.panDetail == "approve" &&
                        pospData?.gstDetail == "approve")
                    ? SvgImages.iconApprove
                    : ((pospData?.panDetail == "reject" &&
                            pospData?.gstDetail == "reject"))
                        ? SvgImages.iconReject
                        : SvgImages.iconPending,
                height: 16,
                width: 16),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
          child: PinkBorderButton(
            isEnabled: true,
            content: "Re-Fill",
            onPressed: () {
              MaterialPageRoute(builder: (context) {
                return const PoSPRegistration();
              });
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.bankDetails)),
            //const SizedBox(width: 42,),
            SvgPicture.asset(
                pospData?.bankDetail == "approve"
                    ? SvgImages.iconApprove
                    : pospData?.kycDetail == "reject"
                        ? SvgImages.iconReject
                        : SvgImages.iconPending,
                height: 16,
                width: 16),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.academicDetails)),
            //const SizedBox(width: 14),
            SvgPicture.asset(
                pospData?.kycDetail == "approve"
                    ? SvgImages.iconApprove
                    : pospData?.academicDetail == "reject"
                        ? SvgImages.iconReject
                        : SvgImages.iconPending,
                height: 16,
                width: 16),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(SvgImages.dashboardBullet, height: 6, width: 6),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Text(StringUtils.iibApproved)),
            SvgPicture.asset(SvgImages.iconPending, height: 30, width: 30),
          ],
        ),
      ],
    );
  }

  Widget training(BuildContext context, GetDashboardData? dashboardData) {
    var training = dashboardData?.data?.training;
    var giTime = training?.generalInsurance?.latestTime;
    DateTime now = DateTime.now();
    String giDay = "", giExam = "Start Exam", liExam = "Start Exam";
    bool allowGIDay = false, allowLiDay = false;
    if (giTime != null && giTime.isNotEmpty) {
      DateTime giDate = DateFormat("MM/dd/yyyy hh:mm:ss").parse(giTime);
      if (now.day - giDate.day >= 1) {
        allowGIDay = true;
      }
      training?.generalInsurance?.day1 == "false"
          ? giDay = "1"
          : training?.generalInsurance?.day2 == "false"
              ? giDay = "2"
              : training?.generalInsurance?.day3 == "false"
                  ? giDay = "3"
                  : giDay = "";
    } else {
      allowGIDay = true;
      giDay = "1";
    }
    if (training?.generalInsurance?.exam == "true") {
      giExam = StringUtils.downloadCertificate;
    } else if (training?.generalInsurance?.exam == "false") {
      giExam = StringUtils.reExam;
    }

    var liTime = training?.lifeInsurance?.latestTime;
    String liDay = "";
    if (liTime != null && liTime.isNotEmpty) {
      DateTime liDate = DateFormat("MM/dd/yyyy hh:mm:ss").parse(liTime);
      if (now.day - liDate.day >= 1) {
        allowLiDay = true;
      }
      training?.lifeInsurance?.day1 == "false"
          ? liDay = "1"
          : training?.lifeInsurance?.day2 == "false"
              ? liDay = "2"
              : training?.lifeInsurance?.day3 == "false"
                  ? liDay = "3"
                  : liDay = "";
    } else {
      allowLiDay = true;
      liDay = "1";
    }
    if (training?.lifeInsurance?.exam == "true") {
      liExam = StringUtils.downloadCertificate;
    } else if (training?.lifeInsurance?.exam == "false") {
      liExam = StringUtils.reExam;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(SvgImages.dashboardBullet,
                    height: 6, width: 6),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  StringUtils.generalInsurance,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            training?.generalInsurance?.day1 == "true"
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(SvgImages.iconApprove,
                                height: 16, width: 16),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(StringUtils.day1),
                          ],
                        ),
                      ),
                      training?.generalInsurance?.day2 == "true"
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SvgPicture.asset(SvgImages.iconApprove,
                                          height: 16, width: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(StringUtils.day2),
                                    ],
                                  ),
                                ),
                                training?.generalInsurance?.day3 == "true"
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SvgPicture.asset(
                                                SvgImages.iconApprove,
                                                height: 16,
                                                width: 16),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(StringUtils.day3),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                    ],
                  )
                : Container(),
            giDay == "1"
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
                    child: PinkBorderButton(
                      isEnabled: true,
                      content: "Start Course",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TrainingDashboardGI(
                              pospId: widget.pospId,
                            );
                          }),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
                    child: PinkBorderButton(
                      isEnabled: true,
                      content: giDay.isNotEmpty ? "Start Day $giDay" : giExam,
                      onPressed: () {
                        if (giDay.isNotEmpty) {
                          if (allowGIDay) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return TrainingDays(
                                    title: StringUtils.generalInsurance,
                                    day: giDay);
                              }),
                            );
                          } else {
                            CommonToast.getInstance()?.displayToast(
                                message: StringUtils.trainingDayMsg);
                          }
                        } else {
                          if (giExam == StringUtils.downloadCertificate) {
                            bloc.downloadCertificate(context, widget.pospId,
                                StringUtils.generalInsurance);
                          } else if (giExam == StringUtils.reExam) {
                            bloc
                                .reExam(context, widget.pospId,
                                    StringUtils.generalInsurance)
                                .then((value) {
                              if (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const TrainingExam(
                                        title: StringUtils.generalInsurance);
                                  }),
                                );
                              }
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const TrainingExam(
                                    title: StringUtils.generalInsurance);
                              }),
                            );
                          }
                        }
                      },
                    ),
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
                SvgPicture.asset(SvgImages.dashboardBullet,
                    height: 6, width: 6),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  StringUtils.lifeInsurance,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            training?.lifeInsurance?.day1 == "true"
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(SvgImages.iconApprove,
                                height: 16, width: 16),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(StringUtils.day1),
                          ],
                        ),
                      ),
                      training?.lifeInsurance?.day2 == "true"
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SvgPicture.asset(SvgImages.iconApprove,
                                          height: 16, width: 16),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(StringUtils.day2),
                                    ],
                                  ),
                                ),
                                training?.lifeInsurance?.day3 == "true"
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SvgPicture.asset(
                                                SvgImages.iconApprove,
                                                height: 16,
                                                width: 16),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(StringUtils.day3),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          : Container(),
                    ],
                  )
                : Container(),
            liDay == "1"
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
                    child: PinkBorderButton(
                      isEnabled: true,
                      content: "Start Course",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return TrainingDashboardLI(
                              pospId: widget.pospId,
                            );
                          }),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 4.0, bottom: 8),
                    child: PinkBorderButton(
                      isEnabled: true,
                      content: liDay.isNotEmpty ? "Start Day $liDay" : liExam,
                      onPressed: () {
                        if (liDay.isNotEmpty) {
                          if (allowLiDay) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return TrainingDays(
                                    title: StringUtils.lifeInsurance,
                                    day: liDay);
                              }),
                            );
                          } else {
                            CommonToast.getInstance()?.displayToast(
                                message: StringUtils.trainingDayMsg);
                          }
                        } else {
                          if (liExam == StringUtils.downloadCertificate) {
                            bloc.downloadCertificate(context, widget.pospId,
                                StringUtils.lifeInsurance);
                          } else if (liExam == StringUtils.reExam) {
                            bloc
                                .reExam(context, widget.pospId,
                                    StringUtils.lifeInsurance)
                                .then((value) {
                              if (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const TrainingExam(
                                        title: StringUtils.lifeInsurance);
                                  }),
                                );
                              }
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const TrainingExam(
                                    title: StringUtils.lifeInsurance);
                              }),
                            );
                          }
                        }
                      },
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Widget buildStepperCustom(
      BuildContext context, GetDashboardData? dashboardData) {
    return EnhanceStepper(
        stepIconSize: 30,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: index ?? 1,
        physics: const ClampingScrollPhysics(),
        steps: tuples
            .map((e) => EnhanceStep(
                  icon: e.item3 == StepState.complete
                      ? SvgPicture.asset(SvgImages.dashboardCompleted,
                          height: 40, width: 40)
                      : SvgPicture.asset(SvgImages.dashboardPending,
                          height: 40, width: 40),
                  state: StepState.values[tuples.indexOf(e)],
                  isActive: index == tuples.indexOf(e),
                  title: Text(
                    e.item2.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1!.color,
                        fontWeight:
                            FontType.getFontWeightType(FontWeightType.medium)),
                  ),
                  //subtitle: Text(e.item2.toString().split(".").last,),
                  content: index == 1
                      ? pospReg(context, dashboardData)
                      : index == 2
                          ? training(context, dashboardData)
                          : Container(),
                ))
            .toList(),
        onStepCancel: () {
          //go(-1);
        },
        onStepContinue: () {
          //go(1);
        },
        onStepTapped: (index) {},
        controlsBuilder: (BuildContext context, ControlsDetails controlsDetails,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Dashboard",
                textAlign: TextAlign.left,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            // give the app bar rounded corners
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  iconSize: 30,
                  tooltip: MaterialLocalizations.of(context).showMenuTooltip,
                );
              },
            )),
        //backgroundColor: const Color(0xff222222),
        drawer: const NavBar(),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: StreamBuilder<GetDashboardData>(
                  stream: bloc.dashboardStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<GetDashboardData> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      var dashboardData = snapshot.data;
                      if (dashboardData?.data?.trainingStatus == "true") {
                        index = 3;
                      } else if (dashboardData?.data?.pospRegistrationStatus ==
                          "true") {
                        index = 2;
                      } else {
                        index = 1;
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    StringUtils.welcome,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(StringUtils.dashboardTitle,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight:
                                              FontType.getFontWeightType(
                                                  FontWeightType.regular)),
                                      maxLines: 3,
                                      textAlign: TextAlign.center),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
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
                                margin: const EdgeInsetsDirectional.only(
                                    start: 1, end: 1, top: 1),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18.0),
                                    topRight: Radius.circular(18.0),
                                  ), // BorderRadius
                                ),
                                //Wrap with IntrinsicHeight
                                child:
                                    buildStepperCustom(context, dashboardData),
                                /*StreamBuilder(
                                    stream: bloc.resultStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        DownloadCertificate dc = snapshot.data
                                            as DownloadCertificate;
                                        return getImagenBase64(
                                            dc.data?.data?.image ?? "");
                                      }
                                      return Container();
                                    }),*/
                              ),
                            ),
                          ]);
                    }
                    return Container();
                  }),
            ),
          );
        }),
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