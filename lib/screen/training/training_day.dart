import 'dart:async';
import 'dart:io';

import 'package:andapp/common/pink_border_button.dart';
import 'package:andapp/common/string_utils.dart';
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
            height: MediaQuery.of(context).size.height - 180,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl:
                  'http://ec2-3-7-188-163.ap-south-1.compute.amazonaws.com:8088/Mails/Liday1dark.html',
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
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: PinkBorderButton(
                  isEnabled: true,
                  content: StringUtils.submit,
                  onPressed: () {},
                ),
              )),
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