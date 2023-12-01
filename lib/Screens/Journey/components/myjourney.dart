import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nelayannet/influx.dart';

class Myjourney extends StatefulWidget {
  const Myjourney({Key? key}) : super(key: key);

  @override
  _MyjourneyState createState() => _MyjourneyState();
}

class _MyjourneyState extends State<Myjourney> {
  final LatLng _center = const LatLng(5.395181723989788, 100.24896674485227);
  final Completer<GoogleMapController> _mapController = Completer();
  Getdata data = Getdata();
  final Map<String, Marker> _marker = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];

  void updateMap() async {
    await data.getjourney();
    final GoogleMapController controller = await _mapController.future;
    if (data.myjourney.isNotEmpty) {
      setState(() {
        Marker marker;
        String converString;
        for (final location in data.myjourney) {
          polylineCoordinates.add(LatLng(location.lat, location.long));
          converString = location.time.toString();
          marker = Marker(
            markerId: MarkerId(location.time.toString()),
            position: LatLng(location.lat, location.long),
            infoWindow: InfoWindow(title: "Time $converString"),
          );
          _marker[converString] = marker;
        }
        Polyline polyline = Polyline(
            polylineId: const PolylineId("poly"),
            width: 2,
            color: const Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);
        _polylines.add(polyline);
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(data.myjourney[0].lat, data.myjourney[0].long),
              zoom: 11,
            ),
          ),
        );
      });
    }
  }

  Widget googlemap() {
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
        updateMap();
      },
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11,
      ),
      markers: _marker.values.toSet(),
      polylines: _polylines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          height: 445, //700
          child: googlemap(),
        ));
  }
}
