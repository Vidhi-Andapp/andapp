import 'dart:io';

import 'package:andapp/common/app_theme.dart';
import 'package:andapp/common/custom_progress.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/di/app_component_base.dart';
import 'package:andapp/di/shared_preferences.dart';
import 'package:andapp/screen/dashboard/dashboard.dart';
import 'package:andapp/screen/dashboard/document_page.dart';
import 'package:andapp/screen/login/login_send_otp_page.dart';
import 'package:andapp/services/api_client.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  /*const plainText = '123456789012';
  //const encrypted64 = "dt7jUV+46+FKf5j3JKlLVypvZbLJAZTuS7JtwAXMQk8=";
  final key = encrypt.Key.fromUtf8('VYGUHIKPORWMROEZMZOCUTWGTONSHEDA');
  final iv = encrypt.IV.fromLength(16);

  final encryptor = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc),);

  final encrypted = encryptor.encrypt(plainText, iv: iv);
  final decrypted = encryptor.decrypt(encrypted, iv: iv);
  var encryptedFrom64 = encrypt.Encrypted.fromBase64("g3A4ThBJ9pP3EuzUeW7VUIOawZhpD46mlDPNHVK+DCI=");
  //final decrypted64 = encryptor.decrypt(encryptedFrom64, iv: iv);
*/
  const plainText = 'Works!';

  final key = encrypt.Key.fromUtf8("MAKV2SPBNI992125");
  final iv = encrypt.IV.fromUtf8("MAKV2SPBNI992125");
  final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt64("LqBAlFu631CBLXUyMwxBcQ==", iv: iv);
  print('decrypted:$decrypted');
  print('encrypted.base64:${encrypted.base64}');
  if (kDebugMode) {
    print("plainText : $plainText");
  }
  if (kDebugMode) {
    print("decrypted : $decrypted");
  }
  if (kDebugMode) {
    print("encrypted.base64 : ${encrypted.base64}");
  }
  if (kDebugMode) {
    //print("decrypted base 64 : $decrypted64");
  }
  //bool isLoggedIn = false;
  WidgetsFlutterBinding.ensureInitialized();
  String? pospId;
  String page = "0";
  await getToken();
  page = await getStatus();
  pospId = await AppComponentBase.getInstance()
      ?.getSharedPreference()
      .getUserDetail(key: SharedPreference().pospId);
  runApp(MyApp(
    page: page,
    pospId: pospId,
  ));
}

Future<String> getStatus() async {
  var mobileNo = await AppComponentBase.getInstance()
      ?.getSharedPreference()
      .getUserDetail(key: SharedPreference().mobileNumber);
  if (mobileNo != null && mobileNo!.isNotEmpty) {
    var getStatusData = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .getStatus(mobileNo: mobileNo); //verify otp here
    if (getStatusData != null &&
        getStatusData.resultflag == ApiClient.resultflagSuccess) {
      if (getStatusData.data != null && getStatusData.data?.data != null) {
        var pospId = getStatusData.data?.data?.pospId.toString(),
            pospStatus = getStatusData.data?.data?.pospStatus.toString();
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(key: SharedPreference().pospId, value: pospId);
        await AppComponentBase.getInstance()
            ?.getSharedPreference()
            .setUserDetail(
                key: SharedPreference().pospStatus, value: pospStatus);

        if (pospId != null && pospId.isNotEmpty) {
          if (pospStatus == "1") {
            return "1";
          } else {
            return "2";
            //page = const PoSPRegistration();
          }
        } else {
          return "3";
        }
      }
    }
  }

  return "0";
}

Future getToken() async {
  var tokenValue = await AppComponentBase.getInstance()
      ?.getApiInterface()
      .getApiRepository()
      .token();
  if (tokenValue != null && tokenValue.accessToken != null) {
    if (tokenValue.accessToken!.isNotEmpty) {
      ApiClient.bearerToken = tokenValue.accessToken!;
      await getURLs();
    }
  }
}

Future getURLs() async {
  var getURls = await AppComponentBase.getInstance()
      ?.getApiInterface()
      .getApiRepository()
      .getURls();
  if (getURls != null && getURls.resultflag == ApiClient.resultflagSuccess) {
    ApiClient.freshDeskUrl = getURls.data?.freshdeskurl ?? "";
    ApiClient.userManualUrl = getURls.data?.usermanualurl ?? "";
  }
}

class MyApp extends StatefulWidget {
  final String? page;
  final String? pospId;

