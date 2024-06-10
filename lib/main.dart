//import 'package:nelayannet/Screens/Analytic/analytic.dart';
//import 'package:nelayannet/Screens/FishingSpot/saved_spot.dart';
//import 'package:nelayannet/Screens/Journey/journey.dart';
import 'package:nelayannet/Screens/dashboard/bottomnavbar.dart';
import 'package:nelayannet/Screens/ens/ens.dart';
import 'package:nelayannet/Screens/environment/environment.dart';
//import 'package:nelayannet/Screens/fishermanlist/fishermanlist.dart';
import 'package:nelayannet/Screens/profile/profile.dart';
import 'package:nelayannet/Screens/tracking/tracking.dart';
import 'package:nelayannet/Screens/usmbustracker/top_navbarAdmin.dart';
import 'package:nelayannet/Services/detaillist.dart';
import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/login/login.dart';
import 'package:nelayannet/Services/shared_services.dart';
//import 'Screens/homepage/bottomnavigatorbar.dart';
//import 'Screens/homepage/homepage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'Screens/dashboard/dashboard.dart';
import 'Model/user_model.dart';
import 'Screens/profile/components/details_interface.dart';
import 'Screens/profile/components/editprofile_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
//import 'package:flogger/flogger.dart';
import 'package:provider/provider.dart';
//import 'package:nelayannet/Screens/usmbustracker/bus/busdata_provider.dart';
//import 'package:nelayannet/influx.dart';


//----------ORIGINAL CODE ABOVE--------

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Initialize notifications
  //NotificationService.init();

  Widget _home = const LoginPage();

  bool _result = await SharedService.isLoggedIn();
  print(_result);
  //Widget _home;

  if (_result) {
    print("TOKEN: ");
    String? token = await const FlutterSecureStorage().read(key: 'token');

    if (token != null) {
      print(token);
      bool isExpired = JwtDecoder.isExpired(token);
      print("EXPIRED");
      print(isExpired);

      if (!isExpired) {
        // await Listsensor.getlistsensor();
        // await Listvessel.getlistvessel();
        await Listuser.getlistuser();
        await Detail.getuserdetail();
        await Listpost.getlistpost();

        // Schedule notifications when the user is logged in
        //NotificationService.scheduleNotifications();

        UserInfo? userDetail = Detail.information;

        if (userDetail != null && userDetail.user?.role == 'Admin') {
          print('User role: ${userDetail.user?.role}');
          _home = const TopNavigationBarAdmin();
        } else {
          _home = const Dash();
        }
      } else {
        // Handle the case where user details couldn't be fetched
        _home = const LoginPage();
      }
    }
  }

  //runApp(const MyApp());

  runApp(MyApp(home: _home));

}



  //Widget _home = const Home();


  class MyApp extends StatelessWidget {
    final Widget home;

    const MyApp({Key? key, required this.home}) : super(key: key);
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Interface',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
        //home: _home,
          home: home,
        routes: {
        "/login": (_) => const LoginPage(),
        "/home": (_) => const Dash(),
        "/homeAdmin": (_) => const TopNavigationBarAdmin(),
        "/dashboard": (_) => const Dashboard(),
        "/ens": (_) => const Ens(),
        "/tracking": (_) => const TrackingPage(),
        "/environment": (_) => const Environment(),
        "/profile": (_) => const Profilepage(),
        "/editprofile": (_) => const EditProfile(),
        "/userdetails": (_) => const DetailsInterface(),
        },
      );
    }
  }



