import 'dart:convert';

import 'package:andapp/services/api_client.dart';
import 'package:flutter/foundation.dart';

class ApiServices extends ApiClient {
  Future<Map<String, dynamic>> login(String mobileNo, String pass) async {
    var response = await gets('', isBackground: true);
    return response;
  }

  Future submitForm(dynamic data) async {
    String body = jsonEncode(data);
    if (kDebugMode) {
      print(body);
    }
    var response = await posts('', body: body, isBackground: true);
    return response;
  }
}
