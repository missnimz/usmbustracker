
//import 'package:flutter/material.dart';
//import 'package:nelayannet/Screens/Journey/components/distance.dart';
//import 'package:nelayannet/Screens/Journey/components/myjourney.dart';
//import 'package:nelayannet/Screens/tracking/components/locationlist.dart';
/*
class UserJourney extends StatelessWidget {
  const UserJourney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            height: size.height * .25,
          ),
          const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // LocationsList()
                //DistanceTracelled(),
                //Myjourney(),
              ],
            ),
          ),
        ],
      ),
    );
  }

 */

  /*
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Journey",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan[100],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            height: size.height * .25,
            decoration: BoxDecoration(
              color: Colors.cyan[100],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DistanceTracelled(),
                Myjourney(),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
//}
