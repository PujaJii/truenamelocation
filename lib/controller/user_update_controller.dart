// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:truecaller/apis/user_update_api.dart';
//
//
// import '../styles/common_module/my_alert_dialog.dart';
// import '../styles/common_module/my_snack_bar.dart';
//
//
//
// class UserUpdateController extends GetxController {
//
//   // TextEditingController otp = TextEditingController();
//
//
//
//   var isLoading = false.obs;
//   var isLoading1 = false.obs;
//   var isLoading2 = false.obs;
//   final box = GetStorage();
//
//
//   userUpdates () async {
//     MyAlertDialog.circularProgressDialog();
//
//     isLoading(true);
//     var _api_response = await UserUpdateApi.userUpdate();
//
//     if(_api_response!=null){
//
//       if(_api_response.status == 200){
//        // Get.off(()=> const VerifyOTP());
//         //print(loginList);
//         //MySnackbar.successSnackBar('Success','OPT sent to your number');
//       }
//       else if(_api_response.status == 400){
//         print('failed user update');
//        // Get.back();
//         //MySnackbar.infoSnackBar('Failed','Phone number doesn\'t exist!');
//       }
//       else{
//         Get.back();
//         MySnackbar.errorSnackBar('Internal Server Down', 'Data not Updated please restart the app');
//       }
//     }
//     else{
//       Get.back();
//       MySnackbar.errorSnackBar('Server Down', 'Data not Updated please restart the app');
//     }
//   }
// }