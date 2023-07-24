// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import '../apis/profile_fetch_api.dart';

import '../models/profile_fetch_model.dart';



class ProfileFetchController extends GetxController{

  // late final LatLng specifiedLocation;

  var latitude = 13.726045.obs;
  var longitude = 65.633425.obs;
  var isLoading = false.obs;
  //final box = GetStorage();
  var userProfile = <ProfileData>[].obs;
  // var apiResponse1;

  getProfileInfo() async {
    try {
      isLoading(true);
      var apiResponse = await ProfileFetchApi.fetchProfile();
      if (apiResponse != null) {
        if (apiResponse.status == 200) {
          userProfile.assignAll(apiResponse.data!);
          print(userProfile);
          //await getLocation();
          //print('my verification status..............${apiResponse.userinfo!.profile!.isVerified}');
        }
      }
    } finally {
      isLoading(false);
    }
  }
  // getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are disabled
  //     rememberLocation();
  //     return;
  //   }
  //
  //   // Request location permission
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     // Location permissions are permanently denied
  //     rememberLocation();
  //     return;
  //   }
  //
  //   if (permission == LocationPermission.denied) {
  //     // Location permissions are denied but can be requested
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
  //       // Location permissions are denied
  //       rememberLocation();
  //       return;
  //     }
  //   }
  //
  //   // Get the current position
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   // Retrieve latitude and longitude
  //   latitude.value = await position.latitude;
  //   longitude.value = await position.longitude;
  //
  //   // Do something with the latitude and longitude
  //   print('Latitude: $latitude');
  //   print('Longitude: $longitude');
  //   box.write('Latitude', latitude.value);
  //   box.write('Longitude', longitude.value);
  //  // specifiedLocation = await LatLng(latitude,longitude);
  // }
  // rememberLocation(){
  //   if(box.read('Latitude') != null){
  //     latitude.value = box.read('Latitude');
  //     longitude.value = box.read('Longitude');
  //   }
  // }
}