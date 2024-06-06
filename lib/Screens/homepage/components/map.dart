//import 'dart:async';
//import 'dart:collection';
//import 'package:nelayannet/Model/fishing_spot.dart';
//import 'package:nelayannet/db/fish_spot.dart';
//import 'package:nelayannet/influx.dart';
//import 'package:nelayannet/Model/fishermans_model.dart';
//import 'package:nelayannet/Model/sensors_model.dart';
//import 'package:nelayannet/Model/vessels_model.dart';
//import 'package:nelayannet/Services/detaillist.dart';
//import 'package:nelayannet/Services/shared_services.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';

/*
class ViewMap extends StatefulWidget {
  const ViewMap({Key? key}) : super(key: key);

  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  //var vessel_area = Detail.information!.vessel;
  final Set<Circle> _circle = HashSet<Circle>();
  final double radius = 1000;
  Getdata getdata = Getdata();
  late GoogleMapController newGoogleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  late Timer timer;
  final Map<String, Marker> _marker = {};
  final LatLng _center = const LatLng(5.391506068975898, 100.18547448576305);
  final FloatingSearchBarController controlSearch =
      FloatingSearchBarController();
  List<String> filtered = [];
  final List<String> _searchHistory = [];
  static const int historyLength = 5;
  late String selectedTerm;
  late Timer _timer;
  List<String> alluser = [];

  @override
  void initState() {
    setCircle();
    super.initState();
    filtered = filterSearchTerms(filter: null);

    getusers();
    timer = Timer.periodic(const Duration(seconds: 300), (Timer t) {
      updateLocationOnMap();
    });
    super.initState();
  }

  void getusers() async {
    UserList user = Listuser.userList as UserList;

    for (final x in user.data!) {
      alluser.add(x.name as String);
    }
  }

  bool checkuser(String user) {
    if (user == getdata.mylocation?.measurement) {
      return true;
    }
    return false;
  }

  String _searchuser(String sensoreui) {
    UserList? users = Listuser.userList;
    VesselList? vessels = Listvessel.vesselList;
    SensorList? sensors = Listsensor.sensorlist;

    bool search = sensors?.data!.any((element) => element.eui == sensoreui) as bool;
    if (search){
      var searchsensor =
        sensors?.data!.firstWhere((element) => element.eui == sensoreui);
    int vesselId = searchsensor?.attachedToVesselId as int;
    var searchvessel =
        vessels?.data!.firstWhere((element) => element.id == vesselId);
    int? userId = searchvessel?.captainId;
    var searchuser = users?.data!.firstWhere((element) => element.id == userId);
    String username = searchuser?.name as String;
    return username;
    } else {
      return "no user";
    }
    
    
  }

  bool check_area() {
    if (Detail.information!.vessel ==null){
      return true;
    }
    return false;
  }

  void setCircle() {
    bool areaExists = check_area();
    var vesselArea = Detail.information!.vessel;
    _circle.add(Circle(
      circleId: const CircleId("Center"),
      center: areaExists ? _center : LatLng(vesselArea![0].siteLocationLat as double, vesselArea[0].siteLocationLng as double),
      radius: radius,
      strokeColor: Colors.black,
      strokeWidth: 1,
    ));
  }

  bool _userExist(String user) {
    UserList? everyuser = Listuser.userList;
    VesselList? vessels = Listvessel.vesselList;
    SensorList? sensors = Listsensor.sensorlist;
    bool search = everyuser?.data!.any((element) => element.name==user) as bool;
    if (!search){
      return false;
    }
    var searchuser =
        everyuser?.data!.firstWhere((element) => element.name == user);
    if(searchuser?.id== null) {
      return false;
    }
    int userId = searchuser?.id as int;
    bool vesselexists = vessels?.data!.any((element) => element.ownerId == userId) as bool;
    if (!vesselexists){
      return false;
    }
    var searchvessel =
        vessels?.data!.firstWhere((element) => element.ownerId == userId);
    if(searchvessel?.id== null) {
      return false;
    }
    int vesselId = searchvessel?.id as int;
    bool sensorexists = sensors?.data!.any((element) => element.attachedToVesselId == vesselId) as bool;
    if (!sensorexists) {
      return false;
    }
    var searchsensor = sensors?.data!
        .firstWhere((element) => element.attachedToVesselId == vesselId);
    if(searchsensor?.eui==null){
      return false;
    }
    String eui = searchsensor?.eui as String;

    for (final x in getdata.userlocation) {
      if (eui == x.measurement) {
        return true;}
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          _timer = Timer(const Duration(seconds: 5), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            title: const Text("Warning"),
            content: const Text(
                "You are already out of Zone A, Please go back into Zone A"),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("Close"),
              )
            ],
          );
        }).then((value) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  void updateLocationOnMap() async {
    final GoogleMapController controller = await _controller.future;
    await getdata.getUserLocation();
    if (kDebugMode) {
      print("This is udate location");
    }
    if (!mounted) return;
    setState(() {
      _marker.clear();
      Marker marker;
      late LatLng userloc;

      for (final x in getdata.userlocation) {
        bool isUser = checkuser(x.measurement);
        String name = "";
        double distancediff = 0;
        double? mylat = getdata.mylocation?.lat;
        double? mylong = getdata.mylocation?.long;
        if (!isUser) {
          name = _searchuser(x.measurement);
          if(mylat!=null){
            distancediff = double.parse((Geolocator.distanceBetween(
                      mylat,
                      mylong!,
                      x.lat,
                      x.long) /
                  1000)
              .toStringAsFixed(2));

          }
          
        } else {
          name = _searchuser(x.measurement);
          double lat = double.parse(x.lat.toStringAsFixed(5));
          double long = double.parse(x.long.toStringAsFixed(5));
          userloc = LatLng(lat, long);
        }

        marker = Marker(
            markerId: MarkerId(x.measurement),
            position: LatLng(x.lat, x.long),
            infoWindow: InfoWindow(
                onTap: isUser ? (){
              _addSpot(name, x);

            } : (){},
                title: isUser ? "You are here" : name,
                snippet: isUser
                    ? 'Current point is (${userloc.latitude}, ${userloc.longitude})'
                    : "Distance between = $distancediff km"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                isUser ? BitmapDescriptor.hueRed : BitmapDescriptor.hueYellow));

        _marker[x.measurement] = marker;
        if (isUser) {
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(x.lat, x.long),
            zoom: 12,
          )));
          double shoreDistance;
          if (Detail.information!.vessel!.isNotEmpty){
            var vesselArea = Detail.information!.vessel;
            double shoreLong = vesselArea![0].siteLocationLng as double;
            double shoreLat = vesselArea[0].siteLocationLat as double;
            shoreDistance = double.parse((Geolocator.distanceBetween(x.lat,
                      shoreLong, x.lat, x.long) /
                  1000)
              .toStringAsFixed(2));
            print("this is the shore distance $shoreDistance");
          } else {
            shoreDistance = double.parse((Geolocator.distanceBetween(x.lat,
                      _center.longitude, x.lat, x.long) /
                  1000)
              .toStringAsFixed(2));
          }
          
          if (shoreDistance > 12) {
            _showDialog();
          }
        } else {
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(x.lat, x.long),
            zoom: 11,
          )));
        }
      }
    });
  }

  void _addSpot(String name, UserLocation spot){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Spot"),
            content: const Text(
                "Do you want to add this spot as fishing spot"),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("No"),
              ),
              TextButton(onPressed: () async{
                await addlocation(name, spot);
                Navigator.of(context).pop();
                _spot_added();

              }, child: const Text("Yes")),
            ],
          );
        });
  }

  void _spot_added() {
    showDialog(
      context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Spot Added Successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    _marker.clear();
                  });
                  updateLocationOnMap();
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  Future addlocation(String name, UserLocation fishSpot) async{
    final spot = Spot(
      name: name, 
      longitude: fishSpot.long, 
      latitude: fishSpot.lat, 
      createdTime: DateTime.now()
      );
    bool isLoading = true;

    await Fishing_spot_Database.instances.create(spot);
  }

  Widget buildSearchbar() {
    return FloatingSearchBar(
      controller: controlSearch,
      automaticallyImplyBackButton: false,
      transition: CircularFloatingSearchBarTransition(),
      physics: const BouncingScrollPhysics(),
      hint: "Search for fisherman location...",
      title: const Text("Fisherman Tracker"),
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      body: googlemap(),
      onQueryChanged: (query) {
        setState(() {
          filtered = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (fisherman) {
        if (_userExist(fisherman)) {
          String sensor = _searchsensor(fisherman);
          
          setState(() {
            addSearchTerm(fisherman);
            movetotheuser(sensor);
            SharedService.savehistory(_searchHistory);
          });
        } else {
          _showNoUser();
        }
        controlSearch.close();
      },

      
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filtered.isEmpty && controlSearch.query.isEmpty) {
                    return Container(
                      height: 40,
                      width: double.infinity,
                      child: const Text(
                        "Search for other fisherman",
                        overflow: TextOverflow.ellipsis,
                      ),
                      alignment: Alignment.center,
                    );
                  } else if (_searchHistory.isNotEmpty &&
                      controlSearch.query.isEmpty) {
                    return Column(
                        children: _searchHistory
                            .map((user) => ListTile(
                                  title: Text(user),
                                  leading: const Icon(Icons.history),
                                  onTap: () {
                                    if (_userExist(user)) {
                                      setState(() {
                                        String sensor = _searchsensor(user);
                                        addSearchTerm(user);
                                        movetotheuser(sensor);
                                        SharedService.savehistory(
                                            _searchHistory);
                                      });
                                    } else {
                                      _showNoUser();
                                    }

                                    controlSearch.close();
                                  },
                                ))
                            .toList());
                  } else {
                    return Column(
                        children: filtered
                            .map((user) => ListTile(
                                  title: Text(user),
                                  leading: const Icon(Icons.search),
                                  onTap: () {
                                    if (_userExist(user)) {
                                      setState(() {
                                        String sensor = _searchsensor(user);
                                        addSearchTerm(user);
                                        movetotheuser(sensor);

                                        SharedService.savehistory(
                                            _searchHistory);
                                      });
                                    } else {
                                      _showNoUser();
                                    }

                                    controlSearch.close();
                                  },
                                ))
                            .toList());
                  }
                },
              )),
        );
      },
    );
  }

  String _searchsensor(String user) {
    UserList users = Listuser.userList as UserList;
    VesselList vessels = Listvessel.vesselList as VesselList;
    SensorList sensors = Listsensor.sensorlist as SensorList;

    var searchuser = users.data!.firstWhere((element) => element.name == user);
    int userId = searchuser.id as int;
    var searchvessel =
        vessels.data!.firstWhere((element) => element.ownerId == userId);
    int vesselId = searchvessel.id as int;
    var searchsensor = sensors.data!
        .firstWhere((element) => element.attachedToVesselId == vesselId);
    String sensorEUI = searchsensor.eui as String;
    return sensorEUI;
  }

  void _showNoUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("User Not Found"),
            content: const Text("The user you type is not exists."),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  Widget googlemap() {
    bool areaExists = check_area();
    var vesselArea = Detail.information!.vessel;
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      circles: _circle,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        updateLocationOnMap();
      },
      initialCameraPosition: CameraPosition(
        target: areaExists ? _center : LatLng(vesselArea![0].siteLocationLat as double, vesselArea[0].siteLocationLng as double),
        zoom: 10,
      ),
      markers: _marker.values.toSet(),
    );
  }

  void movetotheuser(String user) async {
    final GoogleMapController controller = await _controller.future;

    LatLng? position = _marker[user]?.position;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: position as LatLng,
      zoom: 12,
    )));
  }

  List<String> filterSearchTerms({
    String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return alluser.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filtered = filterSearchTerms(filter: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.blueGrey, Colors.black],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 600,
            child: buildSearchbar(),
          )),
    );
  }


  /*
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          height: 700,
          child: buildSearchbar(),
        ));
  }*/
}

 */
