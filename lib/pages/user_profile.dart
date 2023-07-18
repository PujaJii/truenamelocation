import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import '../pages/view_all.dart';
import 'package:intl/intl.dart';

import '../styles/app_colors.dart';



class UserProfile extends StatefulWidget {
 // const UserProfile({Key? key}) : super(key: key);
  final String name,number;
  final Color color, color2;
  const UserProfile(this.name,this.number,this.color,this.color2, {Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}


class _UserProfileState extends State<UserProfile> {


  @override
  void initState() {
    getAllLogs();
    super.initState();
  }

  // final List<Widget> _children = <Widget>[];
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

    for(CallLogEntry eachCalls in _callLogEntries)
    {
      entry.add(eachCalls);
    }
  }
  @override
  Widget build(BuildContext context) {
    //print(color);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,)),

              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title:
                  widget.name == 'null'|| widget.name == '' ?
                  const Text('Unknown Number',
                      style: TextStyle(
                        color: Colors.black, fontSize: 16.0,)):
                  Text(widget.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  background: Stack(
                    //alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 145,
                        color: Colors.teal,),
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.only(
                              top: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.only(
                              top: 40),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.white,
                                width: 2),
                              borderRadius: BorderRadius.circular(40),
                              color: widget.color
                          ),
                          child: Center(child:
                          widget.name == 'null' || widget.name == '' ?
                           Text(
                            'U', style: TextStyle(color: widget.color2, fontSize: 30),)
                              :
                           Text(((widget.name).substring(0, 1)),
                            style:  TextStyle(color: widget.color2, fontSize: 30),)
                          ),
                        ),
                      ),


                    ],
                  )
              ),
            ),

          ];
        },
        body: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(child: Text(widget.number)),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _callNumber(widget.number);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                           // color: color,
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.call,color: Colors.green),
                        ),
                      ),
                      const Text('Call'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          //color: color,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),

                        ),
                        child: const Icon(Icons.chat,color: Colors.green),
                      ),
                      const Text('Message'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          //color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Icon(Icons.report,color: Colors.green),
                      ),
                      const Text('Spam'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          //color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Icon(Icons.block,color: Colors.green),
                      ),
                      const Text('Block'),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                height: 160,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loc.png'))),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const  BorderRadius.all(Radius.circular(8))),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.fromLTRB(20,20,0,20),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text('       West Bengal, India')
                      ],
                    ),
                    Divider(color: Colors.grey[300],),
                    const Row(
                      children: [
                        Icon(Icons.mail_outline_sharp),
                        Expanded(child: Text('       username.tnts@gmail.com'))
                      ],
                    ),
                    Divider(color: Colors.grey[300],),
                    Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/images/whtsapp_ab.png',)),
                        const Text('     WhatsApp')
                      ],
                    ),
                    Divider(color: Colors.grey[300],),
                    Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/images/tele_logo_a.png',)),
                        const Text('     Telegram')
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 210,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius:
                    const  BorderRadius.all(Radius.circular(8))
                ),
                 margin: const EdgeInsets.all(20),
                 padding: const EdgeInsets.fromLTRB(20,20,0,5),
                 child: Column(
                   children: [
                     Expanded(
                       child: ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount:
                          entry.length < 3?
                              entry.length:
                          3,
                          itemBuilder: (context, index) {
                          //print(_callLogEntries.length);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.number,style: const TextStyle(fontSize: 16),),
                              Row(
                                children: [
                                  entry[index].callType.toString() == 'CallType.incoming' ?
                                  const Row(
                                    children: [
                                      Icon(Icons.call_received, size: 18, color: AppColors.themeColor,),
                                      Text('Received Call'),
                                    ],
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
                              Divider(color: Colors.grey[300],),
                            ],
                          );
                        } ,),
                     ),
                     InkWell(
                       onTap: () {
                         // if (_formKey.currentState!.validate()) {
                         Get.to(()=> ViewAll(widget.name,widget.number));
                         // }
                       },
                       child: const SizedBox(
                         height: 40,
                         child: Center(child:  Text('View All',style: TextStyle(color: Colors.green,fontSize: 16))),
                       ),
                     ),
                   ],
                 ),
              ),
            ],
          ),
        )
      ),
    );
  }

  _callNumber(var number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}

