import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import '../models/profile_fetch_model.dart';


class ProfileFetchApi {

  // static var client = http.Client();
  static var baseUrl = GlobalConfiguration().get('base_url');


  static Future<ProfileFetchModel> fetchProfile() async {
    final box = GetStorage();

    var headers = {
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${baseUrl}profile/${box.read('id')}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsoString = await response.stream.bytesToString();
      return profileFetchModelFromJson(jsoString);
    } else {
      return profileFetchModelFromJson(response.reasonPhrase!);
    }
  }
}