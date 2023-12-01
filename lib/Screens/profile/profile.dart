import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/profile/components/user_profile.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onSelected: (newValue) {
              if (newValue == 0) {
                Navigator.of(context).pushNamed("/editprofile");
              }
              else if (newValue == 1) {
                Navigator.of(context).pushNamed("/userdetails");
              }
            },
            icon: const Icon(Icons.menu_outlined),
            itemBuilder: (context) => [
              /*PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Edit profile'),
                    ),
                  ],
                ),
                //onTap: (){ },
              ),*/
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.black,),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text('User details'),
                    ),
                  ],
                ),
              )
            ],

          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.blueGrey, Colors.black],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            ),
          ),
        ),

      ),
      body: const Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ProfileUI(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// TAN LEE SING'S VERSION
/*
class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Profile",
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
          child: Column(children: const [
            const SizedBox(
                  height: 15,
                ),
            //UserProfileInfo(),
            //VesselInfo(),
            //SensorInfo(),
          ],),
        ),
        ),
        ],
      ),
    );
  }
}*/


/*          Container(
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
                ProfileUI(),
              ],
            ),
          ),*/

                          /*Container(
                  height: size.height*0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(33, 129, 75, 224),
                  ),
                ),*/