import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/verify_model.dart';
import '../pages/input_details.dart';
import '../apis/otp_api.dart';
import '../models/otp_model.dart';

import '../pages/varify_otp.dart';
import '../styles/common_module/my_alert_dialog.dart';
import '../styles/common_module/my_snack_bar.dart';



class OTPController extends GetxController {

  TextEditingController number = TextEditingController();
 // TextEditingController otp = TextEditingController();


  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  final box = GetStorage();


  getOTP () async {
    MyAlertDialog.circularProgressDialog();

    var loginList = <OTPData>[].obs;
    isLoading(true);
    var _api_response = await OTPApi.getOTP(number.text);

    if(_api_response!=null){

      if(_api_response.status == 200){
        loginList.assignAll(_api_response.userData!);
        box.write('OTP', _api_response.otp);
        Get.off(()=> const VerifyOTP());
        //print(loginList);
        MySnackbar.successSnackBar('Success','OPT sent to your number');
      }
      else if(_api_response.status == 400){
        Get.back();
        MySnackbar.infoSnackBar('Failed','Phone number doesn\'t exist!');
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Internal Server Down', 'Message not sent!');
      }
    }
    else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
    }
  }


  verifyOTP (String otp) async {
    MyAlertDialog.circularProgressDialog();
    var verifyList = <UserData>[].obs;
    isLoading1(true);
    var _api_response = await OTPApi.verifyOTP(number.text,otp);

    if(_api_response!=null){

      if(_api_response.status == 200){
        verifyList.assign(_api_response.userData!);
        box.write('token', _api_response.token);
        print(_api_response.token.toString());
        box.write('id', _api_response.userData!.id);
        box.write('mobile', _api_response.userData!.mobile);
        box.write('isVerified', true);
        Get.off(()=> const InputDetails());
        MySnackbar.successSnackBar('Verified','OPT verified successfully');
      }
      else if(_api_response.status == 400){
        Get.back();
        MySnackbar.infoSnackBar('Failed','Please enter correct OTP. Click Resend OTP!');
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Internal Server Down', 'Something went wrong');
      }
    }
    else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Something went wrong');
    }
  }


  resendOTP () async {
    MyAlertDialog.circularProgressDialog();
    isLoading2(true);
    var _api_response = await OTPApi.resendOTP(number.text);

    if(_api_response!=null){

      if(_api_response.success == true){

        box.write('OTP', _api_response.data!.otp);
        Get.off(()=> const VerifyOTP());
        MySnackbar.successSnackBar('Success','OPT sent to your number');
      }
      else if(_api_response.success == false){
        Get.back();
        MySnackbar.infoSnackBar('Failed','Phone number doesn\'t exist!');
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Internal Server Down','Message not sent!');
      }
    }
    else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
    }
  }
}