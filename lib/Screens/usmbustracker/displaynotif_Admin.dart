import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DisplayNotifAdmin extends StatefulWidget {
  @override
  _DisplayNotifAdminState createState() => _DisplayNotifAdminState();
}

class _DisplayNotifAdminState extends State<DisplayNotifAdmin> {
  late FirebaseMessaging _messaging;
  String _notificationMessage = "No notifications yet.";

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        setState(() {
          _notificationMessage = "${notification.title}: ${notification.body}";
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        setState(() {
          _notificationMessage = "${notification.title}: ${notification.body}";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF63398F),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _notificationMessage,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
