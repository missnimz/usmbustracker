import 'package:flutter/material.dart';
import 'package:nelayannet/Services/detaillist.dart';

class SensorDetail extends StatelessWidget{
  const SensorDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sensorDetail = Detail.information;
    if (sensorDetail==null) return const SizedBox.shrink();
    var sensor = sensorDetail.sensor;

    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.numbers, color: Colors.white,)
          ),
          title: const Text("Sensor EUI"),
          subtitle: Text("${sensor![0].eui}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.sensors, color: Colors.white,)
          ),
          title: const Text("Sensor Name"),
          subtitle: Text("${sensor[0].name}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.sensors, color: Colors.white,)
          ),
          title: const Text("Sensor Brand"),
          subtitle: Text("${sensor[0].brand}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.calendar_month, color: Colors.white,)
          ),
          title: const Text("Sensor Registration Date"),
          subtitle: Text("${DateTime.parse(sensor[0].createdAt as String).toLocal()}"),
        ),
      ],
    );
  }
}

/*
class SensorInfo extends StatefulWidget {
  const SensorInfo({ Key? key }) : super(key: key);

  @override
  State<SensorInfo> createState() => _SensorInfoState();
}

class _SensorInfoState extends State<SensorInfo> {
  var sensor = Detail.information!.sensor;

  bool check_sensor(){
    if (Detail.information!.sensor == null){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool sensor_exists = check_sensor();
    return Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: <Widget>[
                const Text(
                  "Sensor Information",
                  
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.numbers),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Sensor EUI"),
                  subtitle: sensor_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${sensor![0].eui}",
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
                  leading: CircleAvatar(child: Icon(Icons.sensors),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Sensor Name"),
                  subtitle: sensor_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${sensor![0].name}",
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
                  leading: CircleAvatar(child: Icon(Icons.sensors),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Sensor Brand"),
                  subtitle: sensor_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${sensor![0].brand}",
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
                  title: Text("Sensor Register Date"),
                  subtitle: sensor_exists ? Text(
                    "NO DATA",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ) : Text(
                    "${DateTime.parse(sensor![0].createdAt as String).toLocal()}",
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