import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _mapController;
//   final Location _location = Location();
//   late LatLng _currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     _location.onLocationChanged.listen((LocationData currentLocation) {
//       setState(() {
//         _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Example'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(37.422, -122.084), // Set initial position to Googleplex
//           zoom: 14.0,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _mapController = controller;
//         },
//         markers: _currentPosition != null ?
//         <Marker>{
//           Marker(
//             markerId: const MarkerId("current_location"),
//             position: _currentPosition,
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//           ),
//         }
//             : <Marker>{},
//       ),
//     );
//   }
// }


class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  GoogleMapController? _mapController;
  final LatLng _specifiedLocation = const LatLng(23.5415699,87.3058403); // Specify the desired location coordinates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _specifiedLocation,
          zoom: 18.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        zoomControlsEnabled: false,/// this is for zoom in zoom out button !!!!!!!!
        markers: <Marker>{
          Marker(
            markerId: const MarkerId("specified_location"),
            position: _specifiedLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        },
      ),
    );
  }





  // final Completer<GoogleMapController> _controller =
  // Completer<GoogleMapController>();
  //
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(23.555750, 87.274270),
  //   zoom: 10.4746,
  // );
  //
  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(23.529240, 87.351593),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: GoogleMap(
  //       mapType: MapType.normal,
  //       initialCameraPosition: _kGooglePlex,
  //       onMapCreated: (GoogleMapController controller) {
  //         _controller.complete(controller);
  //       },
  //     ),
  //     // floatingActionButton: FloatingActionButton.extended(
  //     //   onPressed: _goToTheLake,
  //     //   label: const Text('To the DGP!'),
  //     //   icon: const Icon(Icons.directions_boat),
  //     // ),
  //   );
  // }
  //
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}