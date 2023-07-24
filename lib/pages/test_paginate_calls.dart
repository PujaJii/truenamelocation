import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truenamelocation/controller/calls_paginate_controller.dart';
import 'package:truenamelocation/pages/user_profile.dart';

import '../controller/call_feed_controller.dart';
import '../styles/app_colors.dart';



class TestPaginateCalls extends StatefulWidget {
  const TestPaginateCalls({Key? key}) : super(key: key);

  @override
  State<TestPaginateCalls> createState() => _TestPaginateCallsState();
}

class _TestPaginateCallsState extends State<TestPaginateCalls> {
  CallsPaginateController callsPaginateController = Get.put(CallsPaginateController());
  CallFeedController callFeedController = Get.put(CallFeedController());

  List<String> name = [];
  List<String> number = [];
  List<String> callType = [];
  List<String> durations = [];
  List<String> timeStamp = [];
  List<String> status = [];
  String formatDateTime(var timeStamp){

    return '';
  }

  @override
  void initState() {
    getAllLogs();
    super.initState();
  }

  Future<void> getAllLogs() async {
    Map<String, CallLogEntry> uniqueCallLogs = {};
    Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
    // var now = DateTime.now();
    // int from = now
    //     .subtract(const Duration(days: 2))
    //     .millisecondsSinceEpoch;
    // int to = now
    //     .subtract(const Duration(days: 0))
    //     .millisecondsSinceEpoch;
    final Iterable<CallLogEntry> result = await CallLog.query(
      // dateFrom: from,
      // dateTo: to,
      // number: '9614159151'
    );
    setState(() {
      _callLogEntries = result;
    });
    for (CallLogEntry callLog in _callLogEntries) {
      if (!uniqueCallLogs.containsKey(callLog.number)) {
        uniqueCallLogs[callLog.number!] = callLog;
      }
    }

    for (CallLogEntry entry in uniqueCallLogs.values) {
      if(entry.name == null || entry.name == '')
      {
        name.add('null');
      }
      else if(entry.name!.contains(',')){
        String originalString = entry.name!;
        String replacedString = originalString.replaceAll(",", "");
        name.add(replacedString);
      } else if (entry.name!.contains('\'')) {
        String originalString = entry.name!;
        String replacedString = originalString.replaceAll("\'", "");
        name.add(replacedString);
      }else if (entry.name!.contains('"')) {
        String originalString = entry.name!;
        String replacedString = originalString.replaceAll('"', '');
        name.add(replacedString);
      }
      else{
        name.add(entry.name.toString());
      }
      number.add(entry.number.toString());
      durations.add(entry.duration.toString());
      timeStamp.add( DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)).toString());
      status.add('fair');

      String callTypes = entry.callType.toString().substring(9);
      callType.add(callTypes);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    print(number);

