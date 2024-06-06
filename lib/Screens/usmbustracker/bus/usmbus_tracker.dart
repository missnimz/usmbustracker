
//-----------yang jadi tapi takleh keluar on gmaps and terpaksa kira ETA dengan fixed coordinates
/*
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/data_service.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart' hide LocationAccuracy;



class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  //Position? currentLocation; //ni for geolocator
  LocationData? currentLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  //Map<String, Marker> _markers = {};

  late InfluxDBManager influxDBManager; // Declare InfluxDBManager instance
  late Getfirstdata getFirstData; // Declare instances
  late Getsecdata getSecData;
  String? eta1;
  String? currentLocation1;
  String? eta2;
  String? currentLocation2;


  //static const LatLng sourceLocation = LatLng(5.3596, 100.3023); //komca - nanti try buang dulu
  //static const LatLng destinationLocation = LatLng(5.3585, 100.3045); //DKSK
  //LatLng? currentLocation;
  LatLng? sourceLocation; // New dynamic source location
  LatLng? destinationLocation;// New dynamic destination location

  //static const double thresholdDistance = 10.0; // 10 meters threshold for bus stop


  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
    //setPolylines();
    //getCurrentLocationAndUpdateMap();
    //_getCurrentUserLocation();

    influxDBManager = InfluxDBManager(
      'http://moby.cs.usm.my:8086',
      'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      'medinalab',
      'LoRASensors',
    );
    getFirstData = Getfirstdata(influxDBManager); // Initialize instances
    getSecData = Getsecdata(influxDBManager);

    fetchAndCalculateETA('sensor1', 'sensor2', getFirstData, getSecData); // Pass instances to fetchAndCalculateETA
    //fetchAndCalculateETA(getFirstData, getSecData);

  }



  //--------ni guna bila nak user location geolocator

  //Future<void> getCurrentLocation() async {
  void getCurrentLocation() async {
  Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newLoc) {
      setState(() {
        currentLocation = newLoc;
        if (newLoc.latitude != null && newLoc.longitude != null) {
          destinationLocation = LatLng(newLoc.latitude!, newLoc.longitude!);
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ));
        }
      });
    });
  }

/*
  void _getCurrentUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return; // Permission not granted. Handle this appropriately.
    }

    Position position = await Geolocator.getCurrentPosition();
    print("Current Position: ${position.latitude}, ${position.longitude}");
    //_updateLocation(position);

    //_googleMapController = await _controller.future;
    GoogleMapController googleMapController = await _controller.future;
    //_googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //CameraPosition(
        //zoom: 13.5,
        //target: LatLng(position.latitude, position.longitude),
      //),
    //)

    Geolocator.getPositionStream().listen((Position newPosition) {
      setState(() {
        currentLocation = LatLng(newPosition.latitude, newPosition.longitude);
        _updateLocation(newPosition);
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(newPosition.latitude, newPosition.longitude),
          ),
        ));
          if (sourceLocation != null && destinationLocation != null) {
          setPolylines(sourceLocation!, destinationLocation!);
      }}
      );
     });
    }

 */

/*
  LocationData latLngToLocationData(LatLng latLng) {
    return LocationData.fromMap({
      "latitude": latLng.latitude,
      "longitude": latLng.longitude,
      "accuracy": 0.0,
      "altitude": 0.0,
      "speed": 0.0,
      "speed_accuracy": 0.0,
      "heading": 0.0,
      "time": DateTime.now().millisecondsSinceEpoch,
    });
  }

  //void _updateLocation(Position position) {
    //final marker = Marker(
      //markerId: const MarkerId('user_location'),
      //position: LatLng(position.latitude, position.longitude),
      //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      //infoWindow: const InfoWindow(title: 'You are here.'),
    //);

    setState(() {
      _markers.clear(); // Clear old markers if you intend to allow refreshes or updates
      _markers['user_location'] = marker;
      destinationLocation = LatLng(position.latitude, position.longitude);
      //_updatePolylines(LatLng(position.latitude, position.longitude));
    });
  }

 */


  void setPolylines(LatLng source, LatLng destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            width: 5,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF63398F),
            points: polylineCoordinates,
            visible: true,
          ),
        );
      });
    }
  }



