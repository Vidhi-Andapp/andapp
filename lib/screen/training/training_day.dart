import 'dart:async';
import 'dart:io';

import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/training/training_day_bloc.dart';
import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrainingDays extends StatefulWidget {
  final String title;
  final String day;

  const TrainingDays({Key? key, required this.title, required this.day})
      : super(key: key);

  @override
  State<TrainingDays> createState() => _TrainingDaysState();
}

class _TrainingDaysState extends State<TrainingDays> {
  TrainingDayBloc bloc = TrainingDayBloc();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final appTheme = AppTheme.of(context);
    var trainingType = widget.title == StringUtils.generalInsurance
        ? ApiClient.trainingTypeGI
        : ApiClient.trainingTypeLI;
    var theme = "dark";//(Theme.of(context) == ThemeMode.dark) ? "dark" : "light";
    String url =
        "${ApiClient.trainingDayURL}${trainingType}day${widget.day}$theme.html";
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: url,
              //'http://ec2-3-7-188-163.ap-south-1.compute.amazonaws.com:8088/Mails/Liday1dark.html',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                if (kDebugMode) {
                  print('WebView is loading (progress : $progress%)');
                }
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  if (kDebugMode) {
                    print('blocking navigation to $request}');
                  }
                  return NavigationDecision.prevent;
                }
                if (kDebugMode) {
                  print('allowing navigation to $request');
                }
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                if (kDebugMode) {
                  print('Page started loading: $url');
                }
              },
              onPageFinished: (String url) {
                if (kDebugMode) {
                  print('Page finished loading: $url');
                }
              },
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: PinkBorderButton(
              isEnabled: true,
              content: StringUtils.submit,
              onPressed: () async {
                await bloc.completeDay(
                  context,
                  mounted,
                  widget.title,
                  widget.day,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}