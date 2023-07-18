import 'package:flutter/material.dart';




class MessageOpen extends StatelessWidget {
  final String name,number;
  const MessageOpen({Key? key, required this.name, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
       body: ListView.builder(
         itemCount: 10,
         itemBuilder: (context, index) {
         return Row(
           children: [
             Container(
               // height: 50,
               // width: 50,
               margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
               padding: const EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: Colors.grey,
                 borderRadius: BorderRadius.circular(5)
               ),

               child: Text('demo text',style: TextStyle(color: Colors.white)),
             ),
           ],
         );
       },)
    );
  }
}
