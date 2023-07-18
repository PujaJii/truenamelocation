import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/call_feed_model.dart';


class CallFeedApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');

  static Future<CallLogModel> callFeed(
      var batchData
      // String user_id,
      // String caller_name,
      // String call_from_mobile,
      // String call_type,
      // String call_duration,
      // String call_time,
      // String caller_status,
      //
      ) async {
    final box = GetStorage();
    final jsonData = json.encode(batchData);
    var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}feedCallLog'));
    request.body = jsonData;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return callLogModelFromJson(jsoString);
    } else {
      print('myerror ${response.reasonPhrase}');
      return callLogModelFromJson(response.reasonPhrase!);
    }
  }
}