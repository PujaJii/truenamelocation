// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truenamelocation/controller/images_upload_controller.dart';
import 'package:truenamelocation/controller/profile_update_controller.dart';


import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';
import 'no_internet.dart';


class CompleteProfile extends StatefulWidget {
  final List<dynamic> data;
  const CompleteProfile(var this.data);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
 // const CompleteProfile({Key? key}) : super(key: key);
  ImageUploadController controller = Get.put(ImageUploadController());
  ProfileUpdateController profileUpdateController = Get.put(ProfileUpdateController());
  final Connectivity _connectivity = Connectivity();
   ConnectivityResult? connectivityResult;
  final _formKey = GlobalKey<FormState>();

  getInternet() async {
    connectivityResult = await _connectivity.checkConnectivity();
  }
  @override
  void initState() {
    getInternet();
    profileUpdateController.first_name.text = widget.data[0].firstName.toString();
    profileUpdateController.last_name.text = widget.data[0].lastName.toString();
    profileUpdateController.email.text = widget.data[0].email.toString();
    profileUpdateController.birthDate.text =
    widget.data[0].birthdate.toString() == 'null'? '':widget.data[0].birthdate.toString();
    profileUpdateController.gender.text =
    widget.data[0].gender.toString() =='null'? '':widget.data[0].gender.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_rounded,color: Colors.black)),
          backgroundColor: AppColors.white),
      body: Obx(
         ()=> SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child:
                  filePath.value != ''?
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image:
                            FileImage(File(filePath.value))

                        ),
                        borderRadius: BorderRadius.circular(50)),
                  ):
                  widget.data[0].photo.toString() != ''?
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(widget.data[0].photo)),
                        borderRadius: BorderRadius.circular(50)),
                  ):
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: const DecorationImage(
                            image: AssetImage('assets/images/my_profile.jpg')
                        ),
                        borderRadius: BorderRadius.circular(50)),
                  ),
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
                      controller: profileUpdateController.first_name,
                      validator: (input) =>
                      input!.isEmpty ? 'First Name can\'t b empty' : null,
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
                      controller: profileUpdateController.last_name,
                      validator: (input) =>
                      input!.isEmpty ? 'Last Name can\'t b empty' : null,
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
                      controller: profileUpdateController.email,
                      validator: (input) =>
                      input!.isEmpty ? 'Email can\'t b empty' : null,
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
                      controller: profileUpdateController.birthDate,
                      // validator: (input) =>
                      // input!.isEmpty ? "Please Enter Birth Date" : null,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now()
                        );
                        if (pickedDate != null) {
                          print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            profileUpdateController.birthDate.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 13, color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0
                        ),
                        labelText: ' Birth date',
                        hintText: '  Enter your date of birth',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )
                        ),
                      )
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //       horizontal: 25, vertical: 10),
                //   child: TextFormField(
                //       //keyboardType: TextInputType.emailAddress,
                //       textInputAction: TextInputAction.done,
                //       controller: profileUpdateController.birthDate,
                //       // validator: (input) =>
                //       // input!.isEmpty ? "Please Enter birth date" : null,
                //       style: const TextStyle(fontSize: 15, color: Colors.black),
                //       decoration: InputDecoration(
                //         hintStyle: const TextStyle(color: Colors.black),
                //         fillColor: Colors.white,
                //         filled: true,
                //         contentPadding: const EdgeInsets.symmetric(
                //             horizontal: 16.0, vertical: 16.0),
                //         //  hintText: 'Enter Name',
                //         labelText: ' Birth date',
                //         labelStyle: const TextStyle(
                //             fontSize: 13,
                //             color: Colors.grey,
                //             fontStyle: FontStyle.normal),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: const BorderSide(
                //               color: Colors.black,
                //             )),
                //       )
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      controller: profileUpdateController.gender,
                      // validator: (input) =>
                      // input!.isEmpty ? "Please Enter gender" : null,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0
                        ),
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
                    if (_formKey.currentState!.validate()) {
                      if (connectivityResult == ConnectivityResult.none) {
                        // I am not connected to a network.
                        Get.offAll(()=> const NoInternet());
                      } else {
                        if(filePath.value != ''){
                          controller.imageUpdate(filePath.value);
                        }
                        profileUpdateController.updateProfile();
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                    child: const Center(child: Text('Save',
                        style: TextStyle(color: Colors.white,fontSize: 16))
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var imgName =''.obs;

  var filePath =''.obs;

  //File file = File('');
  void getImageGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      filePath.value = result.files.single.path!;
      imgName.value = result.files.single.name.toString();

    } else {
      // User canceled the picker
      MySnackbar.infoSnackBar(
          'No Image selected', 'Please select a image ');
    }
  }
}
