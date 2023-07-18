


import 'package:get/get.dart';
import 'package:truenamelocation/apis/image_upload_api.dart';

import '../styles/common_module/my_alert_dialog.dart';
import '../styles/common_module/my_snack_bar.dart';

class ImageUploadController extends GetxController{


  var isLoading = false.obs;


  callStatusUpdate(String image) async {
    MyAlertDialog.circularProgressDialog();

    isLoading(true);
    var _api_response = await ImageUploadApi.uploadImage(image);

    if(_api_response!=null){

      if(_api_response.status == 200){
        print('call status Updated');
        //Get.off(()=> const VerifyOTP());
        MySnackbar.successSnackBar('Uploaded','Profile image is uploaded');
      }
      else if(_api_response.status == 400){
        // Get.back();
         MySnackbar.infoSnackBar('Failed','');
        print('Not Updated call status');
      }
      else{
        print('Not Updated call status1');
        // Get.back();
         MySnackbar.errorSnackBar('Internal Server Down', 'Message not sent!');
      }
    }
    else{
      print('Not Updated call status2');
      // Get.back();
       MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
    }
  }
}