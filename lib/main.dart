import 'package:flutter/material.dart';
import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/custom_progress.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/screen/login/login_send_otp_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final AppThemeState _appTheme = AppThemeState();
  bool isLoggedIn = false;
  @override

  void initState() {
    super.initState();
    /*AppComponentBase.getInstance()?.getSharedPreference().getUserDetail().then((value){
      setState(() {
        isLoggedIn = value!=null;
      });
    });*/
    AppComponentBase.getInstance()?.initialiseNetworkManager();
  }

  ThemeData? darkThemeData(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(
          secondary: Colors.grey, brightness: Brightness.dark),
      appBarTheme: Theme
          .of(context)
          .appBarTheme
          .copyWith(systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,),
          titleTextStyle: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500
      ),
      iconTheme: Theme
          .of(context)
          .appBarTheme.iconTheme?.copyWith(color: Colors.white)),
      primaryColor: Colors.black,
      scaffoldBackgroundColor: _appTheme.dtBlackColor,
      primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: const TextTheme().copyWith(
          bodyText2: const TextStyle(
              fontSize: 14,
              color: Colors.white
          )
      ),
      primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
      buttonColor: _appTheme.primaryColor,
      hintColor: Colors.white,
      //textTheme: buildTextTheme(base.textTheme, Colors.white),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
              width: 1,
              color: Colors.white
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
              width: 1,
              color: Colors.white
          ),),
        fillColor: Colors.white,
        labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24.0
        ),
      ),
    );
  }

  ThemeData? lightThemeData(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(
          secondary: Colors.grey, brightness: Brightness.dark),
      appBarTheme: Theme
          .of(context)
          .appBarTheme
          .copyWith(systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light)),
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: const TextTheme().copyWith(
          bodyText2: TextStyle(
              fontSize: 14,
              color: _appTheme.blackFontColor
          )
      ),
      primaryIconTheme: base.iconTheme.copyWith(
          color: _appTheme.blackFontColor),
      buttonColor: _appTheme.primaryColor,
      hintColor: _appTheme.blackFontColor,
      //textTheme: buildTextTheme(base.textTheme, Colors.white),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: _appTheme.blackFontColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
              width: 1,
              color: _appTheme.blackFontColor
          ),
        ),
        labelStyle: TextStyle(
            color: _appTheme.blackFontColor,
            fontSize: 24.0
        ),
      ),
    );
  }

  var theme = ValueNotifier(ThemeMode.dark);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: theme,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringUtils.appName,
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          themeMode: ThemeMode.dark,
          home: const LoginSendOTP(),
          builder: (context, widget) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: <Widget>[
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: AppComponentBase.getInstance()?.disableWidgetStream,
                      builder: (context, snapshot) {
                        return IgnorePointer(
                            ignoring: snapshot.data ?? false,
                            child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowIndicator();
                                  return true;
                                },
                                child: widget ?? Container()));
                      }),
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: AppComponentBase.getInstance()?.progressDialogStream,
                      builder: (context, snapshot) {
                        return (snapshot.data ?? false)
                            ? const Center(child: CustomProgressDialog())
                            : const Offstage();
                      })
                ],
              ),
            );
          },
        );
      }
    );
  }

  @override
  void dispose() {
    AppComponentBase.getInstance()?.getNetworkManager().disposeStream();
    AppComponentBase.getInstance()?.dispose();
    super.dispose();
  }
}