/*
  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      _polylines.add(
        Polyline(
          width: 5,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF63398F),
          points: polylineCoordinates,
          visible: true,
        ),
      );
    }
  }

 */

  final Map<String, List<Map<String, dynamic>>> busStopsByRoute = {
    'Laluan B': [
      {'name': 'Computer S', 'latitude': 5.354, 'longitude': 100.3027},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Komca', 'latitude': 5.360, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude':  100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      // Add more stops for Laluan B as needed
    ],
    'Laluan D': [
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},
      {'name': 'Komca', 'latitude': 5.360, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude':  100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Indah Kembara', 'latitude': 5.3560, 'longitude': 100.2953},
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},

      // Add more stops for Laluan D as needed
    ],
  };

  String? getCurrentBusStop(double latitude, double longitude, Map<String, List<Map<String, dynamic>>> busStopsByRoute) {
    //String? getCurrentBusStop(double latitude, double longitude) {
    for (var route in busStopsByRoute.values) {
      for (var stop in route) {
        final distance = Geolocator.distanceBetween(latitude, longitude, stop['latitude'], stop['longitude']);
        if (distance < 10) { // Consider 10 meters as the threshold for being at a bus stop
          return stop['name'];
        }
      }
    }
    return null;
  }


 Future<void> fetchAndCalculateETA(String sensor1, String sensor2, Getfirstdata getFirstData, Getsecdata getSecData) async {
   try {
      final data1 = await fetchData(sensor1,getFirstData, getSecData);
      final data2 = await fetchData(sensor2,getFirstData, getSecData);

      final currentBusStop1 = getCurrentBusStop(data1['latitude'], data1['longitude'], busStopsByRoute);
      final currentBusStop2 = getCurrentBusStop(data2['latitude'], data2['longitude'], busStopsByRoute);

      //final time = DateTime.now().millisecondsSinceEpoch / 1000.0; // Current time in seconds

      //final userPosition = await _getCurrentUserLocation(); // Get user's current location


      //final distance1 = Geolocator.distanceBetween(data1['latitude'], data1['longitude'], userPosition.latitude, userPosition.longitude); // Replace with actual destination
      //final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], userPosition.latitude, userPosition.longitude); // Replace with actual destination
      //final distance1 = Geolocator.distanceBetween(data1['latitude'], data1['longitude'], 5.356845999543331, 100.29439464321555);
      //final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], 5.356845999543331, 100.29439464321555); //compare dengan padang kawad
      final distance1 = Geolocator.distanceBetween(data1['latitude'], data1['longitude'], currentLocation!.latitude!, currentLocation!.longitude!);
      final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], currentLocation!.latitude!, currentLocation!.longitude!);
      print('Distance 1: $distance1 meters');
      print('Distance 2: $distance2 meters');

      final eta1 = calculateETA(distance1, fixedSpeed);
      final eta2 = calculateETA(distance2, fixedSpeed);
      print('ETA 1: $eta1 minutes');
      print('ETA 2: $eta2 minutes');



      setState(() {
        this.eta1 = eta1.toStringAsFixed(2); //eta1;
        this.currentLocation1 = "Now at ${currentBusStop1}";
         //this.currentLocation1 = "Now at (${data1['latitude'].toStringAsFixed(1)}, ${data1['longitude'].toStringAsFixed(2)})";
        //this.currentLocation1 = getCurrentBusStop(data1['latitude'], data1['longitude']) ?? "(${data1['latitude'].toStringAsFixed(1)}, ${data1['longitude'].toStringAsFixed(2)})";

        this.eta2 = eta2.toStringAsFixed(2); //eta2;
        this.currentLocation2 = "Now at ${currentBusStop2}";
        //this.currentLocation2 = "Now at (${data2['latitude'].toStringAsFixed(1)}, ${data2['longitude'].toStringAsFixed(2)})";
        //this.currentLocation2 = getCurrentBusStop(data2['latitude'], data2['longitude']) ?? "(${data2['latitude'].toStringAsFixed(1)}, ${data2['longitude'].toStringAsFixed(2)})";

        sourceLocation = LatLng(data1['latitude']!, data1['longitude']!);
        //destinationLocation = LatLng(data2['latitude'], data2['longitude']);
        if (sourceLocation != null && destinationLocation != null) {
          setPolylines(sourceLocation!, destinationLocation!);
        }
      });

      //setPolylines(sourceLocation!, destinationLocation!); // Update polylines with dynamic locations
    } catch (error) {
      print('Error fetching data: $error');
    }
  }


  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                currentLocation: currentLocation,
                //currentLocation: currentLocation != null ? latLngToLocationData(currentLocation!) : null,
                //markers: _markers,
                polylines: _polylines,
                sourceLocation: sourceLocation,
                destinationLocation: destinationLocation,
                //sourceLocation: sourceLocation!,
                //destinationLocation: destinationLocation!,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan B - Aman Damai', '115',
            currentLocation1,
            eta1,
            Color(0xFF389C9C),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan D - Padang Kawad', '116',
            currentLocation2,
            eta2,
            Color(0xFFE86464),
          ),

          SizedBox(height: 20),
           FloatingActionButton(
            onPressed: () async {
              //fetchAndPrintData();
              //await getdata.fetchAndPrintData();
              await getFirstData.fetchAndPrintData();
              await getSecData.fetchAndPrintData();
            },
            child: Icon(Icons.location_on),
          ),
            ]
      ),
    );
  }

  Widget _buildBusInfoContainer(String routeName, String busNumber, String? currentLocation, String? eta, Color color) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

   return Container(
      padding: EdgeInsets.all(16.0),
      //width: 100.0,
      //height: 150.0,
     width: screenWidth * 0.8, // Adjust this percentage as needed
     height: screenHeight * 0.2, // Adjust this percentage as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            routeName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.directions_bus_sharp, size: 40.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentLocation ?? 'Loading location...',
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                '${eta ?? 'Loading'} min',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2B0761),
                  fontSize: 23.0,
                ),
              ),
              //SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}

 */


