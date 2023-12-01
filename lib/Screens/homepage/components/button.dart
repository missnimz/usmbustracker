import 'package:flutter/material.dart';
import 'package:nelayannet/Services/shared_services.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.5),
            color: Colors.blue[50],
          ),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.28,
            crossAxisCount: 3,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(10, 10),
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                ),
                child: const Column(
                  children: <Widget>[
                    Icon(Icons.people),
                    Align(
                      alignment: Alignment.center,
                      child: Text("List of"),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("fisherman"),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/fishermans');
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                ),
                child: const Column(
                  children: <Widget>[Icon(Icons.map), Text("My journey")],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/journey');
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                ),
                child: const Column(
                  children: <Widget>[Icon(Icons.analytics), Text("Analytic")],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/analytic');
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                ),
                child: const Column(
                  children: <Widget>[Icon(Icons.gps_fixed), Text("Fishing Spot")],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/fishingspot');
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                ),
                child: const Column(
                  children: <Widget>[Icon(Icons.person), Text("profile")],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/profile");
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  //side: BorderSide(style: BorderStyle.solid),
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                ),
                child: const Column(
                  children: <Widget>[Icon(Icons.exit_to_app), Text("Log out")],
                ),
                onPressed: () {
                  SharedService.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
