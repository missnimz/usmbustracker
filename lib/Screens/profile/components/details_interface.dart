import 'package:nelayannet/Screens/profile/components/sensordetail.dart';
import 'package:nelayannet/Screens/profile/components/userdetail.dart';
import 'package:nelayannet/Screens/profile/components/vesseldetail.dart';
import 'package:flutter/material.dart';

class DetailsInterface extends StatefulWidget {
  const DetailsInterface({Key? key}) : super(key: key);

  @override
  _DetailsInterfaceState createState() => _DetailsInterfaceState();
}

class _DetailsInterfaceState extends State<DetailsInterface>{
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Details"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.blueGrey, Colors.black],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )
            ),
          ),
        ),
        body: const Column(
          children: [
            SizedBox(height: 10,),
            TabBar(
              indicatorColor: Colors.blueGrey,
              tabs: [
                Tab(
                  icon: Icon(Icons.emoji_people, color: Colors.black,),
                ),
                Tab(
                  icon: Icon(Icons.directions_boat, color: Colors.black,),
                ),
                Tab(
                  icon: Icon(Icons.sensors, color: Colors.black,),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  UserDetail(),
                  VesselDetail(),
                  SensorDetail()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}