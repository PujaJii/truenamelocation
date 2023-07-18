import 'package:flutter/material.dart';
import 'package:get/get.dart';



class MyAppBars {

  static AppBar myAppBar(String title,IconData icon) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Column(
        children: [
          Text(title,style: const TextStyle(color: Colors.black)),
          //Container(child: Text(subTitle,style: const TextStyle(color: Colors.grey))),
        ],
      ),
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_outlined,color: Colors.black)),
      actions: [
        Icon(icon,color: Colors.blueGrey),
        const SizedBox  (width: 20)
      ],
    );
  }
}