//-----this one from github---

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/data_service.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/geolocator.dart' hide LocationAccuracy;



class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  //Position? currentLocation; //ni for geolocator
  //LocationData? currentLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  //Map<String, Marker> _markers = {};

  late InfluxDBManager influxDBManager; // Declare InfluxDBManager instance
  late Getfirstdata getFirstData; // Declare instances
  late Getsecdata getSecData;
  String? eta1;
  String? currentLocation1;
  String? eta2;
  String? currentLocation2;

  LatLng? curLocation;
  LatLng? sourceLocation; // New dynamic source location
  LatLng? destinationLocation;// New dynamic destination location

  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  //LatLng curLocation = LatLng(23.0525, 72.5667);
  StreamSubscription<loc.LocationData>? locationSubscription;

  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
    //setPolylines();
    //getCurrentLocationAndUpdateMap();
    //_getCurrentUserLocation();

    influxDBManager = InfluxDBManager(
      'http://moby.cs.usm.my:8086',
      'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      'medinalab',
      'LoRASensors',
    );
    getFirstData = Getfirstdata(influxDBManager); // Initialize instances
    getSecData = Getsecdata(influxDBManager);

    fetchAndCalculateETA('sensor1', 'sensor2', getFirstData, getSecData); // Pass instances to fetchAndCalculateETA
    //fetchAndCalculateETA(getFirstData, getSecData);

  }

