import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';


class CompleteProfile extends StatelessWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black,
                image: const DecorationImage(
                    image: AssetImage('assets/images/my_profile.jpg')),
                borderRadius: BorderRadius.circular(50)),
          ),
          SizedBox(height: 25,),
          Text('Update your profile'),
          SizedBox(height: 25,),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 25, vertical: 10),
            child: TextFormField(
              //keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                //controller: profileUpdateController.first_name,
                validator: (input) =>
                input!.isEmpty ? "Please Enter First Name" : null,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
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
                //controller: profileUpdateController.last_name,
                validator: (input) =>
                input!.isEmpty ? "Please Enter Last Name" : null,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
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
                //controller: profileUpdateController.email,
                validator: (input) =>
                input!.isEmpty ? "Please Enter Email" : null,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
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
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 25, vertical: 10),
            child: TextFormField(
                //keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                //controller: profileUpdateController.email,
                validator: (input) =>
                input!.isEmpty ? "Please Enter birth date" : null,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  //  hintText: 'Enter Name',
                  labelText: ' Birth date',
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
                //controller: profileUpdateController.email,
                validator: (input) =>
                input!.isEmpty ? "Please Enter gender" : null,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  //  hintText: 'Enter Name',
                  labelText: ' Gender',
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
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Get.back();
              // if (_formKey.currentState!.validate()) {
              //   profileUpdateController.updateProfile();
              // }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: AppColors.themeColor,borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
              child: const Center(child:  Text('Save',style: TextStyle(color: Colors.white,fontSize: 16))),
            ),
          ),
        ],
      ),
    );
  }
  // String imgName ='';
  // String filePath ='';
  // File file = File('');
  // void getImage(ImageSource imageSource) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'pdf', 'doc'],
  //   );
  //   if (result != null) {
  //     filePath = result.files.single.path!;
  //     imgName = result.files.single.name.toString();
  //
  //   } else {
  //     // User canceled the picker
  //     MySnackbar.infoSnackBar(
  //         'No Image selected', 'Please select a image ');
  //   }
  // }
}
