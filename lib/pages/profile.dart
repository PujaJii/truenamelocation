import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/profile_fetch_controller.dart';
import '../pages/complete_profile.dart';


import '../pages/settings_page.dart';
import '../styles/app_colors.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  GoogleMapController? _mapController;
  ProfileFetchController profileUpdateController = Get.put(ProfileFetchController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {

    return GetX<ProfileFetchController>(initState: (context) {
      profileUpdateController.getProfileInfo();
     // profileUpdateController.getLocation();
    }, builder: (controller) {
      if (controller.isLoading.value) {
        // if(controller.hasLocation){
        //   location = true;
        // }
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        //print(location);
       // print('MyLatitude ${box.read('Latitude')}');
        return
          controller.userProfile.isEmpty?
          Container():
          Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text("${controller.userProfile[0].fullName.toString()}",
                style: const TextStyle(color: Colors.black)),
            actions: [
              InkWell(
                  onTap: () {
                    Get.to(() => const SettingsPage());
                  },
                  child: const Icon(Icons.settings,
                      color: Colors.blueGrey)),
              const SizedBox(
                width: 20,
              )
            ],
          ),
           body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                //  width: double.infinity,
                ),
                controller.userProfile[0].photo.toString() == '' || controller.userProfile[0].photo.toString() == 'null'?
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/my_profile.jpg')),
                      borderRadius: BorderRadius.circular(50)),
                ):
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: NetworkImage(controller.userProfile[0].photo.toString())),
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(controller.userProfile[0].mobile.toString(), style: const TextStyle(fontSize: 16)),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  //overlayColor: MaterialStateProperty.all(Colors.transparent),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.to(()=>  CompleteProfile(controller.userProfile));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(5)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 90, vertical: 0),
                    child: const Center(
                        child: Text('Complete your profile',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_outlined,
                                    color: Colors.redAccent,
                                  ),
                                  Text(' 15'),
                                ],
                              ),
                              Text('Total Spam Calls')
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    color: Colors.orange,
                                  ),
                                  Text(' 15'),
                                ],
                              ),
                              Text(' Unknown Callers')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                // box.read('Latitude') != null?
                // Container(
                //   height: 200,
                //   margin: const EdgeInsets.all(20),
                //   child: GoogleMap(
                //     onTap: (argument) {
                //       showDialog(context: context,
                //           barrierDismissible: true,
                //           builder: (BuildContext context) {
                //             return AlertDialog(
                //               title: Text(
                //                   "Open Location?", style: TextStyle(color: AppColors
                //                   .themeColor)),
                //               content: const Text(
                //                   "Want to see your exact location in map?"),
                //               actions: [
                //                 ElevatedButton(
                //                   onPressed: () async {
                //                     Get.to(()=> MapSample(lat: controller.latitude.value, long: controller.longitude.value,));
                //                   },
                //                   style: ButtonStyle(
                //                       backgroundColor: MaterialStateProperty.all(
                //                           AppColors.themeColor)),
                //                   child: const Text('Yes'),
                //                 ),
                //                 ElevatedButton(
                //                   style: ButtonStyle(
                //                       backgroundColor: MaterialStateProperty.all(
                //                           Colors.grey)
                //                   ),
                //                   onPressed: () {
                //                     Navigator.of(context).pop();
                //                   },
                //                   child: const Text("No"),
                //                 )
                //               ],
                //             );
                //           });
                //     },
                //     initialCameraPosition: CameraPosition(
                //       target: LatLng(controller.latitude.value,controller.longitude.value),
                //       zoom: 18.0,
                //     ),
                //     onMapCreated: (GoogleMapController controller) {
                //       _mapController = controller;
                //     },
                //     zoomGesturesEnabled: false,
                //     zoomControlsEnabled: false,/// this is for zoom in zoom out button !!!!!!!!
                //     markers: <Marker>{
                //       Marker(
                //         markerId: const MarkerId("specified_location"),
                //         position: LatLng(controller.latitude.value,controller.longitude.value),
                //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                //       ),
                //     },
                //   ),
                // ):
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Center(child: Text('Please turn on Location!')),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Column(
                    children: [
                       Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: AppColors.themeColor),
                          Text('      West Bengal, India')
                        ],
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                       Row(
                        children: [
                          Icon(Icons.notifications_none_outlined,
                              color: AppColors.themeColor),
                          Text('     Notification')
                        ],
                      ),
                      Divider(
                        color: Colors.grey[300],
                      ),
                       Row(
                        children: [
                          Icon(Icons.verified_user_outlined,
                              color: AppColors.themeColor),
                          Text('     Protect')
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Invite friends'),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      const Text('News'),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      const Text('Send Feedback'),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      const Text('FAQ')
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
