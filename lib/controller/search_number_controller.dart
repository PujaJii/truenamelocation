import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:truenamelocation/models/search_number_model.dart';
import '../apis/search_number_api.dart';

import '../styles/common_module/my_snack_bar.dart';



class SearchNumberController extends GetxController {


  // TextEditingController otp = TextEditingController();


  var isLoading = false.obs;
  var viewOn = ''.obs;
  final box = GetStorage();
  var list = <SearchNumberModel>[];
  var listMyContact= <MyContact>[].obs;
  var listTrueResult = <TrueCaller>[].obs;


  search (String searchText) async {
    try {
      //MyAlertDialog.circularProgressDialog();
      isLoading(true);
      var _api_response = await SearchNumberApi.searchNumber(
          box.read('id').toString(), searchText);

      if (_api_response != null) {
        if (_api_response.status == 200) {
          // Get.off(()=> const VerifyOTP());
          //print(_api_response.callername.toString());
          //print(_api_response.status.toString());
          viewOn(_api_response.hasAnotherContact.toString());
          list.assign(_api_response);
          listMyContact.assignAll(_api_response.myContact!);
          listTrueResult.assignAll(_api_response.trueCaller!);
        //  print(listName);
          //MySnackbar.successSnackBar('Success','OPT sent to your number');
        }
        else if (_api_response.status == 400) {
          // print(_api_response.callername.toString());
          viewOn(_api_response.hasAnotherContact.toString());
          list.assign(_api_response);
          listMyContact.assignAll(_api_response.myContact!);
          listTrueResult.assignAll(_api_response.trueCaller!);

          //Get.back();
          //MySnackbar.infoSnackBar('Failed','No search results');
        }
        else {
          Get.back();
          MySnackbar.errorSnackBar('Internal Server Down', 'Message not sent!');
        }
      }
      else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
      }
    }finally{
      isLoading(false);
    }
  }
  searchOnSubmit (var context, String searchText) async {
    try {
      //MyAlertDialog.circularProgressDialog();
      isLoading(true);
      var _api_response = await SearchNumberApi.searchNumber(
          box.read('id').toString(), searchText);

      if (_api_response != null) {
        if (_api_response.status == 200) {
          // Get.off(()=> const VerifyOTP());
          //print(_api_response.callername.toString());
          //print(_api_response.status.toString());
          viewOn(_api_response.hasAnotherContact.toString());
          list.assign(_api_response);
          listMyContact.assignAll(_api_response.myContact!);
          listTrueResult.assignAll(_api_response.trueCaller!);
          //  print(listName);
          //MySnackbar.successSnackBar('Success','OPT sent to your number');
        }
        else if (_api_response.status == 400) {
          // print(_api_response.callername.toString());
          viewOn(_api_response.hasAnotherContact.toString());
          list.assign(_api_response);
          listMyContact.assignAll(_api_response.myContact!);
          listTrueResult.assignAll(_api_response.trueCaller!);

          if(_api_response.hasContact.toString() == 'no'
              && _api_response.hasTrueCaller.toString() == 'no'
              &&_api_response.hasAnotherContact.toString() == 'no')
          {
            ScaffoldMessenger.of(context).showSnackBar(

                const SnackBar(

                  // margin: EdgeInsets.all(8),
                  // shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    content: Text(
                      'No search results!',
                      // textAlign: TextAlign.right,
                    ))
            );
          }
          //Get.back();
          //MySnackbar.infoSnackBar('Failed','No search results');
        }
        else {
          Get.back();
          MySnackbar.errorSnackBar('Internal Server Down', 'Message not sent!');
        }
      }
      else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
      }
    }finally{
      isLoading(false);
    }

  }

}