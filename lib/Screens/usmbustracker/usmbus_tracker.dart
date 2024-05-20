import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
//import 'bus_stops.dart';


class USMBusTracker extends StatefulWidget {
  const USMBusTracker({Key? key}) : super(key: key);

  @override
  _USMBusTrackerState createState() => _USMBusTrackerState();
}

class _USMBusTrackerState extends State<USMBusTracker> {
  final Completer<GoogleMapController> _controller = Completer();
  String googleAPIKey = "AIzaSyBWnK3AgGcC03klFrIz3mSPaCWkecBKRFM";
  late GoogleMapController _googleMapController;
  Timer? _timer;
  LocationData? currentLocation;

  //List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;


  static const LatLng sourcelocation = LatLng(
      5.358797630070934, 100.30462869947357); //DKSK
  static const LatLng destination = LatLng(
      5.35966286693899, 100.30226835557534); //Komca




  /*final List<Map<String, dynamic>> busStops = [
    {'name': 'DKSK', 'lat': 5.3590, 'lng': 100.3047, 'busNumber': '115', 'status': 'Now at DKSK', 'eta': '10 min'},
    {'name': 'Komca', 'lat': 5.4764, 'lng': 100.4860, 'busNumber': '116', 'status': 'Now at Komca', 'eta': '5 min'},
    {'name': 'Restu', 'lat': 5.3565, 'lng': 100.2933, 'busNumber': '117', 'status': 'Now at Restu', 'eta': '30 min'},
    // Add more bus stops here
  ]; */

  /*
  final List<Map<String, dynamic>> busStops = [
    // Route for bus number 115 - Laluan B-Aman Damai
    {
      'route': 'Laluan B - Aman Damai',
      'name': 'Aman Damai',
      'lat': 5.3619,
      'lng': 100.3143,
      'busNumber': '115',
      'status': 'Now at Aman Damai',
      'eta': '5 min'
    },
    {
      'route': 'Laluan B - Aman Damai',
      'name': 'Komca',
      'lat': 5.4764,
      'lng': 100.4860,
      'busNumber': '115',
      'status': 'Now at Komca',
      'eta': '10 min'
    },
    {
      'route': 'Laluan B - Aman Damai',
      'name': 'DKSK',
      'lat': 5.3590,
      'lng': 100.3047,
      'busNumber': '115',
      'status': 'Now at DKSK',
      'eta': '15 min'
    },
    {
      'route': 'Laluan B - Aman Damai',
      'name': 'HBP',
      'lat': 5.3528,
      'lng': 100.3124,
      'busNumber': '115',
      'status': 'Now at HBP',
      'eta': '20 min'
    },
    {
      'route': 'Laluan B - Aman Damai',
      'name': 'Aman Damai',
      'lat': 5.3619,
      'lng': 100.3143,
      'busNumber': '115',
      'status': 'Now at Aman Damai',
      'eta': '25 min'
    },

    // Route for bus number 116 - Laluan D
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'Pdg Kawad',
      'lat': 5.3769,
      'lng': 100.4075,
      'busNumber': '116',
      'status': 'Now at Pdg Kawad',
      'eta': '5 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'Komca',
      'lat': 5.4764,
      'lng': 100.4860,
      'busNumber': '116',
      'status': 'Now at Komca',
      'eta': '10 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'DKSK',
      'lat': 5.3590,
      'lng': 100.3047,
      'busNumber': '116',
      'status': 'Now at DKSK',
      'eta': '15 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'HBP',
      'lat': 5.3528,
      'lng': 100.3124,
      'busNumber': '116',
      'status': 'Now at HBP',
      'eta': '20 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'Aman Damai',
      'lat': 5.3619,
      'lng': 100.3143,
      'busNumber': '116',
      'status': 'Now at Aman Damai',
      'eta': '25 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'Indah Kembara',
      'lat': 5.3723,
      'lng': 100.3967,
      'busNumber': '116',
      'status': 'Now at Indah Kembara',
      'eta': '30 min'
    },
    {
      'route': 'Laluan D - Padang Kawad',
      'name': 'Pdg Kawad',
      'lat': 5.3769,
      'lng': 100.4075,
      'busNumber': '116',
      'status': 'Now at Pdg Kawad',
      'eta': '35 min'
    },

    // Route for bus number 117 - Laluan E
    {
      'route': 'Laluan E - RST',
      'name': 'Restu',
      'lat': 5.3565,
      'lng': 100.2933,
      'busNumber': '117',
      'status': 'Now at Restu',
      'eta': '5 min'
    },
    {
      'route': 'Laluan E - RST',
      'name': 'Saujana',
      'lat': 5.3533,
      'lng': 100.2656,
      'busNumber': '117',
      'status': 'Now at Saujana',
      'eta': '15 min'
    },
    {
      'route': 'Laluan E - RST',
      'name': 'Tekun',
      'lat': 5.3603,
      'lng': 100.2778,
      'busNumber': '117',
      'status': 'Now at Tekun',
      'eta': '25 min'
    },
  ]; */

