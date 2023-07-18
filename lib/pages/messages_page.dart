import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony.dart';
import '../pages/message_open.dart';
import '../pages/search_page.dart';

import '../styles/app_colors.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

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

  List<SmsMessage> _messages = [];
  Map<String, SmsMessage> uniqueMessages = {};
  Telephony telephony = Telephony.instance;
  String contactName = '';
  String unsavedName = '';
  String finalName = 'Unknown';
  bool isSaved = false;

  // void sendSms() {
  //   SmsSender sender = SmsSender();
  //   String address = "1234567890"; // Phone number of the recipient
  //   String message = "Hello, this is a test message!";
  //
  //   SmsMessage smsMessage = SmsMessage(address, message);
  //
  //   smsMessage.onStateChanged.listen((state) {
  //     if (state == SmsMessageState.Sent) {
  //       print("SMS is sent!");
  //     } else if (state == SmsMessageState.Delivered) {
  //       print("SMS is delivered!");
  //     }
  //   });
  //
  //   sender.sendSms(smsMessage);
  // }
  void fetchSmsMessages() async {
    Telephony telephony = Telephony.instance;
    List<SmsMessage> messages = await telephony.getInboxSms();

    Iterable<Contact> contacts = await ContactsService.getContacts();

    for (var message in messages) {

      String messageNumber =
      message.address.toString().length > 10?

      message.address.toString().substring(message.address.toString().length - 10):

      message.address.toString();

      // if (!messageNumber.startsWith('+91')) {
      //   messageNumber = '+91$messageNumber';
      // }
      // if (!messageNumber.startsWith('91')) {
      //   messageNumber = '91$messageNumber';
      // }

      for (var contact in contacts) {
        if(contact.phones != null){
          for (var phone in contact.phones!) {
            unsavedName = messageNumber;
            String trimPhone =
            phone.value.toString().length > 10?
            phone.value.toString().substring(phone.value.toString().length - 10):
            phone.value.toString();
            if (trimPhone == messageNumber)
            {
               // print('access2');
               // print(messageNumber);
               // print(phone.value);
               isSaved = true;
               contactName = contact.displayName??'';
               unsavedName = messageNumber;
              // print(contactName);
              break;
            }
            // else if(phone.value.toString() != messageNumber){
            //   // print('access1');
            //   // print(messageNumber);
            //   // print(phone.value);
            //   contactName = messageNumber;
            //   break;
            // }
            // else {
            //   print('access1');
            //   contactName = messageNumber;
            //   break;
            // }
          }
        }
      }

      // if(isSaved){
      //   print("From SAVED: $contactName");
      //   finalName = contactName;
      // }else{
      //   print("From: $unsavedName");
      //   finalName = unsavedName;
      // }
      isSaved= false;

      // print("Body: ${message.body}");
      // print("Date: ${message.dateSent}");
      // print("-----");
    }
  }


  Future<void> _getMessages() async {
    fetchSmsMessages();
    List<SmsMessage> messages = await telephony.getInboxSms(
        //columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        //filter: SmsFilter.,
       // sortOrder: [SmsColumn.DATE,]
        );
    setState(() {
      for (SmsMessage el in messages) {
        if (!uniqueMessages.containsKey(el.address)) {
          uniqueMessages[el.address!] = el;
        }
      }
      _messages = uniqueMessages.values.toList();
    });
  }
  
  @override
  void initState() {
    _getMessages();
    //fetchSmsMessages();
    super.initState();
  }

  // static List<SmsMessage> _removeDuplicateCallLogs(List<SmsMessage> sms) {
  //   final uniquePhoneNumbers = <String>{};
  //   final uniqueCallLogs = <SmsMessage>[];
  //   for (final el in sms) {
  //     if (!uniquePhoneNumbers.contains(el.address)) {
  //       uniquePhoneNumbers.add(el.address!);
  //       uniqueCallLogs.add(el);
  //     }
  //   }
  //   return uniqueCallLogs;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Column(
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
                                  image: AssetImage('assets/images/my_profile.jpg')
                              )
                          ),
                        ),
                        const Text('    Search numbers, names & more'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text('Total Messages (${_messages.length.toString()})'),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(()=> MessageOpen(name: _messages[index].address.toString(), number: _messages[index].address.toString(),));
                  },
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.themeColor,),
                        borderRadius: BorderRadius.circular(25),color: colors[index % colors.length],
                      ),
                      child: Icon(Icons.person,color: colors2[index % colors2.length]),
                    ),
                    title:
                    Text(_messages[index].address.toString(),style: const TextStyle(
                        fontSize: 14,)),
                    subtitle: _messages[index].body ==null || _messages[index].body!.isEmpty?
                    const Text(''):
                    Text(_messages[index].body!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    // Text(messages[index].address!.first.value.toString()),
                  ),
                );
              },),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          onPressed: () {

          },
          child: const Icon(Icons.message_sharp)
        ),
      ),
    );
  }
}
