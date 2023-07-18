import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_update_controller.dart';

import '../styles/app_colors.dart';



class InputDetails extends StatelessWidget {
  const InputDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final _formKey = GlobalKey<FormState>();
    ProfileUpdateController profileUpdateController = Get.put(ProfileUpdateController());

    return   Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 10,),
            Column(
              children: [
                const Text('Create Your Account',style: TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'JacquesFrancois-Regular')),
                const SizedBox(height: 40,),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: TextFormField(
                    //keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: profileUpdateController.first_name,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter First Name" : null,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.person,color: AppColors.themeColor2),
                        //suffixIcon: Icon(Icons.canc),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        //  hintText: 'Enter Name',
                        labelText: ' First Name',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: TextFormField(
                    //keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: profileUpdateController.last_name,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter Last Name" : null,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.person,color: AppColors.themeColor2),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        //  hintText: 'Enter Name',
                        labelText: ' Last Name',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      controller: profileUpdateController.email,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter Email" : null,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.mail,color: AppColors.themeColor2),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        //  hintText: 'Enter Name',
                        labelText: ' Email',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )),
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  profileUpdateController.updateProfile();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                child: const Center(child:  Text('Continue',style: TextStyle(color: Colors.white,fontSize: 16))),
              ),
            ),
            // const SizedBox(height: 10,),
            // const Text('Or',style: TextStyle(color: Colors.black,fontSize: 16)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 19),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 50,
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/images/google_logo.png'),
                      ),const SizedBox(width: 10),
                      const Center(child:  Text('  Google',
                        style: TextStyle(fontSize: 16),)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
