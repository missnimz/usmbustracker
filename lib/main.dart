import 'package:nelayannet/Screens/Analytic/analytic.dart';
import 'package:nelayannet/Screens/FishingSpot/saved_spot.dart';
import 'package:nelayannet/Screens/Journey/journey.dart';
import 'package:nelayannet/Screens/fishermanlist/fishermanlist.dart';
import 'package:nelayannet/Screens/profile/profile.dart';
import 'package:nelayannet/Services/detaillist.dart';
import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/login/login.dart';
import 'package:nelayannet/Services/shared_services.dart';
import 'Screens/homepage/bottomnavigatorbar.dart';
import 'Screens/homepage/homepage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'Screens/profile/components/details_interface.dart';
import 'Screens/profile/components/editprofile_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //try {
    bool _result = await SharedService.isLoggedIn();
    print(_result);
    if (_result) {
      print("TOKEN: ");
      // Perform a null check before casting to String
      String? token = await const FlutterSecureStorage().read(
          key: 'token') as String?;
      // String token = await const FlutterSecureStorage().read(
      //     key: 'token') as String;
      if (token != null) { //add new
        print(token);
        bool isExpired = JwtDecoder.isExpired(token);
        print("EXPIRED");
        print(isExpired);
        if (!isExpired) {
          await Listsensor.getlistsensor();
          await Listvessel.getlistvessel();
          await Listuser.getlistuser();
          await Detail.getuserdetail();
          //await Listpost.getlistpost();
        }
        //_home = const Homepage();
        _home = const Home();
      } else { //addnew
        // Handle the case where the token is null (e.g., not found in FlutterSecureStorage)
        _home = const LoginPage(); //addnew
      }
    }
  /*} catch (e) {
    print('Error occurred: $e');
    // Handle the error appropriately
  }*/
  runApp(const MyApp());
}

//Widget _home = const Home();
Widget _home = const LoginPage();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _home,
      routes: {
        "/login": (_) => const LoginPage(),
        "/home": (_) => const Home(),
        "/homepage": (_) => const Homepage(),
        "/fishermans": (_) => const Fishermans(),
        "/analytic": (_) => const Analyticpage(),
        "/journey": (_) => const UserJourney(),
        "/profile": (_) => const Profilepage(),
        "/fishingspot": (_) => const FishingSpot(),
        "/editprofile": (_) => const EditProfile(),
        "/userdetails": (_) => const DetailsInterface(),
        //"/post": (_) => Post(),

      },
    );
  }
}


