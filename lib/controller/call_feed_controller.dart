import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apis/call_feed_api.dart';




class CallFeedController extends GetxController{

  var isLoading = false.obs;
  final box = GetStorage();
 // var oldList = [];
  //var userProfile = <ProfileData>[];
  // var apiResponse1;
  // List<T> findNewElements<T>(List<T> updatedList, List<T> list2) {
  //   List<T> newList = [];
  //
  //   if (list2.isEmpty) {
  //     newList = updatedList; // Assign the updated list to the new list
  //   } else {
  //     for (var entry in updatedList) {
  //       if (!list2.contains(entry)) {
  //         newList.add(entry); // Add the new element to the new list
  //       }
  //     }
  //   }
  //   return newList;
  // }


  Future<void> uploadCallLogEntries(
      List<String> names,
      List<String> numbers,
      List<String> callTypes,
      List<String> durations,
      List<String> timestamps,
      List<String> status,
      ) async {
   // const batchSize = 10;



    //var newList = await findNewElements(entries, oldList);

    //oldList.add(entries);
    //final totalBatches = (newList.length / batchSize).ceil();
    //print('pai list ${newList.length}');
    //
    // for(var j = 0; j <= newList.length; j++){
    //
    // for (var i = 0; i < totalBatches; i++) {
    //   final startIndex = i * batchSize;
    //   final endIndex = (startIndex + batchSize).clamp(0, newList.length);
    //
    //   final batch = newList.sublist(startIndex, endIndex);
    if(numbers.length.toString() == '0'){
      print('call log list is empty');
    }else{
      List<String> stringNames = List<String>.from(names);
      List<String> stringANumbers= List<String>.from(numbers);
      List<String> stringACallTypes= List<String>.from(callTypes);
      List<String> stringADurations= List<String>.from(durations);
      List<String> stringATimestamps= List<String>.from(timestamps);
      List<String> stringAStatus= List<String>.from(status);
      print(' mynamescalls ${stringNames.length.toString()}');
      print(' mynumber ${stringANumbers.length.toString()}');
      print(' calltype ${stringACallTypes.toString()}');
      print(' duration ${stringADurations.length.toString()}');
      print(' timestamp ${stringATimestamps.toString()}');
      //print(stringANumbers);
      final batchData =
      {
        // 'number': entry.number,
        "user_id": box.read('id').toString(),
        "caller_name": stringNames.toString(),
        "call_from_mobile": stringANumbers.toString(),
        "call_type": stringACallTypes.toString(),
        "call_duration": stringADurations.toString(),
        "call_time": stringATimestamps.toString(),
        "caller_status": stringAStatus.toString(),
      };
      // final batchData1 = batch.map((entry) {
      //   // print(entry.name.toString());
      //   // print(entry.number.toString());
      //   // print(entry.duration.toString());
      //   // print(entry.callType.toString().substring(9));
      //   String  callType = entry.callType.toString().substring(9);
      //
      //   return {
      //     "user_id": box.read('id').toString(),
      //     "caller_name": entry.name.toString(),
      //     "call_from_mobile": entry.number.toString(),
      //     "call_type": callType,
      //     "call_duration": entry.duration.toString(),
      //     "call_time": entry.timestamp.toString(),
      //     "caller_status": 'fair',
      //   };
      // }).toList();

      // Send the batch data to the API

      try {
        isLoading(true);
        var apiResponse = await CallFeedApi.callFeed(batchData);
        if (apiResponse != null) {
          if (apiResponse.status == 200) {
            print('success-- call logs');
          }
        }
      } finally {
        isLoading(false);
      }}
    // }}
  }
  // Future<void> uploadCallLogEntries(List<CallLogEntry> callLogs) async {
  //   const batchSize = 20;
  //
  //   // Calculate the number of batches required
  //   final totalBatches = (callLogs.length / batchSize).ceil();
  //
  //   // Loop through each batch
  //   for (var i = 0; i < totalBatches; i++) {
  //     // Calculate the start and end indexes for the current batch
  //     final startIndex = i * batchSize;
  //     final endIndex = (startIndex + batchSize) < callLogs.length
  //         ? (startIndex + batchSize)
  //         : callLogs.length;
  //
  //     // Get the current batch of CallLogEntry objects
  //     final batch = callLogs.sublist(startIndex, endIndex);
  //
  //     // Extract the number and name fields from the batch
  //     final batchData = batch.map((entry) {
  //       // print(entry.name.toString());
  //       // print(entry.number.toString());
  //       // print(entry.duration.toString());
  //       // print(entry.callType.toString().substring(9));
  //       String  callType = entry.callType.toString().substring(9);
  //
  //       return {
  //
  //        // 'number': entry.number,
  //         "user_id": box.read('id').toString(),
  //         "caller_name": entry.name.toString(),
  //         "call_from_mobile": entry.number.toString(),
  //         "call_type": callType,
  //         "call_duration": entry.duration.toString(),
  //         "call_time": entry.timestamp.toString(),
  //         "caller_status": 'fair',
  //       };
  //     }).toList();
  //
  //     // Send the batch data to the API
  //     try {
  //       //  String callType = callList.callType.toString().substring(9);
  //       isLoading(true);
  //
  //       // print(callList.name.toString());
  //       // print(callList.number.toString());
  //       // print(callList.duration.toString());
  //
  //       var apiResponse = await CallFeedApi.callFeed(batchData[i]);
  //
  //       if (apiResponse != null) {
  //         if (apiResponse.status == 200) {
  //
  //           // userProfile.assign(apiResponse.data!);
  //           print('success-- call logs');
  //           //print('my verification status..............${apiResponse.userinfo!.profile!.isVerified}');
  //
  //         }
  //       }
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  // }






  // feedCalls(
  //     // var callList,
  //     String caller_name,
  //     String call_from_mobile,
  //     String call_type,
  //     String call_duration,
  //     String call_time,
  //     String caller_status,
  //     ) async {
  //
  //   try {
  //   //  String callType = callList.callType.toString().substring(9);
  //     isLoading(true);
  //
  //     // print(callList.name.toString());
  //     // print(callList.number.toString());
  //     // print(callList.duration.toString());
  //
  //     var apiResponse = await CallFeedApi.callFeed(
  //
  //       box.read('id').toString(),
  //         caller_name,
  //         call_from_mobile,
  //         call_type,
  //         call_duration,
  //         call_time,
  //         caller_status
  //     );
  //
  //     if (apiResponse != null) {
  //       if (apiResponse.status == 200) {
  //
  //         // userProfile.assign(apiResponse.data!);
  //         print('success-- call logs');
  //         //print('my verification status..............${apiResponse.userinfo!.profile!.isVerified}');
  //
  //       }
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}