import 'dart:async';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import '../search_page.dart';
import '../user_profile.dart';
import 'package:intl/intl.dart';

import '../../styles/app_colors.dart';


class RealTime extends StatelessWidget {
  const RealTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StreamController<Iterable<CallLogEntry>> callLogStreamController = StreamController.broadcast();


    Future<void> getAllLogs() async {
      CallLog.get().then((callLogs) {
        callLogStreamController.add(callLogs);
      },
       onError: (err){
        //print(err);
          }
      );

    }
    callNumber(var number) async {
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    }
    return Scaffold(
      body: StreamBuilder<Iterable<CallLogEntry>>(
        stream: callLogStreamController.stream,
        builder: (context, snapshot) {
          getAllLogs();
          if (!snapshot.hasData) {
            return const  Center(child: CircularProgressIndicator());
          }
          Iterable<CallLogEntry> callLogs = snapshot.data!;
          // Build your widget tree using the callLogs data



          final List<Widget> children = <Widget>[];
          final List<Widget> faves = <Widget>[];
          Map<String, CallLogEntry> uniqueCallLogs = {};

          for (CallLogEntry callLog in callLogs) {
            if (!uniqueCallLogs.containsKey(callLog.number)) {
              uniqueCallLogs[callLog.number!] = callLog;
            }
          }

          for (CallLogEntry entry in uniqueCallLogs.values) {
            var mycl = AppColors.pattern1;
            var mycl2 =  const Color(0xFF00AF5B);
            children.add(
                InkWell(
                  splashColor: AppColors.pattern1,
                  highlightColor: AppColors.pattern1,
                  onTap: () {
                    callNumber(entry.number);
                  },
                  child: ListTile(
                    leading: InkWell(
                      onTap: () {
                        Get.to(()=>  UserProfile(
                            entry.name.toString(),
                            entry.number.toString(),
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
                              color: AppColors.pattern1,
                            ),
                            child: entry.name == null || entry.name == ''?
                            const Center(child: Text(
                                'U', style: TextStyle(color :  Color(0xFF00AF5B), fontSize: 20))) :
                            Center(child: Text(((entry.name!).substring(0, 1)),
                                style: const TextStyle(color :  Color(0xFF00AF5B), fontSize: 20))),
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
                    entry.name == null || entry.name == '' ?
                    Text(entry.number!,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),):
                    Text(entry.name!, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                    subtitle: Row(
                      children: [
                        entry.callType.toString() == 'CallType.incoming' ?
                        const Row(
                          children: [
                            Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                            Text('Received Call'),
                          ],
                        ) :
                        entry.callType.toString() == 'CallType.outgoing' ?
                        const Row(
                          children: [
                            Icon(Icons.call_made, size: 18,),
                            Text('Outgoing Call'),
                          ],
                        ) :
                        entry.callType.toString() == 'CallType.missed' ?
                        const Row(
                          children: [
                            Icon(Icons.call_missed, size: 18, color: Colors.red),
                            Text('Missed Call'),
                          ],
                        ) :
                        entry.callType.toString() == 'CallType.blocked' ?
                        const Row(
                          children: [
                            Icon(Icons.block, size: 18, color: Colors.blue),
                            Text('Blocked Call'),
                          ],
                        ) :
                        entry.callType.toString() == 'CallType.rejected' ?
                        const Row(
                          children: [
                            Icon(Icons.call_missed, size: 18, color: Colors.red),
                            Text('Rejected call'),
                          ],
                        ) :
                        const SizedBox(),
                        const SizedBox(width: 8,),
                        //Text('${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)))}'),
                        Text('.  ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!))}'),
                      ],
                    ),
                    trailing: InkWell(
                        onTap: () {
                          Get.to(()=>UserProfile(
                              entry.name.toString(),
                              entry.number.toString(),
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
                )
            );
            faves.add(Column(
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
                          color: AppColors.pattern1,
                      ),
                      child: Center(child: entry.name == null || entry.name == '' ?
                      const Text(
                        'U', style: TextStyle(color:  Color(0xFF00AF5B), fontSize: 20),)
                          : Text(((entry.name!).substring(0, 1)),
                        style:  const TextStyle(color:  Color(0xFF00AF5B), fontSize: 20),)),
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
                entry.name == null || entry.name == '' ?
                const Expanded(child: Text('Unknown'))
                    :Expanded(child: Text(
                  entry.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,))
              ],
            ));
          }

          return  SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const SearchPage());
                      },
                      child: Material(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          //side:  BorderSide(color: AppColors.pattern1, width: 1),
                        ),
                        // borderRadius: BorderRadiusGeometry,
                        child: Container(
                          height: 45,
                          decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            children:  [
                              //const SizedBox(width: 15,),
                              Container(
                                height: 33,
                                width: 33,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/my_profile.jpg'))),
                              ),
                              const Text('    Search numbers, names & more'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ElevatedButton(
                  //       onPressed: () async {
                  //         final Iterable<CallLogEntry> result = await CallLog.query();
                  //         setState(() {
                  //           _callLogEntries = result;
                  //         });
                  //       },
                  //       child: const Text('Get all'),
                  //     ),
                  //   ),
                  // ),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         // Workmanager().registerOneOffTask(
                  //         //   DateTime.now().millisecondsSinceEpoch.toString(),
                  //         //   'simpleTask',
                  //         //   existingWorkPolicy: ExistingWorkPolicy.replace,
                  //         // );
                  //       },
                  //       child: const Text('Get all in background'),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return faves[index];
                      },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: children),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