getCurrentLocation() async {
bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 16,
        )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
              onTap: () {
                print('market tapped');
              },
            );
          });
          //getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  final Map<String, List<Map<String, dynamic>>> busStopsByRoute = {
    'Laluan B': [
      {'name': 'Computer S', 'latitude': 5.354, 'longitude': 100.3027},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Komca', 'latitude': 5.360, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude':  100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      // Add more stops for Laluan B as needed
    ],
    'Laluan D': [
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},
      {'name': 'Komca', 'latitude': 5.360, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude':  100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Indah Kembara', 'latitude': 5.3560, 'longitude': 100.2953},
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},

      // Add more stops for Laluan D as needed
    ],
  };

  String? getCurrentBusStop(double latitude, double longitude, Map<String, List<Map<String, dynamic>>> busStopsByRoute) {
    //String? getCurrentBusStop(double latitude, double longitude) {
    for (var route in busStopsByRoute.values) {
      for (var stop in route) {
        final distance = Geolocator.distanceBetween(latitude, longitude, stop['latitude'], stop['longitude']);
        if (distance < 10) { // Consider 10 meters as the threshold for being at a bus stop
          return stop['name'];
        }
      }
    }
    return null;
  }

  Future<void> fetchAndCalculateETA(String sensor1, String sensor2, Getfirstdata getFirstData, Getsecdata getSecData) async {
    try {
      final data1 = await fetchData(sensor1, getFirstData, getSecData);
      final data2 = await fetchData(sensor2, getFirstData, getSecData);

      //final currentBusStop1 = getCurrentBusStop(data1['latitude'], data1['longitude'], busStopsByRoute);
      //final currentBusStop2 = getCurrentBusStop(data2['latitude'], data2['longitude'], busStopsByRoute);

      final LatLng sensorLocation1 = LatLng(data1['latitude'], data1['longitude']);
      final LatLng sensorLocation2 = LatLng(data2['latitude'], data2['longitude']);

      _currentPosition = await location.getLocation();
      LatLng currentLocation = LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);

      // Calculate distance and ETA
      final distance1 = Geolocator.distanceBetween(
          sensorLocation1.latitude, sensorLocation1.longitude, currentLocation.latitude, currentLocation.longitude);
      final eta1 = calculateETA(distance1, fixedSpeed);

      final distance2 = Geolocator.distanceBetween(
          sensorLocation2.latitude, sensorLocation2.longitude, currentLocation.latitude, currentLocation.longitude);
      final eta2 = calculateETA(distance2, fixedSpeed);

      print('Distance 1: $distance1 meters');
      print('ETA 1: $eta1 minutes');
      print('Distance 2: $distance2 meters');
      print('ETA 2: $eta2 minutes');

      // Update directions on the map
      getDirections(sensorLocation1, currentLocation);

      setState(() {
        this.eta1 = eta1.toStringAsFixed(2);
        this.currentLocation1 = "Now at ${getCurrentBusStop(sensorLocation1.latitude, sensorLocation1.longitude, busStopsByRoute)}";

        this.eta2 = eta2.toStringAsFixed(2);
        this.currentLocation2 = "Now at ${getCurrentBusStop(sensorLocation2.latitude, sensorLocation2.longitude, busStopsByRoute)}";

        curLocation = currentLocation;
        sourceLocation = sensorLocation1;
        destinationLocation = currentLocation;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  getDirections(LatLng source, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'YOUR_API_KEY',
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: curLocation == null
          ? const Center(child: Text("Loading"))
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                currentLocation: curLocation,
                //currentLocation: currentLocation != null ? latLngToLocationData(currentLocation!) : null,
                //markers: _markers,
                polylines: _polylines,
                sourceLocation: sourceLocation,
                destinationLocation: destinationLocation,
                //sourceLocation: sourceLocation!,
                //destinationLocation: destinationLocation!,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan B - Aman Damai', '115',
            currentLocation1,
            eta1,
            Color(0xFF389C9C),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan D - Padang Kawad', '116',
            currentLocation2,
            eta2,
            Color(0xFFE86464),
          ),

          SizedBox(height: 20),
           FloatingActionButton(
            onPressed: () async {
              //fetchAndPrintData();
              //await getdata.fetchAndPrintData();
              await getFirstData.fetchAndPrintData();
              await getSecData.fetchAndPrintData();
            },
            child: Icon(Icons.location_on),
          ),
            ]
      ),
    );
  }

  Widget _buildBusInfoContainer(String routeName, String busNumber, String? currentLocation, String? eta, Color color) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

   return Container(
      padding: EdgeInsets.all(16.0),
      //width: 100.0,
      //height: 150.0,
     width: screenWidth * 0.8, // Adjust this percentage as needed
     height: screenHeight * 0.2, // Adjust this percentage as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            routeName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.directions_bus_sharp, size: 40.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentLocation ?? 'Loading location...',
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                '${eta ?? 'Loading'} min',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2B0761),
                  fontSize: 23.0,
                ),
              ),
              //SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}





