import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/registration/bank_details.dart';
import 'package:andapp/screen/registration/posp_registration_bloc.dart';
import 'package:andapp/screen/registration/registration_phases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final PospRegistrationBloc bloc = PospRegistrationBloc();
  final panValidateKey = GlobalKey<FormState>(),
      validateAadharOTPKey = GlobalKey<FormState>();

  bool _withGSTA = false,_withGSTM = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
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
                              const RegistrationPhases(index: 2),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 32),
                                child:
                                SizedBox(
                                    height: 50,
                                    child: TabBar(
                                      indicatorColor: appTheme.primaryColor,
                                      labelColor: appTheme.primaryColor,
                                      indicatorPadding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      isScrollable: true,
                                      unselectedLabelColor: Colors.white,
                                      labelStyle: const TextStyle(fontSize: 16),
                                      unselectedLabelStyle: const TextStyle(
                                          fontSize: 16),
                                      tabs: const [
                                        Tab(text: "Automated"),
                                        Tab(text: "Manual"),
                                      ],
                                    )
                                ),
                              ),

                              SizedBox(
                                height: 300,
                                child: TabBarView(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: MergeSemantics(
                                            child: ListTile(
                                              title: const Text(
                                                  StringUtils.personalWithGST),
                                              trailing: CupertinoSwitch(
                                                activeColor: appTheme.primaryColor,
                                                trackColor : appTheme.speedDialLabelBgDT,
                                                value: _withGSTA,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _withGSTA = value;
                                                  });
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _withGSTA = !_withGSTA;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        _withGSTA ?
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 32),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText: StringUtils.gstNumber,
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
                                                    color: appTheme.speedDialLabelBgDT
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 32),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: StringUtils.name,
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
                                                  fillColor: appTheme.speedDialLabelBgDT,
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

                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 32),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: StringUtils.panNumber,
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
                                                  fillColor: appTheme.speedDialLabelBgDT,
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
                                        )
                                            :
                                        Column(
                                          children: [
                                            Form(
                                              key: panValidateKey,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                                child: TextFormField(
                                                  controller: bloc.panNo,
                                                  decoration: InputDecoration(
                                                      labelText: StringUtils.panNumber,
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
                                                          onPressed: () {
                                                            final form = panValidateKey
                                                                .currentState;
                                                            if (form?.validate() ?? false) {
                                                              form?.save();
                                                              bloc.sendAadharOTP(context);
                                                            }
                                                          },),
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
                                                      color: appTheme.speedDialLabelBgDT
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 32),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: StringUtils.name,
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
                                                  fillColor: appTheme.speedDialLabelBgDT,
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
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: MergeSemantics(
                                            child: ListTile(
                                              title: const Text(
                                                  StringUtils.personalWithGST),
                                              trailing: CupertinoSwitch(
                                                activeColor: appTheme.primaryColor,
                                                trackColor : appTheme.speedDialLabelBgDT,
                                                value: _withGSTM,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _withGSTM = value;
                                                  });
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _withGSTM = !_withGSTM;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        _withGSTM ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 32),
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 8, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius: const BorderRadius
                                                          .all(Radius.circular(8))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      const Text(
                                                        StringUtils.gstCertification,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign: TextAlign.start,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 8.0, bottom: 8.0),
                                                        child: SvgPicture.asset(
                                                            SvgImages.iconAttachment,
                                                            height: 20, width: 20),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                            const SizedBox(height: 8,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 32),
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 8, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius: const BorderRadius
                                                          .all(Radius.circular(8))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      const Text(
                                                        StringUtils.panCard,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign: TextAlign.start,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 8.0, bottom: 8.0),
                                                        child: SvgPicture.asset(
                                                            SvgImages.iconAttachment,
                                                            height: 20, width: 20),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  32, 8, 32, 12),
                                              child: Text(
                                                StringUtils
                                                    .uploadContent,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: appTheme.separatorColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),),
                                            ),
                                          ],
                                        )
                                            :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 32),
                                              child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 8, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius: const BorderRadius
                                                          .all(Radius.circular(8))
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      const Text(
                                                        StringUtils.panCard,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign: TextAlign.start,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 8.0, bottom: 8.0),
                                                        child: SvgPicture.asset(
                                                            SvgImages.iconAttachment,
                                                            height: 20, width: 20),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  32, 8, 32, 12),
                                              child: Text(
                                                StringUtils
                                                    .uploadContent,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: appTheme.separatorColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
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
                                                return const BankDetails();
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