  /*
  void startTimer() {
    Timer.periodic(Duration(seconds: 30), (timer) {
      //updateETA(); // Call updateETA every 30 seconds
    });
  } */



  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(
            sourcelocation.latitude,
            sourcelocation.longitude
          //currentLocation.latitude,
          //currentLocation.longitude
        ),
        PointLatLng(
            destination.latitude,
            destination.longitude
        )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
            Polyline(
                width: 20,
                polylineId: PolylineId('polyLine'),
                color: Color(0xFF08A5CB),
                points: polylineCoordinates,
                visible: true
            )
        );
      });
    }
  }
  /* void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
    );

    if(result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude)
      ),
      );
      setState(() {});

      }
  }*/


  @override
  void initState() {
    getCurrentLocation();
    //startTimer();
    //getPolyPoints();
    polylinePoints = PolylinePoints();
    super.initState();
  }

  //_getLocation();
  //}


  @override
  void dispose() {
    //_timer?.cancel();
    _googleMapController.dispose();
    super.dispose();
  }

  /*void _getLocation() async {
    var location = Location();
    _currentLocation = await location.getLocation();
  }*/

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );
  }

  /*
  Future<void> updateETA() async {
    final url = 'https://641c03929b82ded29d5de382.mockapi.io/ETA'; // Replace with your mockapi.io endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        for (var i = 0; i < busStops.length; i++) {
          var updatedETA = data[i]['eta']; // Assuming your mockapi.io response is an array with updated ETA values
          busStops[i]['eta'] = updatedETA.toString();
        }
      });
    } else {
      throw Exception('Failed to fetch updated ETA');
    }
  }*/



  @override
  Widget build(BuildContext context) {
    // Filter the busStops list to include only entries with bus numbers 115, 116, and 117
    /*final filteredBusStops = busStops.where((busStop) =>
    busStop['busNumber'] == '115' ||
        busStop['busNumber'] == '116' ||
        busStop['busNumber'] == '117'
    ).toList();*/
    setPolylines();

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
                  child:
                  GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 10,
                      ),
                      onMapCreated: (controller) =>
                      _googleMapController = controller,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,


                      /*polylines: {
                      Polyline(polylineId: PolylineId("route"),
                        points: polylineCoordinates,
                        color: const Color(0xFF63398F),
                        width: 6,
                        visible: true,

                      )
                    },*/

                      /*markers: Set<Marker>.from(busStops.map((busStop) => Marker(
                      markerId: MarkerId(busStop['name']),
                      position: LatLng(busStop['lat'], busStop['lng']),
                      infoWindow: InfoWindow( title: 'Bus ${busStop['busNumber']}',
                        snippet: '${busStop['status']} - ETA: ${busStop['eta']}',),
                      icon: BitmapDescriptor.defaultMarker,
                    ))),*/
                      markers: {
                        Marker(
                          markerId: MarkerId("currentLocation"),
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        /*Marker(
                          markerId: MarkerId("source"),
                          position: sourcelocation,
                        ),*/
                        Marker(
                          markerId: MarkerId("destination"),
                          position: destination,
                        )
                      }


                  ),
                ),

              ),
              //SizedBox(height: 15,),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16.0),
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 5), // Offset
                    ),
                  ],// Border width
                  //color: Colors.blue,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Laluan B - Aman Damai',
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
                                '115',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF389C9C),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //SizedBox(height: 5.0),
                              Text(
                                'Now at DKSK',
                                style: TextStyle(fontSize: 19.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '10 min',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF2B0761),
                              fontSize: 23.0),
                        ),
                      ],
                    ),
                  ],),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16.0),
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 5), // Offset
                    ),
                  ],// Border width
                  //color: Colors.blue,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Laluan D - Padang Kawad',
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
                                '116',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFE86464),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //SizedBox(height: 5.0),
                              Text(
                                'Now at Komca',
                                style: TextStyle(fontSize: 19.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '5 min',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF2B0761),
                              fontSize: 23.0),
                        ),
                      ],
                    ),
                  ],),
              ),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16.0),
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 5), // Offset
                    ),
                  ],// Border width
                  //color: Colors.blue,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Laluan E - RST',
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
                                '117',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFF79C25),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //SizedBox(height: 5.0),
                              Text(
                                'Now at Restu',
                                style: TextStyle(fontSize: 19.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '20 min',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF2B0761),
                              fontSize: 23.0),
                        ),
                      ],
                    ),
                  ],),
              ),

              /*
          ]
            ..addAll(
              List.generate(
                filteredBusStops.length,
                    (index) => buildBusStops(context, index, filteredBusStops),
              ),
            ),
            */

            ])
    );
  }
}
