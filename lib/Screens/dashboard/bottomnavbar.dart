import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nelayannet/Screens/Analytic/analytic.dart';
import 'package:nelayannet/Screens/ens/ens.dart';
import 'package:nelayannet/Screens/environment/environment.dart';
import 'package:nelayannet/Screens/usmbustracker/home_screen.dart';
import '../profile/profile.dart';
// import 'Components/map.dart';
import 'dashboard.dart';
import '../ens/ens.dart';
// import '../../../Screens/dashboard.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash>{

  int _selectedIndex = 2;
  void _navigateBottomNavBar(int index) {
    setState((){
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const Dashboard(),
    // const ViewMap(),
    const Environment(),
    const HomeScreen(), //usm bus tracker
    const Ens(),
    const Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            // Icon(Icons.home_outlined, color: Colors.white,),
            // Icon(Icons.location_on_outlined, color: Colors.white,),
            // Icon(Icons.person_outline, color: Colors.white,)
            Icon(Icons.home_outlined, color: Colors.white,),
            Icon(Icons.wb_sunny_outlined, color: Colors.white,),
            Icon(Icons.directions_bus_sharp, color: Colors.white),
            Icon(Icons.warning_outlined, color: Colors.white,),
            // Icon(Icons.directions_bus_outlined, color: Colors.white,),
            // Icon(Icons.notifications, color: Colors.white,),
            Icon(Icons.person_outlined, color: Colors.white,)
          ],
          index: _selectedIndex,
          onTap: _navigateBottomNavBar,
          height: 60,
          backgroundColor: Colors.white,
          color: Colors.purple,
        )
    );
  }
}