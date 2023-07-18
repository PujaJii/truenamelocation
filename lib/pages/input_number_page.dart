import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/otp_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../styles/app_colors.dart';


class InputNumber extends StatelessWidget {
  const InputNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    OTPController otpController = Get.put(OTPController());

    return
      Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/images/main_logo.png'),
                    ),
                  ],
                ),const SizedBox(height: 40,),
                const Text('Enter Your Phone Number',style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'JacquesFrancois-Regular')),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child:
                  IntlPhoneField(
                    controller: otpController.number,
                    decoration: const InputDecoration(
                     // labelText: 'Phone Number',
                      prefixIcon: SizedBox(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  //print(otpController.number.text);
                  otpController.getOTP();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                child: const Center(child:  Text('Confirm',style: TextStyle(color: Colors.white,fontSize: 18))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
