import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apis/profile_update_api.dart';
import '../pages/bottom_nav_page.dart';

import '../styles/common_module/my_alert_dialog.dart';
import '../styles/common_module/my_snack_bar.dart';



class ProfileUpdateController extends GetxController {

  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController gender = TextEditingController();


  var isLoading = false.obs;

  final box = GetStorage();


  updateProfile () async {
    MyAlertDialog.circularProgressDialog();

    // var loginList = <OTPData>[].obs;
    isLoading(true);
    var _api_response = await ProfileUpdateApi.updateProfile(
      box.read('id').toString(),
      first_name.text,
      last_name.text,
      email.text,
      birthDate.text,
      gender.text,
      box.read('mobile').toString(),
    );

    if(_api_response!=null){

      if(_api_response.status == 200){
        // loginList.assignAll(_api_response.userData!);
        //box.write('OTP', _api_response.otp);
        box.write('isRegistered', true);
        Get.offAll(()=> const BottomNavPage());
        //print(loginList);
        MySnackbar.successSnackBar('Success','Your details updated successfully!');
      }
      else if(_api_response.status == 400){
        Get.back();
        MySnackbar.infoSnackBar('Failed', _api_response.message.toString());
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Internal Server Down', _api_response.message.toString());
      }
    }
    else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', _api_response.message.toString());
    }
  }

}