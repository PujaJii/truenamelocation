import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '../pages/bottom_nav_page.dart';
import '../pages/input_details.dart';
import '../pages/intro_page.dart';
import 'no_internet.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _box = GetStorage();
  final Connectivity _connectivity = Connectivity();
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
    Timer(const Duration(seconds : 2), () async {

      ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
      // AuthService().handleAuthState();
      if (connectivityResult == ConnectivityResult.none) {
        // I am not connected to a network.
        Get.offAll(()=> const NoInternet());

      } else {
        if(_box.read('isVerified') == true){

          if(_box.read('isRegistered')== true){
            Get.off(()=> const BottomNavPage());
          }else{
            Get.off(()=> const InputDetails());
          }
        }else{
          Get.off(()=> const IntroPage());
        }
      }


    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/images/sized_logo.png'),
            ),
            // const Text('true NameLocations',style:  TextStyle(
            //     color: AppColors.themeColor,
            //     fontSize: 25,
            //     fontFamily: 'JacquesFrancois-Regular')),
          ],
        ),
      ),
    );
  }
}
