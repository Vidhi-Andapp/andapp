import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/model/submit_answer.dart';
import 'package:andapp/screen/training/training_result_bloc.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrainingResult extends StatefulWidget {
  final String title;
  final AnswerData? answerData;
  const TrainingResult({Key? key,required this.title,@required this.answerData}) : super(key: key);
  @override
  State<TrainingResult> createState() => _TrainingResultState();
}

class _TrainingResultState extends State<TrainingResult> {
  final TrainingResultBloc bloc = TrainingResultBloc();

  @override
  Widget build(BuildContext context) {
    double percent = 0.0;
    if (widget.answerData != null && widget.answerData?.percentage != null) {
      percent =
          double.parse(widget.answerData!.percentage!.replaceAll("%", "")) /
              100;
    }

    final appTheme = AppTheme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.title, textAlign: TextAlign.left
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
                  Navigator.of(context).pop();
                },
                iconSize: 30,
                tooltip: MaterialLocalizations
                    .of(context)
                    .showMenuTooltip,
              );
            },)
      ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child:
        (widget.answerData != null) ?
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: CircularPercentIndicator(
                  radius: 100,
                  //getProportionateScreenWidth(200),
                  lineWidth: 16,
                  animation: true,
                  //arcType: ArcType.FULL,
                  //curve: Curves.easeInOutCubicEmphasized,
                  percent: percent,
                  //arcBackgroundColor: Colors.white,
                  //startAngle: 0,
                  //widgetIndicator: Container(color: Colors.red,height: 10,),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppThemeState().primaryColor,
                  center: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${widget.answerData?.percentage}',
                      style: TextStyle(
                          fontSize: 34,
                          color:  widget.answerData?.result?.toLowerCase() == StringUtils.pass
                              ? appTheme.trainingResultTextColor : appTheme.trainingResultFailTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 48.0, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 24,),
                    Text(
                        widget.answerData?.result?.toLowerCase() ==
                            StringUtils.pass
                            ? StringUtils.trainingSuccessTitle
                            : StringUtils.trainingFailTitle,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 20,),
                    Text(
                        widget.answerData?.result?.toLowerCase() ==
                            StringUtils.pass ? StringUtils.trainingSuccessMessage
                            : StringUtils.trainingFailMessage,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(height: 32,),
                    PinkBorderButton(
                      isEnabled: true,
                      content: widget.answerData?.result?.toLowerCase() ==
                          StringUtils.pass ? StringUtils.downloadCertificate
                          : StringUtils.reExam,
                      onPressed: () {

                      },),
                  ],
                ),
              ),
              const SizedBox(height: 32,),
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    Container(
                        height: 140,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.symmetric(horizontal : 32),
                        decoration: ShapeDecoration(
                            shadows: [
                              BoxShadow(
                                offset: const Offset(3.5, 3.50),
                                blurRadius: 4,
                                color: appTheme
                                    .trainingResultQueBorderColor,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                      16.0),
                                  topRight: Radius.circular(
                                      16.0),
                                ),
                                side: BorderSide(
                                    width: 4,
                                    color: appTheme.trainingResultQueBgColor
                                )
                            ),
                            color: appTheme
                                .trainingResultAnsBgColor),
                        alignment: Alignment
                            .center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                StringUtils.totalQue,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                  elevation: 0.0,
                                  heroTag: UniqueKey(),
                                  backgroundColor: appTheme
                                      .primaryColor,
                                  onPressed: () {},
                                  shape: CircleBorder(
                                      side: BorderSide(width: 2,
                                        color: appTheme.primaryColor,)),
                                  child: Center(
                                      child: Text("${widget.answerData
                                          ?.totalQuestions}", style:
                                      const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),))
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 138.0),
                      child: Container(
                          height: 140,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.symmetric(horizontal : 32),
                          decoration: ShapeDecoration(
                              shadows: [
                                BoxShadow(
                                  offset: const Offset(3.5, 3.50),
                                  blurRadius: 4,
                                  color: appTheme
                                      .trainingResultQueBorderColor,
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius
                                      .vertical(
                                    top: Radius.circular(16.0),
                                  ),
                                  side: BorderSide(
                                      width: 2,
                                      color: appTheme.trainingResultQueBgColor
                                  )
                              ),
                              color: appTheme
                                  .trainingResultAnsBgColor),
                          alignment: Alignment
                              .center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                  StringUtils.totalAns,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                    elevation: 0.0,
                                    heroTag: UniqueKey(),
                                    backgroundColor: appTheme
                                        .primaryColor,
                                    onPressed: () {},
                                    shape: CircleBorder(
                                        side: BorderSide(width: 2,
                                          color: appTheme.primaryColor,)),
                                    child: Center(
                                        child: Text("${widget.answerData
                                            ?.totalCorrectAnswer}", style:
                                        const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),))
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) :
        Container(),
      ),
    );
  }
/*
  ListView questionList() {
    return ListView.builder(
      itemCount: results?.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        elevation: 0.0,
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  results?[index].question,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(results?[index].category),
                        onSelected: (b) {},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(
                          results?[index].difficulty,
                        ),
                        onSelected: (b) {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Text((results?[index].type ?? "").startsWith("m") ? "M" : "B"),
          ),
          children: results![index].allAnswers.map((m) {
            return AnswerWidget(results!, index, m);
          }).toList(),
        ),
      ),
    );
  }*/
}

