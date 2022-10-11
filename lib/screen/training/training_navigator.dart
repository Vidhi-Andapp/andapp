import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/nav_bar.dart';
import 'package:andapp/screen/training/training_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainingNavigator extends StatefulWidget {
  final String title;
  final String day;
  final String pospId;

  const TrainingNavigator({Key? key, required this.title,required this.pospId, required this.day})
      : super(key: key);

  @override
  State<TrainingNavigator> createState() => _TrainingNavigatorState();
}

class _TrainingNavigatorState extends State<TrainingNavigator>
    with TickerProviderStateMixin {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool day1 = false, day2 = false, day3 = false;

  @override
  Widget build(BuildContext context) {
    if (widget.day == "1") {
      day1 = true;
    } else if (widget.day == "2") {
      day1 = true;
      day2 = true;
    } else if (widget.day == "3") {
      day1 = true;
      day2 = true;
      day3 = true;
    }
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
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
                    Navigator.pop(context);
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      side: BorderSide(
                                          color: day1
                                              ? appTheme.primaryColor
                                              : Colors.white)),
                                  color: Colors.transparent),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(StringUtils.day1Title,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  day1
                                      ? SvgPicture.asset(
                                          SvgImages.dashboardCompleted,
                                          height: 24,
                                          width: 24,
                                          alignment: Alignment.topRight,
                                        )
                                      : const SizedBox(
                                          width: 20,
                                        ),
                                ],
                              )),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      side: BorderSide(
                                          color: day2
                                              ? appTheme.primaryColor
                                              : Colors.white)),
                                  color: Colors.transparent),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(StringUtils.day2Title,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  day2
                                      ? SvgPicture.asset(
                                          SvgImages.dashboardCompleted,
                                          height: 24,
                                          width: 24,
                                          alignment: Alignment.topRight,
                                        )
                                      : const SizedBox(
                                          width: 20,
                                        ),
                                ],
                              )),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      side: BorderSide(
                                          color: day3
                                              ? appTheme.primaryColor
                                              : Colors.white)),
                                  color: Colors.transparent),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(StringUtils.day3Title,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  day3
                                      ? SvgPicture.asset(
                                          SvgImages.dashboardCompleted,
                                          height: 24,
                                          width: 24,
                                          alignment: Alignment.topRight,
                                        )
                                      : const SizedBox(
                                          width: 20,
                                        ),
                                ],
                              )),
                          //const SizedBox(height: 200,),
                        ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 48.0, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.trainingResult,
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.topRight,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                    widget.day == "3"
                                        ? StringUtils.trainingDaysSuccessTitle
                                        : StringUtils.trainingSuccessTitle,
                                    style: const TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 20,
                                ),
                                widget.day == "1"
                                    ? const Text(
                                        StringUtils.trainingDay1CompleteSuccess,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300))
                                    : widget.day == "2"
                                        ? const Text(
                                            StringUtils.trainingDay2CompleteSuccess,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300))
                                        : RichText(
                                            text: TextSpan(children: <TextSpan>[
                                              const TextSpan(
                                                  text: StringUtils
                                                      .trainingDay3CompleteSuccess1,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w300)),
                                              TextSpan(
                                                  text: StringUtils
                                                      .trainingDay3CompleteSuccess2,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppTheme.of(context)
                                                          .primaryColor,
                                                      fontWeight: FontWeight.w300)),
                                              const TextSpan(
                                                  text: StringUtils
                                                      .trainingDay3CompleteSuccess3,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w300)),
                                            ]),
                                            textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                        (widget.day == "3")?
                        Center(
                          //padding: const EdgeInsets.all(16),
                          child: PinkBorderButton(
                            isEnabled: true,
                            content: "Start Exam",
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return TrainingExam(
                                      title: widget.title, pospId: widget.pospId,);
                                }),
                              );
                            },
                          ),
                        ):
                        Container(),
                      ],
                    ),
                  ],
                ),
              ),
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