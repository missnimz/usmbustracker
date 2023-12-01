import 'package:flutter/material.dart';
import 'package:nelayannet/Services/detaillist.dart';
import 'dart:io';

class UserDetail extends StatelessWidget{
  const UserDetail({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var userDetail = Detail.information;
    if (userDetail==null) return const SizedBox.shrink();
    var user = userDetail.user;
    String? imagepath = user!.profileImage;
    var imageProfile = imagepath!.contains('https://') ? NetworkImage(imagepath) : FileImage(File(imagepath));

    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.people, color: Colors.white,),
          ),
          title: const Text("Name"),
          subtitle: Text("${user.name}"),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.credit_card, color: Colors.white,),
          ),
          title: const Text("IC Number"),
          subtitle: Text("${user.icNumber}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.phone_android, color: Colors.white,)
          ),
          title: const Text("Phone Number"),
          subtitle: Text("${user.phone}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.house, color: Colors.white,)
          ),
          title: const Text("Address"),
          subtitle: Text("${user.address}"),
        ),
        ListTile(
          leading: const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.date_range, color: Colors.white,)
          ),
          title: const Text("Registration Date"),
          subtitle: Text("${DateTime.parse(user.createdAt as String).toLocal()}"),
        ),
      ],
    );
  }
}

/*
class UserProfileInfo extends StatefulWidget {
  const UserProfileInfo({ Key? key }) : super(key: key);

  @override
  State<UserProfileInfo> createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  var user = Detail.information!.user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: <Widget>[
                const Text(
                  "User Information",
                  
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.people),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Name"),
                  subtitle: Text(
                    "${user!.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.credit_card),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("IC Number"),
                  subtitle: Text(
                    "${user!.icNumber}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.phone_android),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Phone Number"),
                  subtitle: Text(
                    "${user!.phone}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.house),backgroundColor: Colors.white,),
                  tileColor: Color.fromARGB(255, 58, 181, 234),
                  title: Text("Address"),
                  subtitle: Text(
                    "${user!.address}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                
              ],
            )
            
          );
  }
}*/