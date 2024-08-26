
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
  //String googleAPIKey = ;
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
