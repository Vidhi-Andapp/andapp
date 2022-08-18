import 'package:andapp/common/app_theme.dart';
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

import '../../common/common_toast.dart';

/*void main() => runApp(const MaterialApp(home: TrainingDashboard()));*/

class TrainingDashboardGI extends StatefulWidget {
  final String pospId;

  const TrainingDashboardGI({Key? key, required this.pospId}) : super(key: key);

  @override
  State<TrainingDashboardGI> createState() => _TrainingDashboardGIState();
}

class _TrainingDashboardGIState extends State<TrainingDashboardGI>
    with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc();
  int groupValue = 0, module = 3;
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
                StringUtils.generalInsurance,
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
                      var training = snapshot.data?.data?.training;
                      var giTime = training?.generalInsurance?.latestTime;
                      DateTime now = DateTime.now();
                      String giDay = "";
                      bool allowGIDay = false;
                      if (giTime != null && giTime.isNotEmpty) {
                        DateTime giDate =
                            DateFormat("MM/dd/yyyy hh:mm:ss").parse(giTime);
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
                                    percent: giDay == "1"
                                        ? 0.0
                                        : giDay == "2"
                                            ? 0.33
                                            : giDay == "3"
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
                                        (giDay == "1"
                                            ? '0.0%'
                                            : giDay == "2"
                                                ? '33.33%'
                                                : giDay == "3"
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
                                      //flex: 1,
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
                                                        "Hours : $module",
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
                                                        "Videos : $module",
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
                                      //flex: 1,
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
                                                        "Video Tutorials",
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
                                                        "Unlimited Access",
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
                                                          "Recognised Certificate",
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
                                                Text('About This Course',
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
                                            'iAND Insurance Broker Private Limited, a company incorporated under the provisions of Companies Act, 2013 and having its principal place of business at 1106, 11th floor, D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009 (herein after referred to as “the Company”, which expression shall D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009',
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
                                                Text('How does it work?',
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
                                            'iAND Insurance Broker Private Limited, a company incorporated under the provisions of Companies Act, 2013 and having its principal place of business at 1106, 11th floor, D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009 (herein after referred to as “the Company”, which expression shall D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009 iAND Insurance Broker Private Limited, a company incorporated under the provisions of Companies Act, 2013 and having its principal place of business at 1106, 11th floor, D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009 (herein after referred to as “the Company”, which expression shall D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009',
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
                                  content: giDay.isNotEmpty
                                      ? "Start Day $giDay"
                                      : "Start Exam",
                                  onPressed: () {
                                    if (giDay.isNotEmpty) {
                                      if (allowGIDay) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return TrainingDays(
                                                title: StringUtils
                                                    .generalInsurance,
                                                day: giDay);
                                          }),
                                        );
                                      } else {
                                        CommonToast.getInstance()?.displayToast(
                                            message:
                                                StringUtils.trainingDayMsg);
                                      }
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return const TrainingExam(
                                              title:
                                                  StringUtils.generalInsurance);
                                        }),
                                      );
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