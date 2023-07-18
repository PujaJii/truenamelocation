import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/input_number_page.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:permission_handler/permission_handler.dart';
import '../styles/app_colors.dart';



class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}
int _indicator = 0;
final LoopPageController _pageController = LoopPageController();


final List<String> _myList = [
  'Make calls more securely\nwith My Caller ID',
  'A trusted Platform\nfor making class',
  'Detect spam calls\neasily'
];

final List<String> images = [
  'assets/images/intro_a.gif',
  'assets/images/intro_b.gif',
  'assets/images/intro_c.gif',
];
class _IntroPageState extends State<IntroPage> {


  Future<void> getContactPermission() async {

   // await telephony.requestPhoneAndSmsPermissions;
    if (await Permission.notification.isGranted){
      //print(Permission.notification.isGranted);
    }
    else {
      await Permission.notification.request();
      //print('can not pick permission ...................');
      //print(Permission.notification.isGranted);
    }
    if (await Permission.contacts.isGranted) {

    } else {
      await Permission.contacts.request();
    }
    if (await Permission.phone.isGranted) {

    } else {
      await Permission.phone.request();
    }
    if (await Permission.location.isGranted) {

    } else {
      await Permission.location.request();
    }
  }

  @override
  void initState() {
    getContactPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //  const Text('i - Calling',style:  TextStyle(color: AppColors.themeColor,fontSize: 25,fontFamily: 'JacquesFrancois-Regular')),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/new_logo.png'),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: LoopPageView.builder(
                controller: _pageController,
                onPageChanged: (int value) {
                  setState((){
                    _indicator = value;
                  });
                },
                itemCount: _myList.length,
                itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //width: 90,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(images[index]))),
                    ), const SizedBox(height: 10,),
                    Center(
                      child: Text(_myList[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                    ),
                  ],
                );
              },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _myList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: _indicator == index? AppColors.themeColor: Colors.grey,),
                          ),);
                      },
              ),
            ),
            //const SizedBox(height: 20,),
             InkWell(
               onTap: () {
                   Get.to(()=>const InputNumber());
               },
               child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Center(child:  Text('Continue',style: TextStyle(color: Colors.white,fontSize: 18))),
                ),
             ),
            //const SizedBox(height: 2,),
          ],
        ),
      ),
    );
  }
}
