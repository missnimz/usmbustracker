import 'package:flutter/material.dart';
import 'package:nelayannet/Services/detaillist.dart';

class VesselDetail extends StatelessWidget{
  const VesselDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vesselDetail = Detail.information;
    if (vesselDetail==null) return const SizedBox.shrink();
    var vessel = vesselDetail.vessel;

    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.numbers, color: Colors.white,)
          ),
          title: const Text("Vessel Number"),
          subtitle: Text("${vessel![0].vesselNumber}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.directions_boat, color: Colors.white,)
          ),
          title: const Text("Vessel Material"),
          subtitle: Text("${vessel[0].vesselMaterial}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.directions_boat, color: Colors.white,)
          ),
          title: const Text("Main Fishing Gear"),
          subtitle: Text("${vessel[0].fishingGearMain}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.numbers, color: Colors.white,)
          ),
          title: const Text("Engine Number"),
          subtitle: Text("${vessel[0].engineNumber}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.directions_boat, color: Colors.white,)
          ),
          title: const Text("Engine Type"),
          subtitle: Text("${vessel[0].vesselType}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.directions_boat, color: Colors.white,)
          ),
          title: const Text("Engine Brand"),
          subtitle: Text("${vessel[0].engineBrand}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.directions_boat, color: Colors.white,)
          ),
          title: const Text("Engine Model"),
          subtitle: Text("${vessel[0].engineModel}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.date_range, color: Colors.white,)
          ),
          title: const Text("License Valid Date"),
          subtitle: Text("${DateTime.parse(vessel[0].licenseValidUntilDate as String).toLocal()}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.date_range, color: Colors.white,)
          ),
          title: const Text("Vessel Registration Date"),
          subtitle: Text("${DateTime.parse(vessel[0].originalRegistrationDate as String).toLocal()}"),
        ),
      ],
    );
  }
}

/*
class VesselInfo extends StatefulWidget {
  const VesselInfo({ Key? key }) : super(key: key);

  @override
  State<VesselInfo> createState() => _VesselInfoState();
}

class _VesselInfoState extends State<VesselInfo> {
  var vessel = Detail.information!.vessel;

  bool check_vessel(){
    if (Detail.information!.vessel == null) {
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    bool vessel_exists = check_vessel();
    Size size = MediaQuery.of(context).size;
    return Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: <Widget>[
                const Text(
                  "Vessel Information",
                  
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.numbers),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Vessel Number"),
                  subtitle: vessel_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${vessel![0].vesselNumber}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.build),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Main Fishing Gear"),
                  subtitle: vessel_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${vessel![0].fishingGearMain}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.build),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Engine Type"),
                  subtitle: vessel_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${vessel![0].vesselType}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.calendar_month),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("License Valid Date"),
                  subtitle: vessel_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${DateTime.parse(vessel![0].licenseValidUntilDate as String).toLocal()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                
              ],
            )
            
          );
  }
}*/