
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/splash_screen.dart';

import '../styles/app_colors.dart';




class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity,),
          const Text('You are not connected to internet! Please retry!'),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              //SystemNavigator.pop();
              Get.offAll(()=> SplashScreen());
            },
            child: const Text('Retry!'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
          )
        ],
      ),
    );
  }
}