import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/search_number_model.dart';



class SearchNumberApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');



  static Future<SearchNumberModel> searchNumber(String user_id,String mobile) async {
    final box = GetStorage();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${baseUrl}searchNumber'));
    request.body = json.encode({
     "user_id": user_id,
     "mobile": mobile
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return searchNumberModelFromJson(jsoString);
    } else {
      return searchNumberModelFromJson(response.reasonPhrase!);
    }
  }

}