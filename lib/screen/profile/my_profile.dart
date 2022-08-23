import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/profile/my_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final MyProfileBloc bloc = MyProfileBloc();
  static int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    bloc.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    var iconSize = (MediaQuery.of(context).size.width - 64) / 12;
    return Scaffold(
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringUtils.titleMyProfile,
              textAlign: TextAlign.left,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          backgroundColor: appTheme.primaryColor,
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
      backgroundColor: appTheme.primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2.5 / 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 16),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.height * 1.75 / 12,
                            height:
                                MediaQuery.of(context).size.height * 1.75 / 12,
                            decoration: BoxDecoration(
                              color: appTheme.primaryColor,
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'http://i.imgur.com/QSev0hg.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height *
                                      1.75 /
                                      24)),
                              border: Border.all(
                                color: Colors.white,
                                width: 5.0,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 20,
                                width: 24,
                                color: Colors.white,
                                child: SvgPicture.asset(SvgImages.profileCamera,
                                    height: 25, width: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Vidhi Shah",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 8,
                            ),
                            Text("P123456789",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 7 / 10,
                child: Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 2 / 10,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        decoration: ShapeDecoration(
                            shadows: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                spreadRadius: 2,
                                offset: Offset(3.0, 0),
                                color: Colors.white,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                                side: BorderSide(
                                    width: 1,
                                    color:
                                        appTheme.myProfileThirdBgBorderColor)),
                            color: appTheme.myProfileSecondBgColor),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 64) / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      heroTag: UniqueKey(),
                                      backgroundColor: selectedIndex == 1
                                          ? appTheme.primaryColor
                                          : Colors.white,
                                      onPressed: () {},
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        width: 2,
                                        color: selectedIndex == 1
                                            ? appTheme.primaryColor
                                            : Colors.white,
                                      )),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              SvgImages.iconPersonalDetails,
                                              height: iconSize,
                                              width: iconSize,
                                              color: selectedIndex == 1
                                                  ? Colors.white
                                                  : appTheme.primaryColor))),
                                  const SizedBox(height: 8),
                                  const Text(StringUtils.personalDetails,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 64) / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      heroTag: UniqueKey(),
                                      backgroundColor: selectedIndex == 2
                                          ? appTheme.primaryColor
                                          : Colors.white,
                                      onPressed: () {},
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        width: 2,
                                        color: selectedIndex == 2
                                            ? appTheme.primaryColor
                                            : Colors.white,
                                      )),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              SvgImages.iconKYCDetails,
                                              height: iconSize,
                                              width: iconSize,
                                              color: selectedIndex == 2
                                                  ? Colors.white
                                                  : appTheme.primaryColor))),
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(StringUtils.kycDetails,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 64) / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      heroTag: UniqueKey(),
                                      backgroundColor: selectedIndex == 3
                                          ? appTheme.primaryColor
                                          : Colors.white,
                                      onPressed: () {},
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        width: 2,
                                        color: selectedIndex == 3
                                            ? appTheme.primaryColor
                                            : Colors.white,
                                      )),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              SvgImages.iconProfileBankDetails,
                                              height: iconSize,
                                              width: iconSize,
                                              color: selectedIndex == 3
                                                  ? Colors.white
                                                  : appTheme.primaryColor))),
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(StringUtils.bankDetails,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 64) / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                      elevation: 0.0,
                                      heroTag: UniqueKey(),
                                      backgroundColor: selectedIndex == 4
                                          ? appTheme.primaryColor
                                          : Colors.white,
                                      onPressed: () {},
                                      shape: CircleBorder(
                                          side: BorderSide(
                                        width: 2,
                                        color: selectedIndex == 4
                                            ? appTheme.primaryColor
                                            : Colors.white,
                                      )),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              SvgImages.iconQRScan,
                                              height: iconSize,
                                              width: iconSize,
                                              color: selectedIndex == 4
                                                  ? Colors.white
                                                  : appTheme.primaryColor))),
                                  const SizedBox(height: 8),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.0),
                                    child: Text(StringUtils.qrScan,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 132.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          decoration: ShapeDecoration(
                              shadows: [
                                BoxShadow(
                                  blurRadius: 5.0,
                                  spreadRadius: 4,
                                  offset: const Offset(3.0, 0),
                                  color: appTheme.myProfileThirdBgBorderColor,
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                  ),
                                  side: BorderSide(
                                      width: 2,
                                      color: appTheme
                                          .myProfileThirdBgBorderColor)),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          alignment: Alignment.center,
                          child: selectedIndex == 1
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getProfileRow(
                                        SvgImages.iconAadharNumber,
                                        StringUtils.aadharNumber,
                                        "8783578554767",
                                        SvgImages.iconProfileEdit,
                                        () {}),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    getProfileRow(
                                        SvgImages.iconPanNumber,
                                        StringUtils.panNumber,
                                        "EXFGGG78554767",
                                        "",
                                        () {}),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    getProfileRow(
                                        SvgImages.iconGstNumber,
                                        StringUtils.gstNumber,
                                        "23654653678689",
                                        "",
                                        () {}),
                                  ],
                                )
                              : selectedIndex == 2
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getProfileRow(
                                            SvgImages.iconAadharNumber,
                                            StringUtils.aadharNumber,
                                            "8783578554767",
                                            SvgImages.iconProfileEdit,
                                            () {}),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        getProfileRow(
                                            SvgImages.iconPanNumber,
                                            StringUtils.panNumber,
                                            "EXFGGG78554767",
                                            "",
                                            () {}),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        getProfileRow(
                                            SvgImages.iconGstNumber,
                                            StringUtils.gstNumber,
                                            "23654653678689",
                                            "",
                                            () {}),
                                      ],
                                    )
                                  : selectedIndex == 3
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            getProfileRow(
                                                SvgImages.iconAadharNumber,
                                                StringUtils.aadharNumber,
                                                "8783578554767",
                                                SvgImages.iconProfileEdit,
                                                () {}),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            getProfileRow(
                                                SvgImages.iconPanNumber,
                                                StringUtils.panNumber,
                                                "EXFGGG78554767",
                                                "",
                                                () {}),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            getProfileRow(
                                                SvgImages.iconGstNumber,
                                                StringUtils.gstNumber,
                                                "23654653678689",
                                                "",
                                                () {}),
                                          ],
                                        )
                                      : selectedIndex == 4
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                getProfileRow(
                                                    SvgImages.iconAadharNumber,
                                                    StringUtils.aadharNumber,
                                                    "8783578554767",
                                                    SvgImages.iconProfileEdit,
                                                    () {}),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                getProfileRow(
                                                    SvgImages.iconPanNumber,
                                                    StringUtils.panNumber,
                                                    "EXFGGG78554767",
                                                    "",
                                                    () {}),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                getProfileRow(
                                                    SvgImages.iconGstNumber,
                                                    StringUtils.gstNumber,
                                                    "23654653678689",
                                                    "",
                                                    () {}),
                                              ],
                                            )
                                          : Container(),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProfileRow(String leadIcon, String title, String? value, String? trailIcon,
      Function() onTrailTap) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            SvgPicture.asset(leadIcon,
                height: 20, width: 20, color: Colors.white),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 6,
                ),
                Text(value ?? "",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(),
            (trailIcon != null && trailIcon.isNotEmpty)
                ? GestureDetector(
                    onTap: onTrailTap,
                    child: SvgPicture.asset(
                      trailIcon,
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider(
          height: 2,
          color: Colors.white,
        ),
        //const Spacer(),
      ],
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