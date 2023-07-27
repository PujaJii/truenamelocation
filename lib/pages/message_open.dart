import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';




class MessageOpen extends StatefulWidget {
  final String name,number;
  const MessageOpen({Key? key, required this.name, required this.number}) : super(key: key);

  @override
  State<MessageOpen> createState() => _MessageOpenState();
}

class _MessageOpenState extends State<MessageOpen> {
  Telephony telephony = Telephony.instance;
  List<SmsMessage> messagesFilter = [];
  // List<SmsMessage> messagesSent = [];

  Future<void> _getMessages() async {
     messagesFilter = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.ADDRESS)
          .equals(widget.number),
      // sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
      //   OrderBy(SmsColumn.BODY)]
    );
    setState(() {});
  }

  // Future<List<SmsMessage>> fetchSentBoxMessages() async {
  //
  //   try {
  //     // Fetch messages from the sent box
  //     messagesSent = await telephony.getSentSms();
  //
  //     // Sort the messages by date (optional)
  //     messagesSent.sort((a, b) => b.dateSent!.compareTo(a.dateSent!.toDouble()));
  //   } catch (e) {
  //     print("Error fetching sent box messages: $e");
  //   }
  //   return messagesSent;
  // }

  @override
  void initState() {
    _getMessages();
    super.initState();
  }
  // Future<List<SmsMessage>> fetchMessages() async {
  //   List<SmsMessage> sentMessages = [];
  //   List<SmsMessage> inboxMessages = [];
  //
  //   try {
  //     // Fetch sent messages
  //     sentMessages = await telephony.getSentSms();
  //
  //     // Fetch inbox messages
  //     inboxMessages = await telephony.getInboxSms();
  //
  //     // Combine sent and inbox messages
  //     List<SmsMessage> allMessages = [...sentMessages, ...inboxMessages];
  //
  //     // Sort the messages by date
  //     //allMessages.sort((a, b) => b.dateSent!.compareTo(a.dateSent!));
  //
  //     return allMessages;
  //   } catch (e) {
  //     print("Error fetching messages: $e");
  //     return [];
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
       body:
       // FutureBuilder<List<SmsMessage>>(
       //   future: fetchMessages(),
       //   builder: (context, snapshot) {
       //     if (snapshot.connectionState == ConnectionState.waiting) {
       //       return Center(child: CircularProgressIndicator());
       //     } else if (snapshot.hasError) {
       //       return Center(child: Text('Error loading messages'));
       //     } else {
       //       final messages = snapshot.data ?? [];
       //       return ListView.builder(
       //         reverse: true, // To display the latest messages at the bottom
       //         itemCount: messages.length,
       //         itemBuilder: (context, index) {
       //           final message = messages[index];
       //           return ListTile(
       //             title: Text(message.body!),
       //            // subtitle: Text("Sent at: ${message.dateSent!}"),
       //             // You can customize the ListTile UI based on message status (sent or received)
       //             // For example, you can use condition to display different colors/icons for sent and received messages.
       //           );
       //         },
       //       );
       //     }
       //   },
       // ),

       ListView.builder(
         itemCount: messagesFilter.length,
         itemBuilder: (context, index) {
         return Row(
           children: [
             Expanded(
               child: Container(
                 margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                 padding: const EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: Colors.grey[300],
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: Text(messagesFilter[index].body.toString(),),
               ),
             ),
           ],
         );
       },)
    );
  }
}
