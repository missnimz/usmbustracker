/*
//import 'dart:async';
//import 'package:nelayannet/Services/detaillist.dart';
//import 'package:nelayannet/db/fish_spot.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:nelayannet/influx.dart';

//class LoadSpot extends StatefulWidget {
  //const LoadSpot({ Key? key }) : super(key: key);
  //@override
  //State<LoadSpot> createState() => _LoadSpotState();
//

class _LoadSpotState extends State<LoadSpot> {
  var user = Detail.information!.user;
  final LatLng _center = const LatLng(5.395181723989788, 100.24896674485227);
  final Completer<GoogleMapController> _mapController = Completer();
  Getdata data = Getdata();
  final Map<String, Marker> _marker = {};
  late BitmapDescriptor mapMarker;

  @override
   void initState() {
     super.initState();
     setcustommarker();
 }


 void setcustommarker() async {
  mapMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(10, 10)), 'assets/images/fish_icon.png');

 }

   void deletespot(int id){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Spot"),
            content: const Text(
                "Do you want to delete this spot"),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("No"),
              ),
              TextButton(onPressed: () async{
                await Fishing_spot_Database.instances.delete(id);
                Navigator.of(context).pop();
                spotdeleted();

              }, child: const Text("Yes")),
            ],
          );
        });
  }

  void spotdeleted() {
    showDialog(
      context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Spot Deleted Successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _marker.clear();
                  });
                  updateMap();
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  void updateMap() async {
    await data.getcurrentlocation();
    var allspot = await Fishing_spot_Database.instances.readAllSpot(user!.name as String);
    final GoogleMapController controller = await _mapController.future;
    if (data.mylocation != null && allspot.isNotEmpty) {
      setState(() {
        _marker.clear();
        Marker marker;
        marker = Marker(
          markerId: MarkerId(data.mylocation!.measurement),
          position: LatLng(data.mylocation!.lat, data.mylocation!.long),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: "You are here."
            ),
        );
        _marker[data.mylocation!.measurement] = marker;
        for (final spot in allspot) {
          marker = Marker(
            markerId: MarkerId(spot.createdTime.toString()),
            position: LatLng(spot.latitude,spot.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: "Tap this window to delete this fishing spot",
              snippet: "Current location is (${spot.longitude}, ${spot.latitude})",
              onTap: (){
                deletespot(spot.id as int);
              },
            )
            );
          _marker[spot.createdTime.toString()] = marker;
        }
      });
    }
    else if (data.mylocation != null){
      setState(() {
        Marker marker;
        marker = Marker(
          infoWindow: const InfoWindow(
            title: "You are here."
            ),
          markerId: MarkerId(data.mylocation!.measurement),
          position: LatLng(data.mylocation!.lat, data.mylocation!.long),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
        _marker[data.mylocation!.measurement] = marker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    );
  }
} */