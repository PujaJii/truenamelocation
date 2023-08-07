


import 'package:get/get.dart';
import 'package:truenamelocation/apis/image_upload_api.dart';
import 'package:truenamelocation/pages/bottom_nav_page.dart';

import '../styles/common_module/my_alert_dialog.dart';
import '../styles/common_module/my_snack_bar.dart';

class ImageUploadController extends GetxController{


  var isLoading = false.obs;


  imageUpdate(String image) async {
    MyAlertDialog.circularProgressDialog();

    isLoading(true);
    var _api_response = await ImageUploadApi.uploadImage(image);

    if(_api_response!=null){

      if(_api_response.status == 200){
        print('Image Updated');
        //Get.to(()=> BottomNavPage());
       // MySnackbar.successSnackBar('Uploaded','Profile image is uploaded');
      }
      else if(_api_response.status == 400){
        // Get.back();
         MySnackbar.infoSnackBar('Failed','Can not upload your image');
        print('Not Updated call status');
      }
      else{
        print('Not Updated call status1');
        // Get.back();
         MySnackbar.errorSnackBar('Internal Server Down', 'Can not upload your image!');
      }
    }
    else{
      print('Not Updated call status2');
      // Get.back();
       MySnackbar.errorSnackBar('Server Down', 'Can not upload your image!');
    }
  }
}