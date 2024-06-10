
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
      final distance1 = Geolocator.distanceBetween(data1['latitude'], data1['longitude'], 5.356845999543331, 100.29439464321555);
      final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], 5.356845999543331, 100.29439464321555); //compare dengan padang kawad
      //final distance1 = Geolocator.distanceBetween(data1['latitude'], data1['longitude'], currentLocation!.latitude!, currentLocation!.longitude!);
      //final distance2 = Geolocator.distanceBetween(data2['latitude'], data2['longitude'], currentLocation!.latitude!, currentLocation!.longitude!);
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

//------new try------------------------------------------------------------
/*
import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'package:location/location.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/busdata_provider.dart';
import 'package:nelayannet/Services/distance_matrix_api.dart';




class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  //Set<Marker> _markers = {};
  //late BitmapDescriptor _busIcon;

  late InfluxDBManager influxDBManager; // Declare InfluxDBManager instance
  late Getfirstdata getFirstData; // Declare instances
  late Getsecdata getSecData;
  late BusDataProvider _busDataProvider;
  late Timer _timer;

  String? currentLocation1;
  String? eta1;
  String? currentLocation2;
  String? eta2;

  // Route and Bus stop selection variables
  String? selectedRoute;
  String? selectedBusStop;
  LatLng? destinationLatLng;
  double? selectedEta;
  final Map<String, Map<String, LatLng>> routes = {
    'laluan B': {
      'Comp Sc': LatLng(5.354, 100.3027),
      'Aman Damai': LatLng(5.355, 100.2969),
      'Komca': LatLng(5.360, 100.3022),
      'DKSK': LatLng(5.3593, 100.3046),
      'HBP': LatLng(5.3558, 100.3062),
    },
    'laluan D': {
      'Padang Kawad': LatLng(5.223, 100.556),
      'Komca': LatLng(5.360, 100.3022),
      'DKSK': LatLng(5.3593, 100.3046),
      'HBP': LatLng(5.3558, 100.3062),
      'Aman Damai': LatLng(5.355, 100.2969),
      'Indah Kembara': LatLng(5.3560, 100.2953),
    },
  };



  @override
  void initState() {

    super.initState();
     //_loadBusIcon();
    influxDBManager = InfluxDBManager(
      'http://moby.cs.usm.my:8086',
      'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      'medinalab',
      'LoRASensors',
    );
    getFirstData = Getfirstdata(influxDBManager); // Initialize instances
    getSecData = Getsecdata(influxDBManager);
    _busDataProvider = BusDataProvider(getFirstData, getSecData);
    // Fetch data periodically
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _busDataProvider.fetchBusData().then((_) {
        setState(() {
          if (selectedRoute != null && selectedBusStop != null) {
            selectedEta = _busDataProvider.routeEtas[selectedRoute]?[selectedBusStop];
          }
          currentLocation1 = getNearestBusStopName(_busDataProvider.routeEtas['route1']);
          eta1 = getEtaForNearestBusStop(_busDataProvider.routeEtas['route1']);
          currentLocation2 = getNearestBusStopName(_busDataProvider.routeEtas['route2']);
          eta2 = getEtaForNearestBusStop(_busDataProvider.routeEtas['route2']);
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  String? getNearestBusStopName(Map<String, double>? routeEtas) {
    if (routeEtas == null || routeEtas.isEmpty) {
      return null;
    }
    return routeEtas.keys.first;
  }

  String? getEtaForNearestBusStop(Map<String, double>? routeEtas) {
    if (routeEtas == null || routeEtas.isEmpty) {
      return null;
    }
    return routeEtas.values.first.toStringAsFixed(2);
  }


  Future<void> _updateEta() async {
    if (destinationLatLng != null && selectedRoute != null) {
      double busLat;
      double busLng;
      if (selectedRoute == 'laluan B') {
        busLat = _busDataProvider.firstBusData['latitude']!;
        busLng = _busDataProvider.firstBusData['longitude']!;
      } else {
        busLat = _busDataProvider.secBusData['latitude']!;
        busLng = _busDataProvider.secBusData['longitude']!;
      }
      double eta = await DistanceMatrixAPI.getEta(busLat, busLng, destinationLatLng!.latitude, destinationLatLng!.longitude);
      setState(() {
        selectedEta = eta;
      });
    }
  }

  void _onBusStopSelected(String route, String busStop) {
    setState(() {
      selectedRoute = route;
      selectedBusStop = busStop;
      destinationLatLng = routes[route]![busStop];
    });
    _updateEta();
  }


  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMapWidget(
                controller: _controller,
                busDataProvider: _busDataProvider,
              ),
            ),
          ),
        SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedRoute,
            hint: Text('Select Route'),
            items: routes.keys.map((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(key),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRoute = newValue;
                selectedBusStop = null;
                destinationLatLng = null;
                selectedEta = null;
              });
            },
          ),
          SizedBox(height: 20),
          if (selectedRoute != null)
            DropdownButton<String>(
              value: selectedBusStop,
              hint: Text('Select Bus Stop'),
              items: routes[selectedRoute!]!.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                _onBusStopSelected(selectedRoute!, newValue!);
              },
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

// ------GUNA dropdown-----

//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'package:location/location.dart';
//import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
//import 'package:nelayannet/influx.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:nelayannet/Screens/usmbustracker/bus/busdata_provider.dart';
//import 'package:nelayannet/Services/distance_matrix_api.dart';

/*
class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  //final Completer<GoogleMapController> _controller = Completer();
  //String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  //Set<Marker> _markers = {};
  //late BitmapDescriptor _busIcon;
  final String influxUrl = 'http://moby.cs.usm.my:8086';
  final String influxToken = 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==';
  final String influxOrg = 'medinalab';
  final String influxBucket = 'LoRASensors';
  final String firstDataMeasurement = 'AC1F09FFFE0037B5';

  InfluxDBManager? _influxDBManager;
  Getfirstdata? _getFirstData;
  Map<String, double> _busData = {};
  String selectedBusStop = 'BusStop1'; // Example bus stop
  int eta = 0; // ETA in seconds

  final Map<String, String> busStops = {
    'Comp Sc': '5.354,100.3027',
    'Aman Damai': '5.355,100.2969',
    'Komca': '5.360,100.3022',
    'DKSK': '5.3593,100.3046',
    'HBP': '5.3558,100.3062',
    'Padang Kawad': '5.3565,100.2943',
    'Indah Kembara': '5.3560, 100.2953',
  };


  @override
  void initState() {
    super.initState();
    //fetchData();
    _initializeInfluxDB();
    _startFetchingData();
    //_loadBusIcon();
  }


  void _initializeInfluxDB() {
    _influxDBManager = InfluxDBManager(influxUrl, influxToken, influxOrg, influxBucket);
    _getFirstData = Getfirstdata(_influxDBManager!);
  }

  void _startFetchingData() {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      if (_getFirstData != null) {
        var data = await _getFirstData!.fetchfirstData();
        setState(() {
          _busData = data;
        });
        calculateETA();  // Ensure we calculate ETA after fetching data
      }
    });
  }

  Future<void> calculateETA() async {
    if (_busData == null || !_busData!.containsKey('latitude') || !_busData!.containsKey('longitude')) {
      print('Bus data is not yet available.');
      return;
    }

    final distanceMatrixApi = DistanceMatrixApi('AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1Hw');
    final origin = '${_busData!['latitude']},${_busData!['longitude']}';
    final destination = busStops[selectedBusStop]!;
    try {
      eta = await distanceMatrixApi.getETA(origin, destination);
      setState(() {});
    } catch (e) {
      print('Failed to calculate ETA: $e');
    }
  }

  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }


  //@override
  //Widget build(BuildContext context) {

    print('Selected bus stop: $selectedBusStop');
    //print('Dropdown items: ${busStops.keys.join(', ')}');

    if (!busStops.containsKey(selectedBusStop)) {
      // If selectedBusStop is not in busStops, set it to the first key
      selectedBusStop = busStops.keys.first;
    }

    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              height: 300.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _busData != null
                    ? GoogleMapsWidget(busData: _busData!)
                    : Center(child: CircularProgressIndicator()),
                //GoogleMapsWidget(busData: _busData),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedBusStop,
              onChanged: (String? newValue) {
                if (newValue != null && newValue != selectedBusStop) {
                  setState(() {
                    selectedBusStop = newValue;
                    calculateETA();
                  });
                }
              },
              items: busStops.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text('Laluan B - Aman Damai'),
            Text('Bus Number: 115'),
            if (_busData.isNotEmpty)
              Column(
                children: [
                  Text('Current Location: (${_busData['latitude']}, ${_busData['longitude']})'),
                  Text('ETA: $eta seconds'),
                ],
              ),
          ],
      ),
    );
  }

  @override
  void dispose() {
    _influxDBManager?.close();
    super.dispose();
  }
}

  Widget _buildBusStopDropdown() {
    return DropdownButton<BusStop>(
      hint: Text('Select Bus Stop'),
      value: _selectedBusStop,
      onChanged: (BusStop newValue) {
        setState(() {
          _selectedBusStop = newValue;
          _updateETA();
        });
      },
      items: busStops.map((BusStop busStop) {
        return DropdownMenuItem<BusStop>(
          value: busStop,
          child: Text(busStop.name),
        );
      }).toList(),
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

 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/maps.dart';
import 'package:nelayannet/influx.dart';
import 'package:nelayannet/Services/distance_matrix_api.dart';
import 'package:nelayannet/Screens/usmbustracker/bus/data_service.dart';

class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  late InfluxDBManager influxDBManager; // Declare InfluxDBManager instance
  late Getfirstdata getFirstData; // Declare instances
  late Getsecdata getSecData;
  late DistanceMatrixApi distanceMatrixApi;
  final ValueNotifier<Set<Marker>> markers = ValueNotifier<Set<Marker>>({}); //boleh buang klu tkjdi
  String? eta1;
  String? currentLocation1;
  String? eta2;
  String? currentLocation2;
  LatLng? curLocation;
  Timer? timer;

  loc.Location location = loc.Location();
  Marker? sourcePosition;
  loc.LocationData? _currentPosition;
  StreamSubscription<loc.LocationData>? locationSubscription;

  String selectedBusStop = 'Comp Sc';
  int eta = 0;

  final Map<String, String> busStops = {
    'Comp Sc': '5.354,100.3027',
    'Aman Damai': '5.355,100.2969',
    'Komca': '5.360,100.3022',
    'DKSK': '5.3593,100.3046',
    'HBP': '5.3558,100.3062',
    'Padang Kawad': '5.3565,100.2943',
    'Indah Kembara': '5.3560, 100.2953',
  };

  final Map<String, List<Map<String, dynamic>>> busStopsByRoute = {
    'Laluan B': [
      {'name': 'Comp Sc', 'latitude': 5.354, 'longitude': 100.3027},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Komca', 'latitude': 5.3597, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude': 100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
    ],
    'Laluan D': [
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},
      {'name': 'Komca', 'latitude': 5.36, 'longitude': 100.3022},
      {'name': 'DKSK', 'latitude': 5.3593, 'longitude': 100.3046},
      {'name': 'HBP', 'latitude': 5.3558, 'longitude': 100.3062},
      {'name': 'Aman Damai', 'latitude': 5.355, 'longitude': 100.2969},
      {'name': 'Indah Kembara', 'latitude': 5.356, 'longitude': 100.2953},
      {'name': 'Padang Kawad', 'latitude': 5.3565, 'longitude': 100.2943},
    ],
  };

  @override
  void initState() {
    super.initState();
    fetchInitialBusLocation();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => updateBusMarker());
    selectedBusStop = busStops.keys.first;
    influxDBManager = InfluxDBManager(
      'http://moby.cs.usm.my:8086',
      'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      'medinalab',
      'LoRASensors',
    );
    getFirstData = Getfirstdata(influxDBManager); // Initialize instances
    getSecData = Getsecdata(influxDBManager);
    distanceMatrixApi = DistanceMatrixApi(googleAPIKey);

    getCurrentLocation();
    fetchAndCalculateETA('sensor1', 'sensor2', getFirstData,
        getSecData); // Pass instances to fetchAndCalculateETA
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) =>
        fetchAndCalculateETA('sensor1', 'sensor2', getFirstData, getSecData));
  }

  @override
  void dispose() {
    timer?.cancel();
    locationSubscription?.cancel();
    super.dispose();
  }

  getCurrentLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
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
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((loc.LocationData currentLocation) {
            controller?.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(
                      currentLocation.latitude!, currentLocation.longitude!),
                  zoom: 16,
                )));
            if (mounted) {
              controller?.showMarkerInfoWindow(
                  MarkerId(sourcePosition!.markerId.value));
              setState(() {
                curLocation = LatLng(
                    currentLocation.latitude!, currentLocation.longitude!);
                sourcePosition = Marker(
                  markerId: MarkerId(currentLocation.toString()),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  position: LatLng(
                      currentLocation.latitude!, currentLocation.longitude!),
                  infoWindow: InfoWindow(
                    onTap: () {
                      print('market tapped');
                    },
                  ),
                );
              });
            }
          });
    }
  }

  String? getCurrentBusStop(double latitude, double longitude,
      Map<String, List<Map<String, dynamic>>> busStopsByRoute) {
    for (var route in busStopsByRoute.values) {
      for (var stop in route) {
        final distance = Geolocator.distanceBetween(
            latitude, longitude, stop['latitude'], stop['longitude']);
        if (distance <
            10) { // Consider 10 meters as the threshold for being at a bus stop
          return stop['name'];
        }
      }
    }
    return null;
  }

  Future<void> fetchAndCalculateETA(String sensor1, String sensor2,
      Getfirstdata getFirstData, Getsecdata getSecData) async {
    try {
      final data1 = await fetchData(sensor1, getFirstData, getSecData);
      //final data2 = await fetchData(sensor2, getFirstData, getSecData);

      final LatLng sensorLocation1 = LatLng(
          data1['latitude'], data1['longitude']);
      //final LatLng sensorLocation2 = LatLng(
          //data2['latitude'], data2['longitude']);


      final selectedBusStopCoordinates = busStops[selectedBusStop];
      final selectedBusStopLatLng = LatLng(
        double.parse(selectedBusStopCoordinates!.split(',')[0]), // Latitude
        double.parse(selectedBusStopCoordinates.split(',')[1]), // Longitude
      );

      final eta1 = await distanceMatrixApi.getETA(
          sensorLocation1, selectedBusStopLatLng
      );

      print('ETA 1: $eta1 minutes');


      setState(() {
        this.eta1 = eta1.toStringAsFixed(2);
        this.currentLocation1 = "Now at ${getCurrentBusStop(
            sensorLocation1.latitude, sensorLocation1.longitude,
            busStopsByRoute)}";

        //this.eta2 = eta2.toStringAsFixed(2);
        //this.currentLocation2 = "Now at ${getCurrentBusStop(sensorLocation2.latitude, sensorLocation2.longitude, busStopsByRoute)}";
      });
    } catch (e) {
      print("Error: $e");
    }
  }
  //second time try utk the markers for bus (vaalue notifier)
  void fetchInitialBusLocation() async {
    try {
      final initialData = await getFirstData.fetchfirstData();
      if (initialData['latitude'] != null && initialData['longitude'] != null) {
        updateMarkers(LatLng(initialData['latitude']!, initialData['longitude']!));
      } else {
        print('Error: Received null coordinates');
      }
    } catch (e) {
      print('Error fetching initial bus location: $e');
    }
  }

  void updateBusMarker() async {
    try {
      final data = await getFirstData.fetchfirstData();
      if (data['latitude'] != null && data['longitude'] != null) {
        updateMarkers(LatLng(data['latitude']!, data['longitude']!));
      } else {
        print('Error: Received null coordinates');
      }
    } catch (e) {
      print('Error updating bus marker: $e');
    }
  }


  void updateMarkers(LatLng position) {
    markers.value = {
      Marker(
        markerId: MarkerId('bus'),
        position: position,
        infoWindow: InfoWindow(title: 'Bus Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
    };
  }

  void fetchAndPrintData() {
    getFirstData.fetchAndPrintData();
    getSecData.fetchAndPrintData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              height: 300.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GoogleMapWidget(
                  controller: _controller,
                  //influxDBManager: influxDBManager, //boleh try buang klau tk jadi
                  //getFirstData: getFirstData,
                  markers: markers,
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select Bus Stop'),
              value: selectedBusStop,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBusStop = newValue!;
                });
                fetchAndCalculateETA('sensor1', 'sensor2', getFirstData, getSecData); // Update ETA when bus stop changes
              },
              items: busStops.keys.map<DropdownMenuItem<String>>((String busStopName) {
                return DropdownMenuItem<String>(
                  value: busStopName,
                  child: Text(busStopName),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            _buildBusInfoContainer(
              'Laluan B - Aman Damai', '115',
              currentLocation1,
              eta1,
              Color(0xFF389C9C),
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


  Widget _buildBusInfoContainer(String routeName, String busNumber,
      String? currentLocation, String? eta, Color color) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: screenWidth * 0.8,
      // Adjust this percentage as needed
      height: screenHeight * 0.2,
      // Adjust this percentage as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            routeName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              const Icon(Icons.directions_bus_sharp, size: 40.0),
              const SizedBox(width: 16.0),
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
                      style: const TextStyle(fontSize: 19.0),
                    ),
                  ],
                ),
              ),
              Text(
                '${eta ?? 'Loading'} min',
                textAlign: TextAlign.right,
                style: const TextStyle(
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
