import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/usmbustracker/callbutton.dart';
import 'package:nelayannet/Screens/usmbustracker/home_screen.dart';
import 'package:nelayannet/Screens/usmbustracker/schedule_page.dart';
import 'package:nelayannet/Screens/usmbustracker/usmbus_tracker.dart';


class TopNavigationBar extends StatelessWidget{
  //const TopNavigationBar({super.key});
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
       length: 3,
       child: Scaffold(
         appBar: AppBar(
           title: Text('USM Bus Tracker',
               style: TextStyle(
                 fontFamily: 'Bayon', color: const Color(0xFF63398F))),
           bottom: TabBar(
             tabs: [
               Tab(
                 icon: Icon(Icons.home),
               ),
               Tab(
                 icon: Icon(Icons.calendar_month),
               ),
               Tab(
                 icon: Icon(Icons.volume_up_rounded),
               ),
             ],

           ),
         ),

         body: TabBarView(
           children: [
             USMBusTracker(),
             SchedulePage(),
             CallButton(),
           ],
         ),

   ),);
  }
  
}