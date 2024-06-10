//
//NEW CODE (21/5/24)
/*------------FOR OWN DEVICE--------------------
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nelayannet/Screens/usmbustracker/notification_services.dart';
import 'package:http/http.dart' as http;

class CallButton extends StatefulWidget {
  @override
  _CallButtonState createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {
  String? deviceToken;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.createNotificationChannel();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token;
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('notification title:${message.notification?.title}');
        print('notification body:${message.notification?.body}');
        print('count:${message.data['notification_count']}');
        print('data:${message.data}');
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      setState(() {
        deviceToken = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Push this button to remind the bus driver that you are here!',
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 100.0),
            IconButton(
              icon: const Icon(
                Icons.notifications_active,
                size: 200.0,
                color: Color(0xFFA366FF),
              ),
              onPressed: () {
                notificationServices.getDeviceToken().then((value) async {
                  var data = {
                    'to': value.toString(),
                    'notification': {
                      'title': 'Bus Stop: Komca',
                      'body': 'Someone is here! Hurry up!',
                    },
                    'android': {
                      'notification': {
                        'notification_count': 23,
                      },
                    },
                    'data': {
                      'type': 'Reminder',
                      'id': 'Student 1',
                    },
                  };

                  await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization': 'key=AAAAybTk2WI:APA91bH2-DgKnodnaS0CDtBU2dWyUahxwg56EBu02W3TsCULrN_k5ZGnEJoyb5TILGU3KT3XbjxYUhexhYj73O2FjqNInBIWIz76Xmt4ApscJBuR1lTb7GIbMZDgJhm60pbp8PUJ-oqv'
                    },
                  ).then((value) {
                    if (kDebugMode) {
                      print(value.body.toString());
                    }
                  }).onError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error);
                    }
                  });
                });
              },
            ),
            const SizedBox(height: 150.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                '(can only push the button every 10 minutes)',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/




// ------------- FOR ANOTHER DEVICE --------------------------
//import 'dart:js';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:nelayannet/Screens/usmbustracker/notification_services.dart';
import 'package:http/http.dart' as http;



class CallButton extends StatefulWidget {
  @override
  _CallButtonState createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {
  String? deviceToken;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    //print('initState called');

    notificationServices.requestNotificationPermission();

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        deviceToken = token;
      });
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('notification title:${message.notification?.title}');
      print('notification body:${message.notification?.body}');
      print('count:${message.data['notification_count']}');
      print('data:${message.data}');
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      setState(() {
        deviceToken = token;
      });
    });
  }
  //class CallButton extends StatelessWidget {
  //final BuildContext context;
  //const CallButton({Key? key, required this.context}) : super(key: key);
   //CallButton({Key? key}) : super(key: key);
   //const CallButton({super.key});
   //final BuildContext context;


  //NotificationServices notificationServices = NotificationServices();


  //final Geolocator _geolocator = Geolocator();
  //final double _busStopLatitude = 37.421999;
  //final double _busStopLongitude = -122.084057;
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

 /*Future<void> _sendNotification() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distanceInMeters = await Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        _busStopLatitude,
        _busStopLongitude);
    if (distanceInMeters <= 10) {
      await _firebaseMessaging.subscribeToTopic('bus_stop_notifications');
      await _firebaseMessaging.send({
          'notification' : {
          'title' : 'Bus Stop Notification',
          'body' : 'Someone is at the bus stop',
      },
        'to' : 'bus_stop_notifications',
      }
      );
    }
  } */

   /*Future<void> _sendNotification() async {
     FirebaseMessaging messaging = FirebaseMessaging.instance;
     String token = 'DEVICE_TOKEN_OF_RECEIVER'; // Replace with the token of the device you want to send notification to
     await messaging.send({
       'to': token,
       'notification': {
         'title': 'Title of the notification',
         'body': 'Body of the notification',
       },
     }
     );
   } */

/*
   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     notificationServices.requestNotificationPermission();
     notificationServices.forgroundMessage();
     notificationServices.firebaseInit(context);
     notificationServices.setupInteractMessage(context);
     notificationServices.isTokenRefresh();

     notificationServices.getDeviceToken().then((value){
       if (kDebugMode) {
         print('device token');
         print(value);
       }
     });
   }
*/


  @override
  Widget build(BuildContext context) {

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    //notificationServices.getDeviceToken().then((value){}


    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(
              'Push this button to remind the bus driver that you are here!',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 22.0),
              textAlign: TextAlign.center,
            ),
        ),
            SizedBox(height: 100.0),
            IconButton(
              icon: Icon(
                Icons.notifications_active,
                size: 200.0,
                color: const Color(0xFFA366FF),
              ),

              onPressed: () {
                if (deviceToken !=
                    null) { //-------ni untuk send to another device-----
                  print('Device Token: $deviceToken');

                  // send notification from one device to another

                  notificationServices.getDeviceToken().then((value) async {
                    var data = {
                      //'to' : 'cGC5hptASpeocBOVVbrwhF:APA91bHicYsmo9D0X6Dgs2QyJ40w_iTSkeUSqIneKvf56W_rOlb3lXdcfL3KFxnnotpE7ncr083eBBB3xIBs0MVPW1R5FTBoRtm6OBREbvsEAD9rvCI2oCyx5XcAtF1zS5Ldn6pIgTEA', //deviceToken!,//value.toString(),
                      //deviceToken!,
                      //'to': value.toString(),
                      'to': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTc5Mzg2ODUsImlkIjoxLCJvcmlnX2lhdCI6MTcxNzkxNzA4NSwicm9sZSI6IlVzZXIifQ.CA2ucMNgBSAtriE-qa8ZYTYqJH-sQA4PrDRst7YugoA',
                      'notification': {
                        'title': 'Bus Stop: Komca',
                        'body': 'Someone is here! Hurry up!',
                      },
                      'android': {
                        'notification': {
                          'notification_count': 23,
                        },
                      },
                      'data': {
                        'type': 'Reminder',
                        'id': 'Student 1'
                      }
                    };

                    //await
                    http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                        body: jsonEncode(data),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': 'key=AAAAybTk2WI:APA91bH2-DgKnodnaS0CDtBU2dWyUahxwg56EBu02W3TsCULrN_k5ZGnEJoyb5TILGU3KT3XbjxYUhexhYj73O2FjqNInBIWIz76Xmt4ApscJBuR1lTb7GIbMZDgJhm60pbp8PUJ-oqv'
                        }
                    ).then((value) {
                      if (kDebugMode) {
                        print(value.body.toString());
                      }
                    }).onError((error, stackTrace) {
                      if (kDebugMode) {
                        print(error);
                      }
                    });
                  });
                }
              }
    ),


            //),
            SizedBox(height: 150.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                '(can only push the button every 10 minutes)',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*-----original code below--------------*/

/*
import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  //const CallButton({super.key});
  CallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Push this button to remind the bus driver that you are here!',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 100.0),
            Icon(
              Icons.notifications_active,
              size: 200.0,
              color: const Color(0xFFA366FF),
            ),
            SizedBox(height: 150.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                '(can only push the button every 10 minutes)',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/