
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:truenamelocation/models/image_upload_model.dart';


//class CreateAppointmentApi{


//   static Future<ImageModel> createAppointment(
//       String id,
//       {dynamic document}
//       ) async {
//      var baseUrl = GlobalConfiguration().get("base_url");
//
//     var request =  http.MultipartRequest('POST', Uri.parse('${baseUrl}uploadProfileImage'));
//
//     request.fields['id'] = id;
//     if(document == ''){}
//     else{
//       request.files.add(await http.MultipartFile.fromPath('user_image', document.toString()));
//     }
//     //  request.files.add(await http.MultipartFile.fromPath('document', document.toString()));
//
//     var response = await request.send();
//     final res = await http.Response.fromStream(response);
//
//     if (response.statusCode == 200) {
//       var jsonString = res.body.toString();
//       //print('$baseUrl url');
//       return imageModelFromJson(jsonString);
//     }
//     return imageModelFromJson(res.body);
//   }
// }

class  ImageUploadApi{
  static Future<ImageModel> uploadImage(
      //String id,
      dynamic user_image
      ) async {
    final box = GetStorage();
    var baseUrl = GlobalConfiguration().get("base_url");
    var headers = {
      'Authorization': 'Bearer ${box.read('token')}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}uploadProfileImage'));
    request.fields.addAll({
      'id': box.read('id').toString()
    });
    // if(document == ''){}
    // else{
    request.files.add(await http.MultipartFile.fromPath('user_image', user_image));
    // }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return imageModelFromJson(await response.stream.bytesToString());
    }
    else {
      return imageModelFromJson(response.reasonPhrase!);
    }
  }
}