/*----------using geolocator and user's current location------------(YG ATAS DAH MODIFY JADI CAMNI)
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/data_service.dart';
import 'package:geolocator/geolocator.dart';




class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  LocationData? currentLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  List<Map<String, dynamic>> busStops = [];
  List<String> etas = [];
  //Getfirstdata getFirstData = Getfirstdata();
  //Getsecdata getSecData = Getsecdata();
  late InfluxDBManager influxDBManager; // Declare InfluxDBManager instance
  late Getfirstdata getFirstData; // Declare instances
  late Getsecdata getSecData;
  double? eta1;
  String? currentLocation1;
  double? eta2;
  String? currentLocation2;


  static const LatLng sourcelocation = LatLng(5.3596, 100.3023); //komca
  static const LatLng destination = LatLng(5.3585, 100.3045); //DKSK

  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
    //fetchBusData();
    setPolylines();
    influxDBManager = InfluxDBManager(
      'http://moby.cs.usm.my:8086',
      'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      'medinalab',
      'LoRASensors',
    );
    getFirstData = Getfirstdata(influxDBManager); // Initialize instances
    getSecData = Getsecdata(influxDBManager);

    fetchAndCalculateETA('sensor1', 'sensor2', getFirstData, getSecData); // Pass instances to fetchAndCalculateETA

  }

  Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

  void getCurrentLocationAndUpdateMap() async {
    try {
      final position = await getCurrentLocation();

      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(position.latitude, position.longitude),
        ),
      ));

      setState(() {
        currentLocation = position;
      });
    } catch (error) {
      print('Error getting current location: $error');
    }
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      _polylines.add(
        Polyline(
          width: 5,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF63398F),
          points: polylineCoordinates,
          visible: true,
        ),
      );
    }
  }

  Future<void> fetchAndCalculateETA(String sensor1, String sensor2, Getfirstdata getFirstData, Getsecdata getSecData) async {
  try {
    final data1 = await fetchData(sensor1, getFirstData, getSecData);
    final data2 = await fetchData(sensor2, getFirstData, getSecData);

    final position = await getCurrentLocation();
    final double userLatitude = position.latitude;
    final double userLongitude = position.longitude;

    final time = DateTime.now().millisecondsSinceEpoch / 1000.0; // Current time in seconds

    final speed1 = calculateSpeed(data1['acceleration_x'], data1['acceleration_y'], data1['acceleration_z'], time);
    //final distance1 = calculateDistance(data1['latitude'], data1['longitude'], userLatitude, userLongitude);
    final distance1 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], userLatitude, userLongitude);
    final eta1 = calculateETA(distance1, speed1);

    final speed2 = calculateSpeed(data2['acceleration_x'], data2['acceleration_y'], data2['acceleration_z'], time);
    //final distance2 = calculateDistance(data2['latitude'], data2['longitude'], userLatitude, userLongitude);
    final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], userLatitude, userLongitude);
    final eta2 = calculateETA(distance2, speed2);

    setState(() {
      this.eta1 = eta1;
      this.currentLocation1 = "Now at (${data1['latitude'].toStringAsFixed(1)}, ${data1['longitude'].toStringAsFixed(2)})";
      this.eta2 = eta2;
      this.currentLocation2 = "Now at (${data2['latitude'].toStringAsFixed(1)}, ${data2['longitude'].toStringAsFixed(2)})";
    });
  } catch (error) {
    print('Error fetching data: $error');
  }
}


  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                currentLocation: currentLocation,
                polylines: _polylines,
                sourcelocation: sourcelocation,
                destination: destination,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan B - Aman Damai', '115',
            currentLocation1,
            eta1,
            Color(0xFF389C9C),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan D - Padang Kawad', '116',
            currentLocation2,
            eta2,
            Color(0xFFE86464),
          ),

          SizedBox(height: 20),
           FloatingActionButton(
            onPressed: () async {
              //fetchAndPrintData();
              //await getdata.fetchAndPrintData();
              await getFirstData.fetchAndPrintData();
              await getSecData.fetchAndPrintData();
            },
            child: Icon(Icons.location_on),
          ),
            ]
      ),
    );
  }

  Widget _buildBusInfoContainer(String routeName, String busNumber, String? currentLocation, double? eta, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 100.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            routeName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.directions_bus_sharp, size: 40.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentLocation ?? 'Loading location...',
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                '${eta?.toStringAsFixed(2) ?? 'Loading'} min',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2B0761),
                  fontSize: 23.0,
                ),
              ),
              //SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}







 */



