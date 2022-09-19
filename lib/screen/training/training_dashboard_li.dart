import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/custom_expansion.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/model/get_dashboard.dart';
import 'package:andapp/screen/dashboard/dashboard_bloc.dart';
import 'package:andapp/screen/nav_bar.dart';
import 'package:andapp/screen/training/training_day.dart';
import 'package:andapp/screen/training/training_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/*void main() => runApp(const MaterialApp(home: TrainingDashboard()));*/

class TrainingDashboardLI extends StatefulWidget {
  final String pospId;

  const TrainingDashboardLI({Key? key, required this.pospId}) : super(key: key);

  @override
  State<TrainingDashboardLI> createState() => _TrainingDashboardLIState();
}

class _TrainingDashboardLIState extends State<TrainingDashboardLI>
    with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  int groupValue = 0, module = 3, hours = 15, video = 6;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool expandedCourse = false, expandedCourseWorks = false;

  @override
  void initState() {
    super.initState();
    bloc.getDashboard(context, widget.pospId);
    //bloc.downloadCertificate(context);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                StringUtils.lifeInsurance,
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
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
                      var training = snapshot.data?.data?.training;
                      DateTime now = DateTime.now();
                      bool allowLiDay = false;
                      var liTime = training?.lifeInsurance?.latestTime;
                      String liDay = "";
                      if (liTime != null && liTime.isNotEmpty) {
                        DateTime liDate =
                            DateFormat(StringUtils.dateFormat).parse(liTime);
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 160,
                                width: 400,
                                //2 * getProportionateScreenWidth(200),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: CircularPercentIndicator(
                                    radius: 120,
                                    //getProportionateScreenWidth(200),
                                    lineWidth: 16,
                                    animation: true,
                                    arcType: ArcType.HALF,
                                    curve: Curves.easeInOutCubicEmphasized,
                                    percent: liDay == "1"
                                        ? 0.0
                                        : liDay == "2"
                                            ? 0.33
                                            : liDay == "3"
                                                ? 0.67
                                                : 1.00,
                                    arcBackgroundColor: Colors.white,
                                    startAngle: 0,
                                    //widgetIndicator: Container(color: Colors.red,height: 10,),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: AppThemeState().primaryColor,
                                    center: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        (liDay == "1"
                                            ? '0.0%'
                                            : liDay == "2"
                                                ? '33.33%'
                                                : liDay == "3"
                                                    ? '66.67%'
                                                    : '100%'),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      //width: (MediaQuery.of(context).size.width - 42) / 2,
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shadows: [
                                            BoxShadow(
                                              offset: const Offset(3.5, 3.5),
                                              blurRadius: 4,
                                              color: appTheme
                                                  .trainingCardShadowColor,
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              side: BorderSide(
                                                  color: appTheme
                                                      .trainingCardBorderColor,
                                                  width: 1)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: ShapeDecoration(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      // <-- SEE HERE
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            16.0),
                                                      ),
                                                    ),
                                                    color: appTheme
                                                        .trainingCardBgColor),
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                    'Course Details',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 16, 16, 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconBar,
                                                        color: appTheme
                                                            .primaryColor,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        "Modules : $module",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.color,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconClock,
                                                        color: appTheme
                                                            .primaryColor,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        "Hours : $hours",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.color,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconVideo,
                                                        color: appTheme
                                                            .primaryColor,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        "Videos : $video",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.color,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      //width: (MediaQuery.of(context).size.width - 42) / 2,
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shadows: [
                                            BoxShadow(
                                              offset: const Offset(3.5, 3.50),
                                              blurRadius: 4,
                                              color: appTheme
                                                  .trainingCardShadowColor,
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              side: BorderSide(
                                                  color: appTheme
                                                      .trainingCardBorderColor,
                                                  width: 1)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: ShapeDecoration(
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      // <-- SEE HERE
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            16.0),
                                                      ),
                                                    ),
                                                    color: appTheme
                                                        .trainingCardBgColor),
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                    'Course Details',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 16, 16, 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconApprove,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        StringUtils
                                                            .videoTutorials,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.color,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconApprove,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        StringUtils
                                                            .unlimitedAccess,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                ?.color,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        SvgImages.iconApprove,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          StringUtils
                                                              .recognisedCertification,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.color,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CustomExpansionPanelList(
                                  key: const ValueKey<int>(1),
                                  animationDuration:
                                      const Duration(milliseconds: 2000),
                                  children: [
                                    CustomExpansionPanel(
                                      backgroundColor:
                                          appTheme.trainingCardBgColor,
                                      hasIcon: true,
                                      headerBuilder: (context, isExpanded) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(16),
                                            decoration: const ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: const [
                                                Text(StringUtils.abtThisCourse,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ));
                                      },
                                      body: Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(16),
                                          decoration: ShapeDecoration(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                              color:
                                                  appTheme.trainingCardBgColor),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            StringUtils.abtThisCourseContentLI,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                            maxLines: 15,
                                          )),
                                      isExpanded: expandedCourse,
                                      canTapOnHeader: true,
                                    ),
                                  ],
                                  dividerColor: Colors.grey,
                                  expansionCallback: (panelIndex, isExpanded) {
                                    expandedCourse = !expandedCourse;
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CustomExpansionPanelList(
                                  key: const ValueKey<int>(2),
                                  animationDuration:
                                      const Duration(milliseconds: 2000),
                                  children: [
                                    CustomExpansionPanel(
                                      backgroundColor:
                                          appTheme.trainingCardBgColor,
                                      hasIcon: true,
                                      headerBuilder: (context, isExpanded) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(16),
                                            decoration: const ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: const [
                                                Text(StringUtils.howItWorks,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ],
                                            ));
                                      },
                                      body: Container(
                                          //height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(16),
                                          decoration: ShapeDecoration(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                // <-- SEE HERE
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0),
                                                ),
                                              ),
                                              color:
                                                  appTheme.trainingCardBgColor),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            StringUtils.howItWorksGI,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                            maxLines: 15,
                                          )),
                                      isExpanded: expandedCourseWorks,
                                      canTapOnHeader: true,
                                    ),
                                  ],
                                  dividerColor: Colors.grey,
                                  expansionCallback: (panelIndex, isExpanded) {
                                    expandedCourseWorks = !expandedCourseWorks;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: PinkBorderButton(
                                  isEnabled: true,
                                  content: liDay.isNotEmpty
                                      ? "Start Day $liDay"
                                      : "Start Exam",
                                  onPressed: () {
                                    if (liDay.isNotEmpty) {
                                      if (allowLiDay) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return TrainingDays(
                                                title:
                                                    StringUtils.lifeInsurance,
                                                day: liDay);
                                          }),
                                        ).then((value) => bloc.getDashboard(
                                            context, widget.pospId));
                                      } else {
                                        CommonToast.getInstance()?.displayToast(
                                            message:
                                                StringUtils.trainingDayMsg);
                                      }
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return const TrainingExam(
                                              title: StringUtils.lifeInsurance);
                                        }),
                                      ).then((value) => bloc.getDashboard(
                                          context, widget.pospId));
                                    }
                                  },
                                ),
                              ),
                            ]),
                      );
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