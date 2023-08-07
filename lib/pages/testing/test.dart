import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import '../search_page.dart';
import '../user_profile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../styles/app_colors.dart';



class TestCalls extends StatefulWidget {
  const TestCalls({Key? key}) : super(key: key);

  @override
  State<TestCalls> createState() => _TestCallsState();
}

class _TestCallsState extends State<TestCalls> {

  final PagingController<int, CallLogEntry> _pagingController =
  PagingController(firstPageKey: 0);
  // Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

  List<Color> colors = [
    AppColors.pattern1,
    AppColors.pattern2,
    AppColors.pattern3,
    AppColors.pattern4,
  ];

  List<Color> colors2 = [
    // const Color(0x3300AF5B),
    const Color(0xFF00AF5B),
    const Color(0xFF1800AF),
    const Color(0xFFAF4A00),
    const Color(0xFF13828A),
  ];

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }
  _fetchPage(int pageKey) async{
    try {
      int limit = 30;
      int offset = pageKey * limit;

      Iterable<CallLogEntry> entries = await CallLog.get()
          .then((log) => log.toList(growable: false))
          .then((list) =>
          (_removeDuplicateCallLogs(list))
          .getRange(
          offset,

          offset + limit
      )
      );
      print(entries.length);
      print(offset);
      print(limit);

      List<CallLogEntry> newData = entries.toList();
      final isLastPage = newData.length < limit;
      if (isLastPage) {
        _pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      debugPrint(_pagingController.error.toString());
    }
  }
  _callNumber(var number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  static List<CallLogEntry> _removeDuplicateCallLogs(List<CallLogEntry> callLogs) {
    final uniquePhoneNumbers = <String>{};
    final uniqueCallLogs = <CallLogEntry>[];
    for (final callLog in callLogs) {
      if (!uniquePhoneNumbers.contains(callLog.number)) {
        uniquePhoneNumbers.add(callLog.number!);
        uniqueCallLogs.add(callLog);
      }
    }
    return uniqueCallLogs;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: InkWell(
                onTap: () {
                  Get.to(() => const SearchPage());
                },
                child: Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color(0x30818181),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children:  [
                      //const SizedBox(width: 15,),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'))),
                      ),
                      const Text('Search numbers, names & more'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: PagedListView<int, CallLogEntry>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<CallLogEntry>(
                  itemBuilder: (context, item, index) {
                    var mycl = colors[index % colors.length];
                    var mycl2 = colors2[index % colors.length];
                   return InkWell(
                        splashColor: AppColors.pattern1,
                        highlightColor: AppColors.pattern1,
                        onTap: () {
                          _callNumber(item.number);
                        },
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              Get.to(()=>  UserProfile(
                                  item.name.toString(),
                                  item.number.toString(),
                                  mycl,mycl2
                              ));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.themeColor,),
                                borderRadius: BorderRadius.circular(25),
                                color: colors[index % colors.length],
                              ),
                              child: item.name == null || item.name == ''?
                              Center(child: Text(
                                  'U', style: TextStyle(color : colors2[index % colors.length], fontSize: 20))) :
                              Center(child: Text(((item.name!).substring(0, 1)),
                                  style: TextStyle(color : colors2[index % colors.length], fontSize: 20))),
                            ),
                          ),
                          title:
                          item.name == null || item.name == '' ?
                          const Text('Unknown Number',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),):
                          Text(item.name!, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                          subtitle: Row(
                            children: [
                              item.callType.toString() == 'CallType.incoming' ?
                               Row(
                                children: [
                                  Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                                  Text('Received Call'),
                                ],
                              ) :
                              item.callType.toString() == 'CallType.outgoing' ?
                               Row(
                                children: [
                                  Icon(Icons.call_made, size: 18,),
                                  Text('Outgoing Call'),
                                ],
                              ) :
                              item.callType.toString() == 'CallType.missed' ?
                               Row(
                                children: [
                                  Icon(Icons.call_missed, size: 18, color: Colors.red),
                                  Text('Missed Call'),
                                ],
                              ) :
                              item.callType.toString() == 'CallType.blocked' ?
                               Row(
                                children: [
                                  Icon(Icons.block, size: 18, color: Colors.blue),
                                  Text('Blocked Call'),
                                ],
                              ) :
                              item.callType.toString() == 'CallType.rejected' ?
                               Row(
                                children: [
                                  Icon(Icons.call_missed, size: 18, color: Colors.red),
                                  Text('Rejected call'),
                                ],
                              ) :
                              const SizedBox(),
                              const SizedBox(width: 8,),
                              //Text('${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)))}'),
                              Text('.  ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(item.timestamp!))}'),
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                Get.to(()=>UserProfile(
                                    item.name.toString(),
                                    item.number.toString(),
                                    mycl,mycl2)
                                );
                              },
                              child: const Padding(
                                padding:  EdgeInsets.all(5.0),
                                child:  Icon(Icons.keyboard_arrow_right),
                              )),
                        ),
                      );
                  }
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.themeColor,
        //   onPressed: () {
        //     print(children.length);
        //     // _showFormDialog();
        //   },
        //   child: Image.asset(
        //       'assets/images/ion_keypad.png', scale: 22, color: Colors.white),),
      ),
    );
  }
}


