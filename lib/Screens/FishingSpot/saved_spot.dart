import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/FishingSpot/components/spot_map.dart';


class FishingSpot extends StatelessWidget {
  const FishingSpot({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Scaffold(
      /*appBar: AppBar(
        //automaticallyImplyLeading: false,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Fishing Spot",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan[100],
      ),*/
      body: LoadSpot(),
    );
  }
}