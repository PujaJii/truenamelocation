import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/call_status_model.dart';


class CallStatusUpdateApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<CallStatusUpdateModel> callStatusUpdate(String id, String onCall) async {
    final box = GetStorage();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}updateUserLastActive'));
    request.body = json.encode({
      "user_id": id,
      "on_call_status": onCall
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return callStatusUpdateModelFromJson(jsoString);
    } else {
      return callStatusUpdateModelFromJson(response.reasonPhrase!);
    }
  }
}