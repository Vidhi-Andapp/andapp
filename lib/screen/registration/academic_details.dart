/*
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/dashboard/dashboard.dart';
import 'package:andapp/screen/registration/registration_phases.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';

class AcademicDetails extends StatefulWidget {
  const AcademicDetails({Key? key}) : super(key: key);

  @override
  State<AcademicDetails> createState() => _AcademicDetailsState();
}

class _AcademicDetailsState extends State<AcademicDetails> {
  //final LoginSendOTPBloc _bloc = LoginSendOTPBloc();
  final List<String> items = [
    StringUtils.ssc,
    StringUtils.hsc,
    StringUtils.graduation,
    StringUtils.postGraduation,
    StringUtils.phd,
    StringUtils.other,
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        dividersIndexes.add(i);
      }
    }
    return dividersIndexes;
  }

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
          */
/*
          const Icon(
            Icons.arrow_back,
            color: Colors.white
          ),),*/ /*

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
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                //const RegistrationPhases(index: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:16, horizontal: 32),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                          labelText: StringUtils.certificationType,
                                          labelStyle: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          hintStyle: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.color),
                                          fillColor: Colors.white,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                          enabledBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder: Theme
                                              .of(context)
                                              .inputDecorationTheme
                                              .border
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                        color: Colors.white,

                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius: const BorderRadius
                                              .all(Radius.circular(8))
                                      ),
                                      isExpanded: true,
                                      icon: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: SvgPicture.asset(
                                              SvgImages.dropdown,
                                              height: 28, width: 28),),
                                      hint:
                                      const Text(
                                        StringUtils.selectCertificationType,
                                        maxLines: 2,
                                        overflow: TextOverflow
                                            .ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white
                                        ),),
                                      items: _addDividersAfterItems(items),
                                      customItemsIndexes: _getDividersIndexes(),
                                      customItemsHeight: 4,
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 55,
                                      buttonWidth: MediaQuery.of(context).size.width - 64,
                                      itemHeight: 55,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      selectedItemHighlightColor: appTheme.primaryColor,
                                    ),
                                  ),
                                ),
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
                                            StringUtils.uploadCertification,
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
                                          content: "Submit",
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return const Dashboard();
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
        */
/*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/ /*

      ),
    );
  }
}
*/