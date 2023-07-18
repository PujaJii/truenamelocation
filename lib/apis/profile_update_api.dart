import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/profile_update_model.dart';


class ProfileUpdateApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<ProfileUpdateModel> updateProfile(
      String id,
      String first_name,
      String last_name,
      String email,
      String birthdate,
      String gender,
      String mobile) async {
    final box = GetStorage();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}profileUpdate'));
    request.body = json.encode({
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "birthdate": birthdate,
      "gender": gender,
      "mobile": mobile
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return profileUpdateModelFromJson(jsoString);
    } else {
      return profileUpdateModelFromJson(response.reasonPhrase!);
    }
  }
}