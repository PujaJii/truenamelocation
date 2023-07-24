import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:truenamelocation/models/calls_paginate_model.dart';


class CallsPaginateApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<CallsPaginateModel> getCalls(String offset) async {
    final box = GetStorage();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}getLogPerPage'));
    request.body = json.encode({
      "user_id": box.read('id').toString(),
      "offset": offset,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return callsPaginateModelFromJson(jsoString);
    } else {
      return callsPaginateModelFromJson(response.reasonPhrase!);
    }
  }
}