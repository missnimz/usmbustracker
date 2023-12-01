import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../profile/profile.dart';
import 'Components/map.dart';
import 'homepage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int _selectedIndex = 0;
  void _navigateBottomNavBar(int index) {
    setState((){
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const Homepage(),
    const ViewMap(),
    const Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(Icons.home_outlined, color: Colors.white,),
            Icon(Icons.location_on_outlined, color: Colors.white,),
            Icon(Icons.person_outline, color: Colors.white,)
          ],
          index: _selectedIndex,
          onTap: _navigateBottomNavBar,
          height: 60,
          backgroundColor: Colors.white,
          color: Colors.blueGrey,
        )
    );
  }
}