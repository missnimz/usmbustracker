/*
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
//import 'package:geolocator/geolocator.dart';

class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final LocationData? currentLocation;
  //final Set<Polyline> polylines;
  //final LatLng sourcelocation;
  //final LatLng destination;
  //final Position? currentLocation;
  final Set<Polyline> polylines;
  final LatLng sourceLocation;
  final LatLng destinationLocation;



  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.currentLocation,
    required this.polylines,
    required this.sourceLocation,
    required this.destinationLocation,
  }) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentLocation == null
        ? const Center(child: Text("Loading"))
        : GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.currentLocation!.latitude!,
          widget.currentLocation!.longitude!,
          //widget.currentLocation!.latitude,
          //widget.currentLocation!.longitude,
        ),
        zoom: 15,
      ),
      onMapCreated: (controller) {
        widget.controller.complete(controller);
        _googleMapController = controller;
      },
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
      polylines: widget.polylines,
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(
            widget.currentLocation!.latitude!,
            widget.currentLocation!.longitude!,
            //widget.currentLocation!.latitude,
            //widget.currentLocation!.longitude,
          ),
        ),
        Marker(
          markerId: const MarkerId("source"),
          //position: widget.sourcelocation,
          position: widget.sourceLocation,

        ),
        Marker(
          markerId: const MarkerId("destination"),
          //position: widget.destination,
          position: widget.destinationLocation,
        ),
      },
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
        ),
      },
    );
  }

}
 */

//ABOVE IS ORIGINAL CODE

//-------new with user's location

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final LocationData? currentLocation;
  //final Set<Polyline> polylines;
  //final LatLng sourcelocation;
  //final LatLng destination;
  //final Position? currentLocation;
  final Set<Polyline> polylines;
  final LatLng? sourceLocation;
  final LatLng? destinationLocation;
  //final Map<String, Marker> markers;


  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.currentLocation,
    //required this.markers,
    required this.polylines,
    this.sourceLocation,
    this.destinationLocation,

  }) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController?.dispose();
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.currentLocation == null
        ? const Center(child: Text("Loading"))
        : GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
        target: LatLng(
        //widget.currentLocation!.latitude!,
        //widget.currentLocation!.longitude!,
          widget.currentLocation?.latitude ?? 0.0,
          widget.currentLocation?.longitude ?? 0.0,
        //widget.currentLocation!.latitude,
        //widget.currentLocation!.longitude,
    ),
        zoom: 13.5,
      ),
      onMapCreated: (controller) {
        widget.controller.complete(controller);
        _googleMapController = controller;
      },
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
      polylines: widget.polylines,
      markers: {
        //Marker(
          //markerId: const MarkerId("currentLocation"),
          //position: LatLng(
            //widget.currentLocation!.latitude!,
            //widget.currentLocation!.longitude!,
            //widget.currentLocation!.latitude,
            //widget.currentLocation!.longitude,
          //),
        //),
        Marker(
          markerId: const MarkerId("source"),
          //position: widget.sourcelocation,
          //position: widget.sourceLocation!,
            position: widget.sourceLocation ?? LatLng(0.0, 0.0),
            infoWindow: InfoWindow(
            title: "Bus Location",
            )
        ),
        Marker(
          markerId: const MarkerId("destination"),
          //position: widget.destination,
          //position: widget.destinationLocation!,
            position: widget.destinationLocation ?? LatLng(0.0, 0.0),
            infoWindow: InfoWindow(
              title: "User Location",
            )

        ),
      },
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
        ),
      },
    );
  }
}






//-----new with geolocator
/*
class GoogleMapWidget extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final Position? currentLocation;
  final Set<Polyline> polylines;
  final LatLng sourceLocation;
  final LatLng destinationLocation;

  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.currentLocation,
    required this.polylines,
    required this.sourceLocation,
    required this.destinationLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        zoom: 13.5,
      ),
      polylines: polylines,
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        ),
        Marker(
          markerId: const MarkerId("source"),
          position: sourceLocation,
        ),
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationLocation,
        ),
      },
      onMapCreated: (mapController) {
        controller.complete(mapController);
      },
    );
  }
}

 */


