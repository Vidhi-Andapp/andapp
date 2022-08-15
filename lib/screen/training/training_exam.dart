import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/model/get_question_answer_list.dart';
import 'package:andapp/screen/training/training_exam_bloc.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrainingExam extends StatefulWidget {
  final String title;

  const TrainingExam({Key? key, required this.title}) : super(key: key);

  @override
  State<TrainingExam> createState() => _TrainingExamState();
}

class _TrainingExamState extends State<TrainingExam>
    with TickerProviderStateMixin {
  final TrainingExamBloc bloc = TrainingExamBloc();
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  int current = 0;
  var mItemCount = 10;

  String nextButton = StringUtils.next;

  //AnimationController? animationController;
  //Animation<Offset>? offset;
  //ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    bloc.getQuestions(context, widget.title);
    _pageController.addListener(() {
      setState(() {
        // currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final scrollController =
        ScrollController(initialScrollOffset: current * 50);
    return Scaffold(
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
                  Navigator.of(context).pop();
                },
                iconSize: 30,
                tooltip: MaterialLocalizations.of(context).showMenuTooltip,
              );
            },
          )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: StreamBuilder<List<Question>>(
              stream: bloc.questionStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Question>> snapshot) {
                if (snapshot.hasData) {
                  List<Question> listQuestion = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 96.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: appTheme.primaryColor,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(44)),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 12,
                                );
                              },
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: listQuestion.length,
                              controller: scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                int displayIndex = index + 1;
                                int latestAttemptedIndex = 0;
                                for (int i = 0; i < listQuestion.length; i++) {
                                  if (listQuestion[i].attemptedAns != null) {
                                    latestAttemptedIndex = i;
                                  }
                                }
                                return Transform.scale(
                                  scale: index == current ? 1 : 0.75,
                                  child: FloatingActionButton(
                                      heroTag: null,
                                      elevation: 0.0,
                                      backgroundColor: (index == current ||
                                              listQuestion[index]
                                                      .attemptedAns !=
                                                  null)
                                          ? appTheme.primaryColor
                                          : Colors.transparent,
                                      onPressed: () {
                                        if (kDebugMode) {
                                          print(index);
                                        }
                                        if (index <= current + 1 ||
                                            index <= latestAttemptedIndex + 1) {
                                          selectIndex(index, scrollController);
                                        }
                                      },
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        width: 2,
                                        color: (index <= current ||
                                                listQuestion[index]
                                                        .attemptedAns !=
                                                    null ||
                                                index <= latestAttemptedIndex)
                                            ? appTheme.primaryColor
                                            : Colors.white,
                                      )),
                                      child: Center(
                                          child: Text(
                                        "$displayIndex",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ((index < current ||
                                                        (index <=
                                                                latestAttemptedIndex &&
                                                            index !=
                                                                current)) &&
                                                    listQuestion[index]
                                                            .attemptedAns ==
                                                        null)
                                                ? appTheme.primaryColor
                                                : Colors.white),
                                      ))),
                                );
                              }),
                        ),
                      ),
                      ExpandablePageView.builder(
                        controller: _pageController,
                        itemCount: listQuestion.length,
                        itemBuilder: (context, position) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                  color: appTheme.trainingCardShadowColor,
                                )
                              ],
                              /* border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),*/
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(3.5, 3.5),
                                    blurRadius: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  )
                                ],
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      '${position + 1}. ${listQuestion[position].question}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        listQuestion[current].attemptedAns =
                                            StringUtils.ansA;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.5, 3.5),
                                            blurRadius: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          )
                                        ],
                                        border: Border.all(
                                          width: 1,
                                          color: listQuestion[current]
                                                      .attemptedAns ==
                                                  StringUtils.ansA
                                              ? appTheme.primaryColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            listQuestion[current]
                                                        .attemptedAns ==
                                                    StringUtils.ansA
                                                ? SvgImages.radioSelected
                                                : SvgImages.radioUnSelected,
                                            height: 22,
                                            width: 22,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${listQuestion[position].optionA}',
                                                style: TextStyle(
                                                    color: listQuestion[current]
                                                                .attemptedAns ==
                                                            StringUtils.ansA
                                                        ? appTheme.primaryColor
                                                        : Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        listQuestion[current].attemptedAns =
                                            StringUtils.ansB;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.5, 3.5),
                                            blurRadius: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          )
                                        ],
                                        border: Border.all(
                                          width: 1,
                                          color: listQuestion[current]
                                                      .attemptedAns ==
                                                  StringUtils.ansB
                                              ? appTheme.primaryColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            listQuestion[current]
                                                        .attemptedAns ==
                                                    StringUtils.ansB
                                                ? SvgImages.radioSelected
                                                : SvgImages.radioUnSelected,
                                            height: 22,
                                            width: 22,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${listQuestion[position].optionB}',
                                                style: TextStyle(
                                                    color: listQuestion[current]
                                                                .attemptedAns ==
                                                            StringUtils.ansB
                                                        ? appTheme.primaryColor
                                                        : Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        listQuestion[current].attemptedAns =
                                            StringUtils.ansC;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.5, 3.5),
                                            blurRadius: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          )
                                        ],
                                        border: Border.all(
                                          width: 1,
                                          color: listQuestion[current]
                                                      .attemptedAns ==
                                                  StringUtils.ansC
                                              ? appTheme.primaryColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            listQuestion[current]
                                                        .attemptedAns ==
                                                    StringUtils.ansC
                                                ? SvgImages.radioSelected
                                                : SvgImages.radioUnSelected,
                                            height: 22,
                                            width: 22,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${listQuestion[position].optionC}',
                                                style: TextStyle(
                                                    color: listQuestion[current]
                                                                .attemptedAns ==
                                                            StringUtils.ansC
                                                        ? appTheme.primaryColor
                                                        : Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        listQuestion[current].attemptedAns =
                                            StringUtils.ansD;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.5, 3.5),
                                            blurRadius: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          )
                                        ],
                                        border: Border.all(
                                          width: 1,
                                          color: listQuestion[current]
                                                      .attemptedAns ==
                                                  StringUtils.ansD
                                              ? appTheme.primaryColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            listQuestion[current]
                                                        .attemptedAns ==
                                                    StringUtils.ansD
                                                ? SvgImages.radioSelected
                                                : SvgImages.radioUnSelected,
                                            height: 22,
                                            width: 22,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${listQuestion[position].optionD}',
                                                style: TextStyle(
                                                    color: listQuestion[current]
                                                                .attemptedAns ==
                                                            StringUtils.ansD
                                                        ? appTheme.primaryColor
                                                        : Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        onPageChanged: (int? page) {
                          if (page! == listQuestion.length - 1) {
                            nextButton = StringUtils.submit;
                          } else {
                            nextButton = StringUtils.next;
                          }
                          selectIndex(page, scrollController);
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child: PinkBorderButton(
                                    isEnabled: true,
                                    content: StringUtils.previous,
                                    onPressed: () {
                                      if (current != 0) {
                                        selectIndex(
                                            current - 1, scrollController);
                                        if (current !=
                                            listQuestion.length - 1) {
                                          nextButton = StringUtils.next;
                                        }
                                        setState(() {});
                                      }
                                    },
                                  )),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child: PinkBorderButton(
                                    isEnabled: true,
                                    content: nextButton,
                                    onPressed: () async {
                                      if (nextButton == StringUtils.submit) {
                                        await bloc.submitAnswers(context,
                                            widget.title, listQuestion);
                                      } else {
                                        if (current < listQuestion.length - 1) {
                                          if (current + 1 ==
                                              listQuestion.length - 1) {
                                            nextButton = StringUtils.submit;
                                          }
                                          selectIndex(
                                              current + 1, scrollController);
                                        }
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }

  void selectIndex(int index, ScrollController siScrollController) {
    current = index;
    _pageController.jumpToPage(index); // for regular jump
    _pageController.animateToPage(index,
        curve: Curves.decelerate,
        duration: const Duration(
            milliseconds:
                300)); // for animated jump. Requires a curve and a duration
    if (index > 2) {
      siScrollController.animateTo((current - 2) * 68,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate);
    }

    //controller.jumpTo(current * 50);
    setState(() {});
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

/*

class OptionsWidget extends StatelessWidget {
  final Question? question;
  final ValueChanged<Question>? onClickedOption;

  const OptionsWidget({
    Key? key,
    @required this.question,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
    physics: const BouncingScrollPhysics(),
    children: Utils.heightBetween(
      question
          .map((option) => buildOption(context, option))
          .toList(),
      height: 8,
    ),
  );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);

    return GestureDetector(
      //onTap: () => onClickedOption(option),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            //buildSolution(question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(Option option) => Container(
    height: 50,
    child: Row(children: [
      Text(
        option.code,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      SizedBox(width: 12),
      Text(
        option.text,
        style: TextStyle(fontSize: 20),
      )
    ]),
  );

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Colors.grey.shade200;
    } else {
      return option.isCorrect ? Colors.green : Colors.red;
    }
  }
}

class QuestionsWidget extends StatelessWidget {
  final PageController? controller;
  final ValueChanged<int>? onChangedPage;
  final ValueChanged<Option>? onClickedOption;

  const QuestionsWidget({
    Key? key,
    @required this.controller,
    @required this.onChangedPage,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
    onPageChanged: onChangedPage,
    controller: controller,
    itemCount: category.questions.length,
    itemBuilder: (context, index) {
      final question = category.questions[index];

      return buildQuestion(question: question);
    },
  );

  Widget buildQuestion({
    @required Question? question,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              question?.question ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),

            ),
            SizedBox(height: 8),
            Text(
              'Choose your answer from below',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            SizedBox(height: 32),
            Expanded(
              child: OptionsWidget(
                question: question,
                onClickedOption: onClickedOption,
              ),
            ),
          ],
        ),
      );
}
*/