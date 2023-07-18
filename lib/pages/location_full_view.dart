import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../pages/bottom_nav_page.dart';

import '../styles/app_colors.dart';


class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  const MapSample({super.key, required this.lat, required this.long});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  GoogleMapController? _mapController;
  //final LatLng _specifiedLocation = const LatLng(23.5415699,87.3058403); // Specify the desired location coordinates

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Location View'),
        content: const Text('Do you want to exit?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
            child:const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Get.offAll(()=> BottomNavPage()),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
            child:const Text('Yes'),
          ),
        ],
      ),
    )??false; //if showDialog had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat,widget.long),
            zoom: 18.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          //zoomControlsEnabled: false,/// this is for zoom in zoom out button !!!!!!!!
          markers: <Marker>{
            Marker(
              markerId: const MarkerId("specified_location"),
              position: LatLng(widget.lat,widget.long),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          },
        ),
      ),
    );
  }
}