/*-----------calculate ETAs and display name of bus stop----------------
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/data_service.dart';



class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  LocationData? currentLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  List<Map<String, dynamic>> busStops = [];
  List<String> etas = [];
  //Getfirstdata getFirstData = Getfirstdata();
  //Getsecdata getSecData = Getsecdata();
  double? eta1;
  String? currentLocation1;
  double? eta2;
  String? currentLocation2;


  static const LatLng sourcelocation = LatLng(5.3596, 100.3023); //komca
  static const LatLng destination = LatLng(5.3585, 100.3045); //DKSK

  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
    fetchBusData();
    setPolylines();
    //getdata.fetchData();
    fetchAndCalculateETA('sensor1', 'sensor2');

  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            ),
          ),
        ));

        setState(() {});
      },
    );
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      _polylines.add(
        Polyline(
          width: 5,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF63398F),
          points: polylineCoordinates,
          visible: true,
        ),
      );
    }
  }

  final Map<String, List<Map<String, dynamic>>> busStopsByRoute = {
  'Laluan B': [
    {'name': 'Aman Damai', 'latitude': 5.1234, 'longitude': 100.1234},
    {'name': 'Komca', 'latitude': 5.3596, 'longitude': 100.3023},
    {'name': 'DKSK', 'latitude': 5.3585, 'longitude': 100.3045},
    // Add more stops for Laluan B as needed
  ],
  'Laluan D': [
    {'name': 'Padang Kawad', 'latitude': 5.2345, 'longitude': 100.2345},
    {'name': 'Komca', 'latitude': 5.3596, 'longitude': 100.3023},
    {'name': 'DKSK', 'latitude': 5.3585, 'longitude': 100.3045},
    {'name': 'HBP', 'latitude': 5.3456, 'longitude': 100.3456},
    // Add more stops for Laluan D as needed
  ],
  // Add more routes here

  Future<void> fetchAndCalculateETA(String sensor1, String sensor2) async {
  try {
    final data1 = await fetchData(sensor1);
    final data2 = await fetchData(sensor2);

    // Example bus stop coordinates (you may need to adjust these)
    //final busStops = [
      //{'name': 'Komca', 'latitude': 5.3596, 'longitude': 100.3023},
      //{'name': 'DKSK', 'latitude': 5.3585, 'longitude': 100.3045},

      // Add more bus stops as needed
    //];

    final currentBusStop1 = getCurrentBusStop(data1['latitude'], data1['longitude'], busStops);
    final currentBusStop2 = getCurrentBusStop(data2['latitude'], data2['longitude'], busStops);

    final time = DateTime.now().millisecondsSinceEpoch / 1000.0; // Current time in seconds

    final speed1 = calculateSpeed(data1['acceleration_x'], data1['acceleration_y'], data1['acceleration_z'], time);
    final distance1 = calculateDistance(data1['latitude'], data1['longitude'], 5.3585, 100.3045); // Replace with actual destination
    final eta1 = calculateETA(distance1, speed1);

    final speed2 = calculateSpeed(data2['acceleration_x'], data2['acceleration_y'], data2['acceleration_z'], time);
    final distance2 = calculateDistance(data2['latitude'], data2['longitude'], 5.3585, 100.3045); // Replace with actual destination
    final eta2 = calculateETA(distance2, speed2);

    setState(() {
      this.eta1 = eta1;
      this.currentLocation1 = currentBusStop1;
      this.eta2 = eta2;
      this.currentLocation2 = currentBusStop2;
    });
  } catch (error) {
    print('Error fetching data: $error');
  }
}

String getCurrentBusStop(String routeName, double latitude, double longitude) {
  final List<Map<String, dynamic>> stops = busStopsByRoute[routeName] ?? [];
  for (var stop in stops) {
    final stopLatitude = stop['latitude'];
    final stopLongitude = stop['longitude'];
    final distance = calculateDistance(latitude, longitude, stopLatitude, stopLongitude);
    if (distance <= 0.01) { // Adjust this threshold as needed (0.01 is approximately 10 meters)
      return stop['name'];
    }
  }
  return 'Unknown'; // Default to 'Unknown' if no bus stop is within the threshold
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                currentLocation: currentLocation,
                polylines: _polylines,
                sourcelocation: sourcelocation,
                destination: destination,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan B - Aman Damai', '115',
            //currentlocation1,
            currentBusStop1
            eta1,
            Color(0xFF389C9C),
          ),
          _buildBusInfoContainer(
            'Laluan D - Padang Kawad', '116',
            //currentlocation2,
            currentBusStop2,
            eta2,
            Color(0xFFE86464),
          ),

          SizedBox(height: 20),

            ]
      ),
    );
  }

  Widget _buildBusInfoContainer(String routeName, String busNumber, String? currentLocation, double? eta, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 100.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            routeName,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.directions_bus_sharp, size: 40.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentLocation ?? 'Loading location...',
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                'ETA: ${eta?.toStringAsFixed(2) ?? 'Loading'} minutes',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2B0761),
                  fontSize: 23.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




 */

















