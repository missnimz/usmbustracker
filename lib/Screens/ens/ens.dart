import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:nelayannet/Screens/FishingSpot/saved_spot.dart';
import 'package:nelayannet/Screens/tracking/tracking.dart';
import 'package:nelayannet/Services/shared_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../Analytic/analytic.dart';
import '../Journey/journey.dart';
import '../fishermanlist/fishermanlist.dart';

class Ens extends StatelessWidget {
  const Ens({Key? key}) : super(key: key);

  // void checklogin(context) async {
  //   String token = await const FlutterSecureStorage().read(key: 'token') as String;
  //
  //   bool isExpired = JwtDecoder.isExpired(token);
  //
  //   if (isExpired) {
  //     showDialog(
  //         barrierDismissible: false,
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text("Login Session has Expired"),
  //             content: const Text("You will log out after press ok"),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   SharedService.logout(context);
  //                 },
  //                 child: const Text("OK"),
  //               )
  //             ],
  //           );
  //         });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //checklogin(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "ENS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.login_outlined),
          //     onPressed: (){ SharedService.logout(context); },
          //   ),
          // ],
          //backgroundColor: Colors.cyan[100],
          flexibleSpace: Container(
            color: Colors.purple,
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 11, color: Colors.white), // Text color for selected tab
            unselectedLabelColor: Colors.white, // Text color for unselected tabs
            labelColor: Colors.white, // Ensures the text color is white for selected tab if needed
            indicatorColor: Colors.white, // Color of the indicator beneath the selected tab
            tabs: [
              Tab(icon: Icon(Icons.people_alt_outlined, color: Colors.white), text: "Community"),
              Tab(icon: Icon(Icons.map_outlined, color: Colors.white), text: "Tracking"),
              Tab(icon: Icon(Icons.analytics_outlined, color: Colors.white), text: "Analytic"),
              Tab(icon: Icon(Icons.gps_fixed_outlined, color: Colors.white), text: "Spot"),
            ],
          ),

          //elevation: 20,
        ),
        body: const DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text("Press again to exit"),
          ),
          child: Stack(
            children: <Widget>[
              TabBarView(
                  children: [
                    Fishermans(),
                    // UserJourney(),
                    TrackingPage(),
                    Analyticpage(),
                    FishingSpot(),
                  ]
              ),
            ],
          ),
        ),
      ),
    );

    // BELOW TAN LEE SING'S VERSION OF HOMEPAGE DESIGN
    // I CHANGE A LITTLE BIT THE UI/UX TO LOOK LIKE ABOVE
    /*
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Homepage",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan[100],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Press again to exit"),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
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
                children: const <Widget>[
                  Button(),
                  ViewMap(),
                ],
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}