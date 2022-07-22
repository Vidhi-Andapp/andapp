import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/registration/academic_details.dart';
import 'package:andapp/screen/registration/registration_phases.dart';
import 'package:flutter/material.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text("PoSP Registration", textAlign: TextAlign.left
                , style: Theme
                    .of(context)
                    .appBarTheme
                    .titleTextStyle,),
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    tooltip: MaterialLocalizations
                        .of(context)
                        .backButtonTooltip,
                  );
                },)),
          /*
          const Icon(
            Icons.arrow_back,
            color: Colors.white
          ),),*/
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor, //const Color(0xff222222),
          body: LayoutBuilder(
              builder: (context, constraint) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: constraint.maxHeight,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const RegistrationPhases(index: 3),
                                const SizedBox(height: 8,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 32),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: StringUtils.bankAcNumber,
                                        labelStyle: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color),
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
                                      if (val?.length == 0 &&
                                          val?.length != 10) {
                                        return "Please enter valid mobile number";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        color: _appTheme.speedDialLabelBgDT
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 32),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: StringUtils.ifscCode,
                                        labelStyle: TextStyle(color: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 12.0),
                                          child: PinkBorderButton(
                                            isEnabled: true,
                                            content: StringUtils.validate,
                                            onPressed: () {},),
                                        ),
                                        /*  fillColor: Colors.white,
                                                      filled: true,*/
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
                                      if (val?.length == 0 &&
                                          val?.length != 10) {
                                        return "Please enter valid mobile number";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        color: _appTheme.speedDialLabelBgDT
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 32),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: StringUtils.bankAcHolder,
                                      labelStyle: TextStyle(color: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.color),
                                      border: Theme
                                          .of(context)
                                          .inputDecorationTheme
                                          .border,
                                      enabled:
                                      false,
                                      fillColor: _appTheme.speedDialLabelBgDT,
                                      filled: true,
                                    ),
                                    validator: (val) {
                                      // ignore: prefer_is_empty
                                      if (val?.length == 0 &&
                                          val?.length != 10) {
                                        return "Please enter valid mobile number";
                                      }
                                      else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                      //color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 12.0),
                                        child: PinkBorderButton(
                                          isEnabled: true,
                                          content: "Previous",
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },)
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 12.0),
                                        child: PinkBorderButton(
                                          isEnabled: true,
                                          content: "Next",
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return const AcademicDetails();
                                                  }),
                                            );
                                          },)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                );
              }
          )
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
