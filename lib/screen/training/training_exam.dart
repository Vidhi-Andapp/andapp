import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/screen/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainingExam extends StatefulWidget {
  const TrainingExam({Key? key}) : super(key: key);

  @override
  State<TrainingExam> createState() => _TrainingExamState();
}

class _TrainingExamState extends State<TrainingExam> with TickerProviderStateMixin {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool day1 = true,day2 = true,day3 = false;
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text("General Insurance", textAlign: TextAlign.left
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
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets
                                      .all(16),
                                  padding: const EdgeInsets
                                      .symmetric(horizontal: 16,vertical: 8),
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder( // <-- SEE HERE
                                          borderRadius: const BorderRadius
                                              .all(
                                            Radius
                                                .circular(
                                                10.0),
                                          ),
                                          side: BorderSide(color: day1 ? appTheme.primaryColor : Colors.white)
                                      ),
                                      color: Colors.transparent),
                                  alignment: Alignment
                                      .centerLeft,
                                  child:
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                            'Day 1. Basics of Insurance',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      day1 ?
                                      SvgPicture.asset(
                                        SvgImages.dashboardCompleted, height: 24,
                                        width: 24,
                                        alignment: Alignment.topRight,)
                                          : const SizedBox(width: 20,),
                                    ],
                                  )
                              ),
                              Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets
                                      .all(16),
                                  padding: const EdgeInsets
                                      .symmetric(horizontal: 16,vertical: 8),
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder( // <-- SEE HERE
                                          borderRadius: const BorderRadius
                                              .all(
                                            Radius
                                                .circular(
                                                10.0),
                                          ),
                                          side: BorderSide(color: day2 ? appTheme.primaryColor : Colors.white)
                                      ),
                                      color: Colors.transparent),
                                  alignment: Alignment
                                      .centerLeft,
                                  child:
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                            'Day 2. Categories of Insurance',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      day2 ?
                                      SvgPicture.asset(
                                        SvgImages.dashboardCompleted, height: 24,
                                        width: 24,
                                        alignment: Alignment.topRight,)
                                          : const SizedBox(width: 20,),
                                    ],
                                  )
                              ),
                              Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets
                                      .all(16),
                                  padding: const EdgeInsets
                                      .symmetric(horizontal: 16,vertical: 8),
                                  decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder( // <-- SEE HERE
                                          borderRadius: const BorderRadius
                                              .all(
                                            Radius
                                                .circular(
                                                10.0),
                                          ),
                                          side: BorderSide(color: day3 ? appTheme.primaryColor : Colors.white)
                                      ),
                                      color: Colors.transparent),
                                  alignment: Alignment
                                      .centerLeft,
                                  child:
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                            'Day 3. Process for Insurance & Claims',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      day3 ?
                                      SvgPicture.asset(
                                        SvgImages.dashboardCompleted, height: 24,
                                        width: 24,
                                        alignment: Alignment.topRight,)
                                          : const SizedBox(width: 20,),
                                    ],
                                  )
                              ),
                              //const SizedBox(height: 200,),
                            ]),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.trainingResult,
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.topRight,),
                                const SizedBox(height: 24,),
                                const Text(
                                    'Congratulations...!',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20,),
                                const Text(
                                    'Your 1st Day Training was completed. Please come back tomorrow for 2nd Day Training',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
