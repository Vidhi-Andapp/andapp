import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_toast.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/network_image.dart';
import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/model/get_profile.dart';
import 'package:andapp/screen/profile/my_profile_bloc.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfile extends StatefulWidget {
  final String pospId;

  const MyProfile({Key? key, required this.pospId}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final MyProfileBloc bloc = MyProfileBloc();
  static int selectedIndex = 0;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    bloc.getProfile(context, widget.pospId);
  }

  Future<PlatformFile?> _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowCompression: true,
    );
    // if no file is picked
    if (result == null) return null;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    /*print(result.files.first.name);
    print("Size in Bytes : ${result.files.first.size}");
    print(result.files.first.path);*/
    var bytes = result.files.first.size;
    double sizeInMB = bytes / (1024 * 1024);
    print("sizeInMB : $sizeInMB");
    if (sizeInMB > 4) {
      CommonToast.getInstance()
          ?.displayToast(message: "Please select file upto 4 MB only");
      return null;
    }
    return result.files.first;
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    var iconSize = (MediaQuery.of(context).size.width - 64) / 12;
    var firstHeight = MediaQuery.of(context).size.height * 3 / 10;
    var secondHeight = MediaQuery.of(context).size.height * 2.2 / 10;
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        //height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: StreamBuilder<ProfileData?>(
              stream: bloc.profileStream,
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileData?> snapshot) {
                if (snapshot.hasData) {
                  ProfileData? profile = snapshot.data!;
                  return Stack(
                    children: [
                      Container(
                        height: firstHeight,
                        color: appTheme.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48.0, vertical: 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var profilePhoto = await _pickFile();
                                  bloc.profilePhotoStreamController.sink
                                      .add(profilePhoto);
                                  if (mounted) {
                                    await bloc.updateProfilePhoto(
                                        context, profilePhoto);
                                  }
                                },
                                child: Stack(
                                  children: [
                                    CustomNetworkImage(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              1.75 /
                                              12,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1.75 /
                                              12,
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              1.75 /
                                              24,
                                      placeholderImage:
                                          profile.personalDetails?.gender == "M"
                                              ? AssetImages.profileAvatarMale
                                              : AssetImages.profileAvatarFemale,
                                      image:
                                          profile.personalDetails?.pospPhoto ??
                                              "",
                                    ),
                                    Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Container(
                                        height: 20,
                                        width: 24,
                                        color: Colors.white,
                                        child: SvgPicture.asset(
                                            SvgImages.profileCamera,
                                            height: 25,
                                            width: 25),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        profile.personalDetails?.pospName ?? "",
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        profile.personalDetails?.pospCode ?? "",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: firstHeight - 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                              height: secondHeight,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 4.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      spreadRadius: 2,
                                      offset: Offset(3.0, 0),
                                      color: Colors.white,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16.0)),
                                  /*border: Border(
                                      top: BorderSide(
                                          width: 1,
                                          color: appTheme
                                              .myProfileThirdBgBorderColor)),*/
                                  /*shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      side: BorderSide(
                                          width: 1,
                                          color: appTheme
                                              .myProfileThirdBgBorderColor)),*/
                                  color: appTheme.myProfileSecondBgColor),
                              alignment: Alignment.center,
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  64) /
                                              4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton(
                                              elevation: 0.0,
                                              heroTag: UniqueKey(),
                                              backgroundColor:
                                                  selectedIndex == 0
                                                      ? appTheme.primaryColor
                                                      : Colors.white,
                                              onPressed: () {
                                                _pageController.jumpToPage(0);
                                              },
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                width: 2,
                                                color: selectedIndex == 0
                                                    ? appTheme.primaryColor
                                                    : Colors.white,
                                              )),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      SvgImages
                                                          .iconPersonalDetails,
                                                      height: iconSize,
                                                      width: iconSize,
                                                      color: selectedIndex == 0
                                                          ? Colors.white
                                                          : appTheme
                                                              .primaryColor))),
                                          const SizedBox(height: 8),
                                          const Text(
                                              StringUtils.personalDetails,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  64) /
                                              4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton(
                                              elevation: 0.0,
                                              heroTag: UniqueKey(),
                                              backgroundColor:
                                                  selectedIndex == 1
                                                      ? appTheme.primaryColor
                                                      : Colors.white,
                                              onPressed: () {
                                                _pageController.jumpToPage(1);
                                              },
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                width: 2,
                                                color: selectedIndex == 1
                                                    ? appTheme.primaryColor
                                                    : Colors.white,
                                              )),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      SvgImages.iconKYCDetails,
                                                      height: iconSize,
                                                      width: iconSize,
                                                      color: selectedIndex == 1
                                                          ? Colors.white
                                                          : appTheme
                                                              .primaryColor))),
                                          const SizedBox(height: 8),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(StringUtils.kycDetails,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  64) /
                                              4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton(
                                              elevation: 0.0,
                                              heroTag: UniqueKey(),
                                              backgroundColor:
                                                  selectedIndex == 2
                                                      ? appTheme.primaryColor
                                                      : Colors.white,
                                              onPressed: () {
                                                _pageController.jumpToPage(2);
                                              },
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                width: 2,
                                                color: selectedIndex == 2
                                                    ? appTheme.primaryColor
                                                    : Colors.white,
                                              )),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      SvgImages
                                                          .iconProfileBankDetails,
                                                      height: iconSize,
                                                      width: iconSize,
                                                      color: selectedIndex == 2
                                                          ? Colors.white
                                                          : appTheme
                                                              .primaryColor))),
                                          const SizedBox(height: 8),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(StringUtils.bankDetails,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  64) /
                                              4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FloatingActionButton(
                                              elevation: 0.0,
                                              heroTag: UniqueKey(),
                                              backgroundColor:
                                                  selectedIndex == 3
                                                      ? appTheme.primaryColor
                                                      : Colors.white,
                                              onPressed: () {
                                                _pageController.jumpToPage(3);
                                              },
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                width: 2,
                                                color: selectedIndex == 3
                                                    ? appTheme.primaryColor
                                                    : Colors.white,
                                              )),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      SvgImages.iconQRScan,
                                                      height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              64) /
                                                          16,
                                                      width:
                                                          (MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  64) /
                                                              16,
                                                      color: selectedIndex == 3
                                                          ? Colors.white
                                                          : appTheme
                                                              .primaryColor))),
                                          const SizedBox(height: 8),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            child: Text(StringUtils.qrScan,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: (firstHeight - 16) + (secondHeight - 16)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          clipBehavior: Clip.antiAlias,
                          //clipper: [],
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 4.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    spreadRadius: 2,
                                    offset: const Offset(0.0, -2.0),
                                    color: appTheme.separatorColor,
                                  ),
                                ],
                                /*shape: RoundedRectangleBorder(
                                    borderRadius:
                                        const BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                      //right: Radius.circular(16.0),
                                    ),
                                    side: BorderSide(
                                        width: 4, color: Colors.red)),*/
