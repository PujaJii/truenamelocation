import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:truenamelocation/apis/calls_paginate_api.dart';

import '../models/calls_paginate_model.dart';
import '../styles/common_module/my_snack_bar.dart';




class CallsPaginateController extends GetxController{

  var isLoading = false.obs;
  final box = GetStorage();
  var apiCallLogs = <CallLog>[].obs;
  ScrollController scrollController = ScrollController();
  var page = 0;
  var isMoreDataAvailable = false.obs;


  @override
  void onInit() {
    paginateTask();
    super.onInit();
  }

 //  getCallsPaginate(String offset) async {
 //    try {
 //      isLoading(true);
 //      var apiResponse = await CallsPaginateApi.getCalls(offset);
 //      if (apiResponse != null) {
 //        if (apiResponse.status == 200) {
 //           apiCallLogs.assignAll(apiResponse.callLogs!);
 //         //  print(userProfile);
 //          //print('my verification status..............${apiResponse.userinfo!.profile!.isVerified}');
 //        }
 //      }
 //    } finally {
 //      isLoading(false);
 //    }
 // }


  getMyCallLogs({int? number}) async {
    try {
      isLoading(true);
      var api_response = await CallsPaginateApi.getCalls(number.toString());
      print('number: $number');
      if (api_response != null) {
        if (api_response.status == 200) {
        if (number == '' || number == null) {
          apiCallLogs.assignAll(api_response.callLogs!);
        } else {
          print('pagination else calling');
          //getPaginationList(api_response.userData!);
          apiCallLogs.clear();
          apiCallLogs.addAll(api_response.callLogs!);
        }
        update();
      }
     }
    } finally {
      isLoading(false);
    }
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('Reachmax extend $page');
        if (apiCallLogs.length >= page) {
          print('listlent : ${apiCallLogs.length}');
          page += 15;
        } else {
          print('No data.../.,.xc,vc,gv,fg;dsf;g');
        }
        getMyCallLogsPagination(number: page);
      }
    });
  }

  getMyCallLogsPagination({int? number}) async {
    try {
      isMoreDataAvailable(true);
      var api_response = await CallsPaginateApi.getCalls(number.toString());
      print('myApiCalls $api_response');

      print('number: $number');
      if (api_response != null) {
       // apiCallLogs.length >= number! ?
        // MySnackbar.transparentSnakbar('Loading.. Please wait',
        //     'Loading more data, Please wait for a while')
        //     : MySnackbar.transparentSnakbar('No more data', '');
        apiCallLogs.addAll(api_response.callLogs!);
        update();
      }
    } finally {
      isMoreDataAvailable(false);
    }
  }
}