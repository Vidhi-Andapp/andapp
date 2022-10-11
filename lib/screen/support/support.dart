import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/common_functions.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/login/login_send_otp_bloc.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with TickerProviderStateMixin {
  final LoginSendOTPBloc bloc = LoginSendOTPBloc();

  @override
  void initState() {
    super.initState();
    bloc.getURLs(context);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          onBack();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                StringUtils.menuSupport,
                textAlign: TextAlign.left,
                style: Theme
                    .of(context)
                    .appBarTheme
                    .titleTextStyle,
              ),
              backgroundColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              centerTitle: true,
              elevation: 0,
              // give the app bar rounded corners
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onBack();
                    },
                    tooltip:
                    MaterialLocalizations
                        .of(context)
                        .backButtonTooltip,
                  );
                },
              )),
          body: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.max,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3,
                      child: SvgPicture.asset(
                        SvgImages.supportBanner,
                        //color: appTheme.primaryColor,
                      ),
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.all(32),
                        decoration: ShapeDecoration(
                            shadows: [
                              BoxShadow(
                                offset: const Offset(2, 3),
                                blurRadius: 8,
                                color: appTheme.separatorColor,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(21.0),
                                  topRight: Radius.circular(21.0),
                                ),
                                side: BorderSide(
                                    width: 2,
                                    color: appTheme.supportBorderColor)),
                            color: Theme
                                .of(context)
                                .scaffoldBackgroundColor),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getRow(() {
                              _makePhoneCall();
                            }, SvgImages.iconCall, StringUtils.supportCall,
                                appTheme),
                            separator(),
                            getRow(() {
                            }, SvgImages.iconCallBack,
                                StringUtils.requestACallBack, appTheme),
                            separator(),
                            getRow(() {
                              if (ApiClient.userManualUrl.isNotEmpty) {
                                CommonFunctions.getInstance()!
                                    .launchInBrowser(ApiClient.freshDeskUrl);
                              }
                            }, SvgImages.iconRaiseTicket,
                                StringUtils.raiseATicket, appTheme),
                            separator(),
                            getRow(() {
                              launchUrl(emailLaunchUri);
                            }, SvgImages.iconEmail, StringUtils.supportMail,
                                appTheme),
                            separator(),
                            getRow(() {
                              if (ApiClient.userManualUrl.isNotEmpty) {
                                CommonFunctions.getInstance()!
                                    .launchInBrowser(ApiClient.userManualUrl);
                              }
                            }, SvgImages.iconUserManual, StringUtils.userManual,
                                appTheme),
                          ],
                        )),
                  ]),
            );
          }),
          /*StreamBuilder(
            stream: _bloc.mainStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container();
            },
          ),*/
        ),
      ),
    );
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "9081003001",
    );
    await launchUrl(launchUri);
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: StringUtils.supportMail,
    /*query: _encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!'
    }),*/
  );

  void onBack() {
    Navigator.pop(context);
  }

  Widget getButton(Function onTap, String image, AppThemeState appTheme) {
    return FloatingActionButton(
      onPressed: onTap(),
      heroTag: UniqueKey(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: appTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 6.0,
      // tooltip: '',
      child: Center(
          child: SvgPicture.asset(
            image,
            height: 24,
          )),
    );
  }

  getRow(Function onTap, String image, String title, AppThemeState appTheme) {
    return GestureDetector(
      onTap: onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          getButton(onTap, image, appTheme),
          const SizedBox(
            width: 16,
          ),
          Text(title,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget separator() {
    return Container(
      height: 36,
      width: 4,
      margin: const EdgeInsets.only(left: 24),
      color: Colors.white,
    );
  }
}

class CustomFloatingActionButtonLocation
    implements FloatingActionButtonLocation {
  final double x;
  final double y;

  const CustomFloatingActionButtonLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);
  }
}