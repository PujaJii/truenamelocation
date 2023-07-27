import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truenamelocation/controller/calls_paginate_controller.dart';
import 'package:truenamelocation/pages/user_profile.dart';

import '../controller/call_feed_controller.dart';
import '../styles/app_colors.dart';
import 'num_pad.dart';



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
      timeStamp.add( DateFormat('yyyy-MM-dd HH:mm a').
      format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)).toString());
      status.add('fair');

      String callTypes = entry.callType.toString().substring(9);
      callType.add(callTypes);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(name);
    // print(number);

    callFeedController.uploadCallLogEntries(name,number,callType,durations,timeStamp,status);
    return Scaffold(
      backgroundColor: Colors.white,
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
                                          color: AppColors.colors[index % AppColors.colors.length]
                                      ),
                                      child: Center(
                                          child: controller.apiCallLogs[index].
                                          callerName.toString() == 'null'
                                          || controller.apiCallLogs[index].callerName.toString() == '' ?
                                      Text(
                                        'U', style: TextStyle(
                                          color: AppColors.colors2[index % AppColors.colors2.length],
                                          fontSize: 20),)
                                          : Text(((
                                              controller.apiCallLogs[index].
                                              callerName.toString()).substring(0, 1)),
                                        style:  TextStyle(
                                            color: AppColors.colors2[index % AppColors.colors2.length],
                                            fontSize: 20),)),
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
                        padding:  const EdgeInsets.fromLTRB(8,8,8,10),
                        shrinkWrap: true,
                        itemCount: controller.apiCallLogs.length,
                        itemBuilder: (context, index) {
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
                                  const SizedBox(width: 5,),
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
                      controller.isMoreDataAvailable.value?
                          Container(
                              margin: EdgeInsets.only(bottom: 60),
                              child: Image.asset('assets/images/loader.gif',scale: 8,)):
                      Container( margin: EdgeInsets.only(bottom: 56),)
                    ],
                  );
            }
          },
        ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: InkWell(
        onTap: () {
          _showFormDialog();
          print(name.length);
          print(callsPaginateController.apiCallLogs.length);
        },
        child: Container(
          height: 55,
          width: 55,
          margin: EdgeInsets.only(bottom: 60),
          decoration: BoxDecoration(
              color: AppColors.themeColor,
              borderRadius: BorderRadius.circular(30)),
          // backgroundColor: AppColors.themeColor,
          // onPressed: () {
          //
          //
          // },
          child: Image.asset(
              'assets/images/ion_keypad.png', scale: 22,
              color: Colors.white),
        ),
      ),
    );
  }

  _callNumber(var number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print(res);
  }
  final TextEditingController _myController = TextEditingController();
  void _showFormDialog() {
    showModalBottomSheet<void>(
        context: context,
        // barrierColor: Colors.transparent,
        elevation: 10,
        isScrollControlled : true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            // heightFactor: 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // display the entered numbers
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _myController,
                    showCursor: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:  const Icon(Icons.add_circle_outline),
                        suffix: InkWell(
                            onLongPress: () {
                              _myController.text = '';
                            },
                            child:  IconButton(
                              onPressed: () {
                                _myController.text = _myController.text
                                    .substring(0, _myController.text.length - 1);
                              }, icon: const Icon(Icons.backspace_outlined),
                            ))),
                    style: const TextStyle(fontSize: 30),
                    // Disable the default soft keybaord
                    keyboardType: TextInputType.none,
                  ),
                ),
                // implement the custom NumPad
                NumPad(
                  buttonSize: 50,
                  //buttonColor: Colors.purple,
                  iconColor: Colors.black,
                  controller: _myController,
                  delete: () {
                    // _myController.text = _myController.text
                    //     .substring(0, _myController.text.length - 1);
                  },
                  //do something with the input numbers
                  onSubmit: () {
                    // debugPrint('Your code: ${_myController.text}');
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => AlertDialog(
                    //       content: Text(
                    //         "You code is ${_myController.text}",
                    //         style: const TextStyle(fontSize: 30),
                    //       ),
                    //   ));
                  },
                ),
                const SizedBox(height: 18,),
                InkWell(
                  onTap: () {
                    _callNumber(_myController.text);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00AF5B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.call_outlined, size: 27,color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            ),
          );
        }
    );
  }
}