    callFeedController.uploadCallLogEntries(name,number,callType,durations,timeStamp,status);
    return Scaffold(
      body: LimitedBox(
        maxHeight: double.infinity,
        child: GetX<CallsPaginateController>(
          initState: (context) {
            callsPaginateController.getMyCallLogs(number: 0);
          },
          builder: (controller) {
            if (controller.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    // HeartbeatProgressIndicator(
                    //   child: Icon(Icons.shopping_cart,
                    //       color: AppColors.themeColorTwo),
                    // ),
                    SizedBox(height: 10),
                    Text(
                      'Loading..',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            } else {
              return controller.apiCallLogs.isEmpty
                  ? const Center(
                   child: Text('Call log is empty'),)
                  : Column(
                    children: [
                     controller.apiCallLogs.length < 6?
                      Container():
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemCount: 6,
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 15),
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //     color: AppColors.themeColor),
                                          borderRadius: BorderRadius.circular(25),
                                          color: AppColors.colors[index % AppColors.colors.length]),
                                      child: Center(child: controller.apiCallLogs[index].callerName.toString() == 'null' || controller.apiCallLogs[index].callerName.toString() == '' ?
                                      Text(
                                        'U', style: TextStyle(color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20),)
                                          : Text(((controller.apiCallLogs[index].callerName.toString()).substring(0, 1)),
                                        style:  TextStyle(color: AppColors.colors2[index % AppColors.colors2.length], fontSize: 20),)),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      //right: 14,
                                      child: Container(
                                        // height: 17,width: 17,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: AppColors.themeColor2,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2,
                                                offset: Offset(
                                                  0,
                                                  3,
                                                ),
                                              )]
                                        ),
                                        child: const Center(
                                          child: Text('17m',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                            ),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                controller.apiCallLogs[index].callerName.toString() == 'null' ||
                                    controller.apiCallLogs[index].callerName.toString() == '' ?
                                const Expanded(child: Text('Unknown'))
                                    :Expanded(child: Text(
                                  controller.apiCallLogs[index].callerName.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,))
                              ],
                            );
                          },),
                      ),
                      Expanded(
                        child: ListView.builder(
                        controller: controller.scrollController,
                        padding:  const EdgeInsets.fromLTRB(8,8,8,100),
                        shrinkWrap: true,
                        itemCount: controller.apiCallLogs.length,
                        itemBuilder: (context, index) {
                          // print('mycallTypessss : ${controller.apiCallLogs[index].callType.toString()}');
                          var mycl = AppColors.colors[(index % AppColors.colors.length)];
                          var mycl2 = AppColors.colors2[index % AppColors.colors2.length];
                          return InkWell(
                            onTap: () {
                              // _callNumber(entry.number);
                            },
                            child: ListTile(
                              leading: InkWell(
                                onTap: () {
                                  Get.to(()=>  UserProfile(
                                      controller.apiCallLogs[index].callerName.toString(),
                                      controller.apiCallLogs[index].callFromMobile.toString(),
                                      mycl,mycl2
                                  ));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      margin: const EdgeInsets.only(bottom: 6),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.themeColor,),
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.colors[index % AppColors.colors.length],
                                      ),
                                      child: controller.apiCallLogs[index].callerName.toString() == 'null' || controller.apiCallLogs[index].callerName == ''?
                                      Center(child: Text(
                                          'U', style: TextStyle(color : AppColors.colors2[index % AppColors.colors2.length], fontSize: 20))) :
                                      Center(child: Text(((controller.apiCallLogs[index].callerName!).substring(0, 1)),
                                          style: TextStyle(color : AppColors.colors2[index % AppColors.colors2.length], fontSize: 20))),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        height: 15,width: 15,
                                        decoration: BoxDecoration(
                                            color: AppColors.themeColor,
                                            border: Border.all(width: 1.5,color: Colors.white),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Text('i',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontFamily: 'JacquesFrancois-Regular'),),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        // height: 17,width: 17,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: AppColors.themeColor2,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 2,
                                                offset: Offset(
                                                  0,
                                                  3,
                                                ),
                                              )]
                                        ),
                                        child: const Center(
                                          child: Text('17m',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                            ),),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              title:
                              controller.apiCallLogs[index].callerName.toString() == 'null' || controller.apiCallLogs[index].callerName == '' ?
                              Text(controller.apiCallLogs[index].callFromMobile!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),):
                              Text(controller.apiCallLogs[index].callerName!, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                              subtitle: Row(
                                children: [
                                  controller.apiCallLogs[index].callType.toString() == 'CallType.INCOMING' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                                      Text('Received'),
                                    ],
                                  ) :
                                  controller.apiCallLogs[index].callType.toString() == 'CallType.OUTGOING' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.call_made, size: 18,),
                                      Text('Outgoing'),
                                    ],
                                  ) :
                                  controller.apiCallLogs[index].callType.toString() == 'CallType.MISSED' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.call_missed, size: 18, color: Colors.red),
                                      Text('Missed'),
                                    ],
                                  ) :
                                  controller.apiCallLogs[index].callType.toString() == 'CallType.BLOCKED' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.block, size: 18, color: Colors.blue),
                                      Text('Blocked'),
                                    ],
                                  ) :
                                  controller.apiCallLogs[index].callType.toString() == 'CallType.REJECTED' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.call_missed, size: 18, color: Colors.red),
                                      Text('Rejected'),
                                    ],
                                  ) :
                                  const Text('undefined'),
                                  const SizedBox(width: 8,),
                                  //Text('${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)))}'),
                                  Text('.${controller.apiCallLogs[index].callTime.toString()}'),
                                ],
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    Get.to(()=>UserProfile(
                                        controller.apiCallLogs[index].callerName.toString(),
                                        controller.apiCallLogs[index].callFromMobile.toString(),
                                        mycl,mycl2)
                                    );
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: AppColors.pattern1,
                                          borderRadius: BorderRadius.circular(30)),
                                      child: const Icon(Icons.keyboard_arrow_right,size: 17,))),
                            ),
                          );
                          //}
                          //return Text('kfaskdfns');
                        }),
                      ),
                    ],
                  );
            }
          },
        ),
      ),
    );
  }
}
