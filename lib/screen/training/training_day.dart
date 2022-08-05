import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*void main() => runApp(const MaterialApp(home: TrainingDays()));*/

class TrainingDays extends StatefulWidget {
  final String title;
  const TrainingDays({Key? key,required this.title}) : super(key: key);
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
    return Scaffold(
      backgroundColor: Colors.green,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 24,
        child: WebView(
          initialUrl: 'http://ec2-3-7-188-163.ap-south-1.compute.amazonaws.com:8088/Mails/Liday1dark.html',
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
