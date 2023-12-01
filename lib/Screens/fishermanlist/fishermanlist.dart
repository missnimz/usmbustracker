import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/fishermanlist/components/body.dart';

class Fishermans extends StatefulWidget {
  const Fishermans({ Key? key }) : super(key: key);

  @override
  _FishermansState createState() => _FishermansState();
}

class _FishermansState extends State<Fishermans>{
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FishermanList(),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "List of Fisherman",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan[100],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 44, 62, 153),
                Color.fromARGB(255, 73, 155, 237),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: FishermanList(),
        ),
        ),
        /*SingleChildScrollView(
          child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: FishermanList(),
          
        ),

        ),*/
        ],
      ),
    );
  }*/
}