import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apis/call_status_api.dart';



class CallStatusController extends GetxController {

  var isLoading = false.obs;
  String state = '0';
  final box = GetStorage();


  callStatusUpdate(String onCall) async {
    //MyAlertDialog.circularProgressDialog();
    if(onCall.toString() == 'CallState.IDLE'){
      state = '0';
    }else{
      state = '1';
    }

    isLoading(true);
    var _api_response = await CallStatusUpdateApi.callStatusUpdate(box.read('id').toString(),state);

    if(_api_response!=null){

      if(_api_response.status == 200){
        print('call status Updated');
        //Get.off(()=> const VerifyOTP());
        //print(loginList);
       // MySnackbar.successSnackBar('Success','OPT sent to your number');
      }
      else if(_api_response.status == 400){
       // Get.back();
       // MySnackbar.infoSnackBar('Failed','Phone number doesn\'t exist!');
        print('Not Updated call status');
      }
      else{
        print('Not Updated call status1');
        // Get.back();
        // MySnackbar.errorSnackBar('Internal Server Down', 'Message not sent!');
      }
    }
    else{
      print('Not Updated call status2');
      // Get.back();
      // MySnackbar.errorSnackBar('Server Down', 'Message not sent!');
    }
  }
}