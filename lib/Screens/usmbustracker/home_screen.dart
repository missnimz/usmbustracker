import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/usmbustracker/top_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopNavigationBar(), // Use TopNavigationBar as the body
    );
  }
}
