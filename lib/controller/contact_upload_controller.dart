import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../apis/contact_upload_api.dart';




class ContactUploadController extends GetxController{

  //var isLoading = false.obs;
  final box = GetStorage();
  var oldList = [];
  //var userProfile = <ProfileData>[];
  // var apiResponse1;

  Future<void> uploadContact(List<String> names,List<String> numbers) async {
    print('contact list ${names.length}');
    if(names.length.toString() == '0'){
      print('list is empty');
    }else{
      List<String> stringNames = List<String>.from(names);
      List<String> stringANumbers= List<String>.from(numbers);
      print(' mynames ${stringNames.toString()}');
      print(stringANumbers);

      final batchData =
      {
        // 'number': entry.number,
        "user_id": box.read('id').toString(),
        "name": stringNames.toString(),
        "mobile": stringANumbers.toString(),
      };

      // Send the batch data to the API
      try {
        var apiResponse = await ContactUploadApi.uploadContact(batchData);

        if (apiResponse != null) {
          if (apiResponse.status == 200) {

            // userProfile.assign(apiResponse.data!);
            print('success-- contacts');
            //print('my verification status..............${apiResponse.userinfo!.profile!.isVerified}');
          }
        }
      } finally {
       // isLoading(false);
      }
    }

  }
}