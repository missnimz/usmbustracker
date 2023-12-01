import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/Analytic/components/body.dart';
import 'package:nelayannet/Screens/Analytic/components/table.dart';

class Analyticpage extends StatelessWidget {
  const Analyticpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Analytic",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.cyan[100],
      ),*/
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            height: size.height * .25,
            /*decoration: BoxDecoration(
              color: Colors.cyan[100],
            ),*/
          ),
          const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Body(),
                ShowTable(),
                ],
            ),
          ),
        ],
      ),
    );
  }
}