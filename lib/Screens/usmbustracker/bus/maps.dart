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
/*
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
    //locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
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

 */


//-------NEW TRY-------------

/*
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/busdata_provider.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final BusDataProvider busDataProvider;

  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.busDataProvider,
  }) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _googleMapController;
  Set<Marker> _markers = {};
  Location location = Location();

  @override
  void initState() {
    super.initState();
    widget.busDataProvider.addListener(_updateMarkers);
    _updateMarkers();
    _getLocation();

  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    widget.busDataProvider.removeListener(_updateMarkers);
    super.dispose();
  }

  Future<void> _getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _updateMap(userLocation.latitude!, userLocation.longitude!);
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(userLocation.latitude!, userLocation.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
        );
      });
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  void _updateMap(double latitude, double longitude) {
    if (_googleMapController != null) {
      _googleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 12.5,
          ),
        ),
      );
    }
  }


  void _updateMarkers() {
    Set<Marker> newMarkers = {};

    // Add markers for bus locations
    if (widget.busDataProvider.firstBusData.isNotEmpty) {
      newMarkers.add(
        Marker(
          markerId: MarkerId('firstBus'),
          position: LatLng(widget.busDataProvider.firstBusData['latitude']!, widget.busDataProvider.firstBusData['longitude']!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Bus 1'),
        ),
      );
    }

    if (widget.busDataProvider.secBusData.isNotEmpty) {
      newMarkers.add(
        Marker(
          markerId: MarkerId('secBus'),
          position: LatLng(widget.busDataProvider.secBusData['latitude']!, widget.busDataProvider.secBusData['longitude']!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: 'Bus 2'),
        ),
      );
    }

    setState(() {
      _markers = newMarkers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(0.0, 0.0), // Initial position, can be set to a more meaningful value
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
      markers: _markers,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
        ),
      },
    );
  }
}

 */ // this one is busdata provider

/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatelessWidget {
  final Map<String, double> busData;

  GoogleMapsWidget({required this.busData});

  @override
  Widget build(BuildContext context) {
    if (busData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final LatLng busPosition = LatLng(
        busData['latitude']!, busData['longitude']!);

    return GoogleMap(

      initialCameraPosition: CameraPosition(
        target: busPosition,
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('bus'),
          position: busPosition,
        ),
      },
    );
  }
}

 */

/*----------yang dah jadi tapi gerak random----
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';


class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;

  const GoogleMapWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}
class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final LatLng initialLocation; // Pass initial location as a parameter
  final Stream<Map<String, double>> sensorDataStream; // Sensor data stream

  const GoogleMapWidget({Key? key, required this.controller, required this.initialLocation, required this.sensorDataStream}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Set<Marker> _markers = {};
  LatLng initialLocation = LatLng(5.354, 100.3027);
  late Marker busMarker;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    busMarker = Marker(
      markerId: MarkerId('bus'),
      position: initialLocation,
      infoWindow: InfoWindow(title: 'Bus Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    _markers.add(busMarker);
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => updateBusMarker());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateBusMarker() {
    setState(() {
      // Update the bus marker position here based on your sensor data
      // For demonstration purposes, let's just move it randomly
      final newLocation = LatLng(
        initialLocation.latitude + (0.001 - (0.002 * (new Random().nextDouble()))),
        initialLocation.longitude + (0.001 - (0.002 * (new Random().nextDouble()))),
      );
      _markers.remove(busMarker);
      busMarker = Marker(
        markerId: MarkerId('bus'),
        position: newLocation,
        infoWindow: InfoWindow(title: 'Bus Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      _markers.add(busMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        widget.controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: 14.0,
      ),
      markers: _markers,
      myLocationEnabled: true,
    );
  }
}

 */


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final ValueNotifier<Set<Marker>> markers;

  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.markers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<Marker>>(
      valueListenable: markers,
      builder: (context, markers, _) {
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            this.controller.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: markers.isNotEmpty ? markers.first.position : LatLng(5.354, 100.3027),
            zoom: 16.0,
          ),
          markers: markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          tiltGesturesEnabled: true,
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },
        );
      },
    );
  }
}


/*-------------------------------nak try lain-----------
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final Completer<GoogleMapController> controller;
  final ValueNotifier<Set<Marker>> markers;

  const GoogleMapWidget({
    Key? key,
    required this.controller,
    required this.markers,
  }) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late ValueNotifier<double> _currentZoomLevel;

  @override
  void initState() {
    super.initState();
    _currentZoomLevel = ValueNotifier<double>(14.0); // Default zoom level
  }

  @override
  void dispose() {
    _currentZoomLevel.dispose();
    super.dispose();
  }

  void _onCameraMove(CameraPosition position) {
    _currentZoomLevel.value = position.zoom;
  }

  Future<void> _updateCameraPosition(LatLng newPosition) async {
    final controller = await widget.controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newPosition,
          zoom: _currentZoomLevel.value, // Use the saved zoom level
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<Marker>>(
      valueListenable: widget.markers,
      builder: (context, markers, _) {
        return ValueListenableBuilder<double>(
          valueListenable: _currentZoomLevel,
          builder: (context, zoomLevel, _) {
            return GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                widget.controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: markers.isNotEmpty
                    ? markers.first.position
                    : LatLng(5.354, 100.3027),
                zoom: zoomLevel,
              ),
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              onCameraMove: _onCameraMove,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                ),
              },
            );
          },
        );
      },
    );
  }
}

 */




















