import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import '../styles/common_module/app_bar.dart';
import 'package:intl/intl.dart';

import '../styles/app_colors.dart';



class ViewAll extends StatefulWidget {
   final String name, number;
   const ViewAll(this.name,this.number, {Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  void initState() {
    getAllLogs();
    super.initState();
  }
  List<CallLogEntry> entry = [];
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  Future<void> getAllLogs() async {
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
        number: widget.number
    );
    setState(() {
      _callLogEntries = result;
      //isLoading = true;
    });

    for(CallLogEntry eachCalls in _callLogEntries){
      entry.add(eachCalls);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar ('Call History',Icons.delete),
      body: ListView.builder(
        itemCount: entry.length,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text('    ${widget.number}',style: const TextStyle(fontSize: 17)),
            Row(
              children: [
                entry[index].callType.toString() == 'CallType.incoming' ?
                const Row(
                  children: [
                    Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                    Text('Received Call'),
                  ]
                ) :
                entry[index].callType.toString() == 'CallType.outgoing' ?
                const Row(
                  children: [
                    Icon(Icons.call_made, size: 18,),
                    Text('Outgoing Call'),
                  ],
                ) :
                entry[index].callType.toString() == 'CallType.missed' ?
                const Row(
                  children: [
                    Icon(Icons.call_missed, size: 18, color: Colors.red),
                    Text('Missed Call'),
                  ],
                ) :
                entry[index].callType.toString() == 'CallType.blocked' ?
                const Row(
                  children: [
                    Icon(Icons.block, size: 18, color: Colors.blue),
                    Text('Blocked Call'),
                  ],
                ) :
                entry[index].callType.toString() == 'CallType.rejected' ?
                const Row(
                  children: [
                    Icon(Icons.call_missed, size: 18, color: Colors.red),
                    Text('Rejected call'),
                  ],
                ) :
                const SizedBox(),
                const SizedBox(width: 8,),
                //Text('${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)))}'),
                Text('.  ${DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(entry[index].timestamp!))}'),
              ],
            ),
          ],
        );
      },),
    );
  }
}