  const MyApp({Key? key, this.page, this.pospId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final AppThemeState _appTheme = AppThemeState();

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  //Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    /*AppComponentBase.getInstance()?.getSharedPreference().getUserDetail().then((value){
      setState(() {
        isLoggedIn = value!=null;
      });
    });*/
    AppComponentBase.getInstance()?.initialiseNetworkManager();
    initPlatformState().then((value) {
      AppComponentBase.getInstance()
          ?.getSharedPreference()
          .setUserDetail(key: SharedPreference().deviceId, value: value);
    });

    /* encryptData("123456789012","YNBWNYIRHGFPZZFD");
    decryptData("+UNNp6GSYgdZSzSNblgeOZdv3yadw33U6iQzPsfBSw0=","YNBWNYIRHGFPZZFD");*/
  }

  Future<String?> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (!kIsWeb) {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return null;
/*
    setState(() {
      _deviceData = deviceData;
    });*/
    return deviceData['id'];
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  String encryptedData = '';
  String decryptedData = '';

  static const encryptionChannel = MethodChannel('enc/dec');

  Future<void> encryptData(String encrypted, String key) async {
    try {
      var result = await encryptionChannel.invokeMethod(
        'encrypt',
        {
          'data': "jsonString",
          'key': key,
        },
      );
      print('Encryption : RETURNED FROM PLATFORM');
      print(result);
      setState(() {
        encryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  Future<void> decryptData(String encrypted, String key) async {
    try {
      var result = await encryptionChannel.invokeMethod('decrypt', {
        'data': encrypted,
        'key': key,
      });
      print('Decryption : RETURNED FROM PLATFORM');
      print(result);
      setState(() {
        decryptedData = result;
      });
    } on PlatformException catch (e) {
      print('${e.message}');
    }
  }

  ThemeData? darkThemeData(BuildContext context) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.dark(primary: Colors.grey)
          .copyWith(secondary: Colors.grey),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400),
          iconTheme: Theme.of(context)
              .appBarTheme
              .iconTheme
              ?.copyWith(color: Colors.white)),
      primaryColor: Colors.black,
      unselectedWidgetColor: Colors.white,
      scaffoldBackgroundColor: _appTheme.dtBlackColor,
      primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: const TextTheme().copyWith(
          bodyText2: const TextStyle(fontSize: 14, color: Colors.white)),
      primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
      //buttonColor: _appTheme.primaryColor,
      hintColor: Colors.white,
      //textTheme: buildTextTheme(base.textTheme, Colors.white),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.white),
        ),
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 24.0),
      ),
    );
  }

  ThemeData? lightThemeData(BuildContext context) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(secondary: Colors.grey, brightness: Brightness.dark),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark)),
      primaryColor: Colors.white,
      unselectedWidgetColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: const TextTheme().copyWith(
          bodyText2: TextStyle(fontSize: 14, color: _appTheme.blackFontColor)),
      primaryIconTheme:
          base.iconTheme.copyWith(color: _appTheme.blackFontColor),
      //buttonColor: _appTheme.primaryColor,
      hintColor: _appTheme.blackFontColor,
      //textTheme: buildTextTheme(base.textTheme, Colors.white),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: _appTheme.blackFontColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: _appTheme.blackFontColor),
        ),
        labelStyle: TextStyle(color: _appTheme.blackFontColor, fontSize: 24.0),
      ),
    );
  }

  var theme = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: theme,
        builder: (context, value, child) {
          Widget? defaultPage;
          if (widget.page == "1") {
            defaultPage = Dashboard(
              pospId: widget.pospId ?? "",
            );
          } else if (widget.page == "2") {
            defaultPage = const DocumentPage();
            //page = const PoSPRegistration();
          } else {
            defaultPage = const LoginSendOTP();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringUtils.appName,
            theme: lightThemeData(context),
            darkTheme: darkThemeData(context),
            themeMode: ThemeMode.dark,
            home: defaultPage,
            builder: (context, widget) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: <Widget>[
                    StreamBuilder<bool>(
                        initialData: false,
                        stream:
                            AppComponentBase.getInstance()?.disableWidgetStream,
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
                        stream: AppComponentBase.getInstance()
                            ?.progressDialogStream,
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
        });
  }

  @override
  void dispose() {
    AppComponentBase.getInstance()?.getNetworkManager().disposeStream();
    AppComponentBase.getInstance()?.dispose();
    super.dispose();
  }
}