/*----------------calculate ETAs (SECOND TRY)--------------
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';



class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  LocationData? currentLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  List<Map<String, dynamic>> busStops = [];
  List<String> etas = [];
  Getfirstdata getFirstData = Getfirstdata();
  Getsecdata getSecData = Getsecdata();


  static const LatLng sourcelocation = LatLng(5.3596, 100.3023); //komca
  static const LatLng destination = LatLng(5.3585, 100.3045); //DKSK

  @override
  void initState() {
    getCurrentLocation();
    polylinePoints = PolylinePoints();
    super.initState();
    fetchBusData();
    setPolylines();
    //getdata.fetchData();

  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLoc.latitude!,
              newLoc.longitude!,
            ),
          ),
        ));

        setState(() {});
      },
    );
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      _polylines.add(
        Polyline(
          width: 5,
          polylineId: PolylineId('polyLine'),
          color: Color(0xFF63398F),
          points: polylineCoordinates,
          visible: true,
        ),
      );
    }
  }

  Future<void> fetchBusData() async {
    try {
      await fetchETA();
      //await fetchBusStops();
      print('Data fetched successfully');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchETA() async {
    try {
      Map<String, double> firstData = await getFirstData.fetchfirstData();
      Map<String, double> secData = await getSecData.fetchsecData();

      setState(() {
        etas = [
          calculateETA(firstData).toString(),
          calculateETA(secData).toString(),
        ];
      });
      print('ETA data: $etas');
    } catch (e) {
      print('Error fetching ETA: $e');
    }
  }


  Future<void> fetchBusStops() async {
    final url = 'url'; // Replace with your PostgreSQL endpoint
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          busStops = List<Map<String, dynamic>>.from(data);
        });
        print('Bus stops data: $busStops');
      } else {
        throw Exception('Failed to fetch bus stops');
      }
    } catch (e) {
      print('Error fetching bus stops: $e');
    }
  }

  double calculateETA(Map<String, double> data) {
    const R = 6371e3; // Earth radius in meters
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final deltaPhi = (lat2 - lat1) * pi / 180;
    final deltaLambda = (lon2 - lon1) * pi / 180;

    final a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) *
            sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // distance in meters
  }

  double calculateDistance(double lat, double lng) {
    // Implement your logic to calculate distance from current location to the bus location
    return 5.0; // For simplicity, returning a fixed distance
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                currentLocation: currentLocation,
                polylines: _polylines,
                sourcelocation: sourcelocation,
                destination: destination,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildBusInfoContainer(
            'Laluan B - Aman Damai', '115',
            busStops.isNotEmpty ? busStops[0]['current_stop'] : 'N/A',
            etas.isNotEmpty ? etas[0] : 'N/A',
            Color(0xFF389C9C),
          ),
          SizedBox(height: 20),
           //FloatingActionButton(
            //onPressed: () async {
              //fetchAndPrintData();
              //await getdata.fetchAndPrintData();
              //await getFirstData.fetchAndPrintData();
              //await getSecData.fetchAndPrintData();
            //},
            //child: Icon(Icons.location_on),
          //),
            ]
      ),
    );
  }


  Widget _buildBusInfoContainer(String title, String busNumber, String currentStop, String eta, Color color) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 100.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.directions_bus_sharp, size: 40.0),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: color,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentStop,
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                eta,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2B0761),
                  fontSize: 23.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



 */