/*
                                border: Border(
                                  top: BorderSide(
                                      width: 4, color: Colors.red),
                                  left: BorderSide(
                                      width: 4, color: Colors.red),
                                  right: BorderSide(
                                      width: 4, color: Colors.red),
                                ),
                                */
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16.0)),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            alignment: Alignment.center,
                            child: ExpandablePageView.builder(
                              controller: _pageController,
                              itemCount: 4,
                              onPageChanged: (int? page) {
                                selectedIndex = page ?? 0;
                                setState(() {});
                              },
                              itemBuilder: (context, position) {
                                selectedIndex = position;
                                return position == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getProfileRow(
                                              SvgImages.iconUsername,
                                              StringUtils.userName,
                                              profile.personalDetails
                                                      ?.userName ??
                                                  "",
                                              SvgImages.iconProfileEdit,
                                              () {}),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          getProfileRow(
                                              SvgImages.iconBirthdate,
                                              StringUtils.birthdate,
                                              profile.personalDetails
                                                      ?.birthdate ??
                                                  "",
                                              "",
                                              () {}),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          getProfileRow(
                                              SvgImages.iconEmail,
                                              StringUtils.emailID,
                                              profile.personalDetails
                                                      ?.emailId ??
                                                  "",
                                              SvgImages.iconProfileEdit,
                                              () {}),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          getProfileRow(
                                              SvgImages.iconCall,
                                              StringUtils.mobileNumber,
                                              profile.personalDetails
                                                      ?.mobileNo ??
                                                  "",
                                              SvgImages.iconNext,
                                              () {}),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          getProfileRow(
                                              SvgImages.iconWhatsapp,
                                              StringUtils.whatsappNumber,
                                              profile.personalDetails
                                                      ?.whatsappNo ??
                                                  "",
                                              SvgImages.iconProfileEdit,
                                              () {}),
                                        ],
                                      )
                                    : position == 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getProfileRow(
                                                  SvgImages.iconAadharNumber,
                                                  StringUtils.aadharNumber,
                                                  profile.kycDetails
                                                          ?.aadharNo ??
                                                      "",
                                                  SvgImages.iconProfileEdit,
                                                  () {}),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              getProfileRow(
                                                  SvgImages.iconPanNumber,
                                                  StringUtils.panNumber,
                                                  profile.kycDetails?.panNo ??
                                                      "",
                                                  "",
                                                  () {}),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              getProfileRow(
                                                  SvgImages.iconGstNumber,
                                                  StringUtils.gstNumber,
                                                  profile.kycDetails?.gstNo ??
                                                      "",
                                                  "",
                                                  () {}),
                                              //Spacer(),
                                            ],
                                          )
                                        : position == 2
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getProfileRow(
                                                      SvgImages
                                                          .iconBankAcNumber,
                                                      StringUtils
                                                          .bankAccountNumber,
                                                      profile.bankDetails
                                                              ?.bankAccountNo ??
                                                          "",
                                                      "",
                                                      () {}),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  getProfileRow(
                                                      SvgImages.iconIfscCode,
                                                      StringUtils.ifscCode,
                                                      profile.bankDetails
                                                              ?.ifsc ??
                                                          "",
                                                      "",
                                                      () {}),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  getProfileRow(
                                                      SvgImages
                                                          .iconAcHolderName,
                                                      StringUtils.accountHolder,
                                                      profile.bankDetails
                                                              ?.bankHolderName ??
                                                          "",
                                                      "",
                                                      () {}),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 32.0,
                                                      ),
                                                      child: Center(
                                                        child: PinkBorderButton(
                                                          isEnabled: true,
                                                          content:
                                                              StringUtils.edit,
                                                          onPressed: () {},
                                                        ),
                                                      )),
                                                ],
                                              )
                                            : position == 3
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 224,
                                                        width: 224,
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            50, 50, 50, 0),
                                                        decoration:
                                                            ShapeDecoration(
                                                                shadows: [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                spreadRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        2, 2),
                                                                color: appTheme
                                                                    .myProfileThirdBgBorderColor,
                                                              ),
                                                            ],
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              8.0),
                                                                        ),
                                                                        side: BorderSide(
                                                                            width:
                                                                                2,
                                                                            color: appTheme
                                                                                .trainingCardBorderColor)),
                                                                color: Colors
                                                                    .white),
                                                        alignment:
                                                            Alignment.center,
                                                        child: QrImage(
                                                          data:
                                                              profile.qrLink ??
                                                                  "",
                                                          version:
                                                              QrVersions.auto,
                                                          //size: 200.0,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 224,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 16),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            ShapeDecoration(
                                                                shadows: [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                spreadRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        2, 2),
                                                                color: appTheme
                                                                    .myProfileThirdBgBorderColor,
                                                              ),
                                                            ],
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                          Radius.circular(
                                                                              8.0),
                                                                        ),
                                                                        side: BorderSide(
                                                                            width:
                                                                                2,
                                                                            color: appTheme
                                                                                .trainingCardBorderColor)),
                                                                color: Colors
                                                                    .white),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                profile.referralLink ??
                                                                    "",
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: appTheme
                                                                        .primaryColor)),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            SvgPicture.asset(
                                                                SvgImages
                                                                    .iconCopy,
                                                                height: 16,
                                                                width: 16),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container();
                              },
                            ),
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
              width: 12,
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
}