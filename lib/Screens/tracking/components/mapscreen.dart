// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';
//
// class MapScreen extends StatefulWidget {
//   MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled; don't continue.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied; don't continue.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are permanently denied; don't continue.
//       return Future.error('Location permissions are permanently denied');
//     }
//
//     // When we reach here, permissions are granted and we can continue accessing the user's location.
//     Position position = await Geolocator.getCurrentPosition();
//     _addMarker(position);
//   }
//
//   void _addMarker(Position position) {
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: MarkerId("current_location"),
//           position: LatLng(position.latitude, position.longitude),
//           infoWindow: InfoWindow(
//             title: 'Your Location',
//           ),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0), // Initial position will be overridden by _addMarker
//           zoom: 14.0,
//         ),
//         markers: _markers,
//       ),
//     );
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
// import 'package:nelayannet/influx.dart';
//
//
//
// class MapScreen extends StatefulWidget {
//   MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final LatLng _center = const LatLng(5.354630, 100.303000);
//   final Completer<GoogleMapController> _mapController = Completer();
//   final Map<String, Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserLocation();
//   }
//
//   void _getCurrentUserLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.deniedForever ||
//         permission == LocationPermission.denied) {
//       return; // Permission not granted. Handle this appropriately.
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     _updateMarker(position);
//   }
//
//   void _updateMarker(Position position) {
//     final marker = Marker(
//       markerId: const MarkerId('user_location'),
//       position: LatLng(position.latitude, position.longitude),
//       infoWindow: const InfoWindow(title: 'You are here.'),
//     );
//
//     setState(() {
//       _markers.clear(); // Clear old markers if you intend to allow refreshes or updates
//       _markers['user_location'] = marker;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//           Factory<OneSequenceGestureRecognizer>(
//                 () => EagerGestureRecognizer(),
//           ),
//         },
//         onMapCreated: (GoogleMapController controller) {
//           _mapController.complete(controller);
//         },
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11,
//         ),
//         markers: _markers.values.toSet(),
//       ),
//     );
//   }
// }


class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _center = const LatLng(5.354630, 100.303000);
  final Completer<GoogleMapController> _mapController = Completer();
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentUserLocation();
  }

  void _getCurrentUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return; // Permission not granted. Handle this appropriately.
    }

    // Position position = await Geolocator.getCurrentPosition();
    // _updateMarker(position);
    Position position = await Geolocator.getCurrentPosition();
    print("Current Position: ${position.latitude}, ${position.longitude}"); // Add this line
    _updateMarker(position);

  }

  void _updateMarker(Position position) {
    final marker = Marker(
      markerId: const MarkerId('user_location'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Marker color set to blue
      infoWindow: const InfoWindow(title: 'You are here.'),
    );

    setState(() {
      _markers.clear(); // Clear old markers if you intend to allow refreshes or updates
      _markers['user_location'] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 17,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}


// class MapScreen extends StatefulWidget {
//   MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _mapController = Completer();
//   final Map<String, Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserLocation();
//   }
//
//   void _getCurrentUserLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     if (permission == LocationPermission.deniedForever ||
//         permission == LocationPermission.denied) {
//       // Permission not granted. Handle this appropriately.
//       print('Location permission not granted');
//       return;
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     print("Current Position: ${position.latitude}, ${position.longitude}");
//     _updateMarker(position);
//   }
//
//   void _updateMarker(Position position) async {
//     final marker = Marker(
//       markerId: MarkerId('user_location'),
//       position: LatLng(position.latitude, position.longitude),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       infoWindow: InfoWindow(title: 'You are here.'),
//     );
//
//     setState(() {
//       _markers.clear();
//       _markers['user_location'] = marker;
//     });
//
//     // Move the camera to the user's current location
//     final GoogleMapController controller = await _mapController.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 15, // Adjust the zoom level as needed
//       ),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//           Factory<OneSequenceGestureRecognizer>(
//                 () => EagerGestureRecognizer(),
//           ),
//         },
//         onMapCreated: (GoogleMapController controller) {
//           _mapController.complete(controller);
//         },
//         initialCameraPosition: CameraPosition(
//           // Initial position is arbitrary; it will be updated to the user's location.
//           target: LatLng(0.0, 0.0),
//           zoom: 17,
//         ),
//         markers: _markers.values.toSet(),
//       ),
//     );
//   }
// }