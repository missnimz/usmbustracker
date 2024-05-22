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
  //String googleAPIKey = "AIzaSyBWnK3AgGcC03klFrIz3mSPaCWkecBKRFM";
  String googleAPIKey = "AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY";
  //late GoogleMapController _googleMapController;
  GoogleMapController? _googleMapController;
  Timer? _timer;
  LocationData? currentLocation;

  //List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  //to fetch ETA and busstops from backend (LATESTTT!!)
  List<Map<String, dynamic>> busStops = [];
  List<String> etas = [];



  static const LatLng destination = LatLng(
      5.3596,  100.3023); //komca
  static const LatLng sourcelocation = LatLng(
      5.3585, 100.3045); //DKSK








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

      _polylines.add(
            Polyline(
                width: 5,
                polylineId: PolylineId('polyLine'),
                color: Color(0xFF63398F),
                points: polylineCoordinates,
                visible: true
        )
      );

    }
  }



  @override
  void initState() {
    getCurrentLocation();
    //startTimer();
    //getPolyPoints();
    polylinePoints = PolylinePoints();
    super.initState();
    fetchData();
    setPolylines();

  }



  @override
  void dispose() {
    //_timer?.cancel();
    _googleMapController?.dispose();
    super.dispose();
  }

/* ORIGINAL CODE
  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );
  }
  */

  void getCurrentLocation() async{
    Location location = Location();

    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
            (newLoc)
        {
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



  Future<void> fetchData() async {
    await fetchETA();
    await fetchBusStops();
  }

  Future<void> fetchETA() async {
    final url = 'YOUR_INFLUXDB_API_ENDPOINT'; // Replace with your InfluxDB endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        etas = data.map((e) => e['eta'].toString()).toList();
      });
    } else {
      throw Exception('Failed to fetch ETA');
    }
  }

  Future<void> fetchBusStops() async {
    final url = 'YOUR_POSTGRESQL_API_ENDPOINT'; // Replace with your PostgreSQL endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        busStops = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to fetch bus stops');
    }
  }





  @override
  Widget build(BuildContext context) {

    //setPolylines();

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
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                          _googleMapController = controller;
                        },

                      /*onMapCreated: (controller) =>
                      _googleMapController = controller,*/
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      polylines: _polylines,


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
                          markerId: const MarkerId("currentLocation"),
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        const Marker(
                          markerId: MarkerId("source"),
                          position: sourcelocation,
                        ),
                        const Marker(
                          markerId: MarkerId("destination"),
                          position: destination,
                        )
                      }


                  ),
                ),

              ),
              SizedBox(height: 20,),
              _buildBusInfoContainer('Laluan B - Aman Damai', '115', busStops.isNotEmpty ? busStops[0]['current_stop'] : 'N/A', etas.isNotEmpty ? etas[0] : 'N/A', Color(0xFF389C9C)),
              SizedBox(height: 20,),
              _buildBusInfoContainer('Laluan D - Padang Kawad', '116', busStops.isNotEmpty ? busStops[1]['current_stop'] : 'N/A', etas.isNotEmpty ? etas[1] : 'N/A', Color(0xFFE86464)),
              SizedBox(height: 20,),
              _buildBusInfoContainer('Laluan E - Restu', '117', busStops.isNotEmpty ? busStops[2]['current_stop'] : 'N/A', etas.isNotEmpty ? etas[2] : 'N/A', Color(0xFFF79C25)),
            ]
            )
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
                    fontSize: 23.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
              //SizedBox(height: 15,),
