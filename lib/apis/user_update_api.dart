import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/user_update_model.dart';



class UserUpdateApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<UserUpdatesModel> userUpdate(String user_id,String location,String fcm) async {
    final box = GetStorage();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}updateUserLocationFCM'));
    request.body = json.encode({
      "user_id": user_id,
      "location": location,
      "fcm": fcm,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return userUpdatesModelFromJson(jsoString);
    } else {
      return userUpdatesModelFromJson(response.reasonPhrase!);
    }
  }

}