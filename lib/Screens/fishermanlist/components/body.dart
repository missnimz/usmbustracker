import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nelayannet/Model/fishermans_model.dart';
import 'package:nelayannet/Services/detaillist.dart';

class FishermanList extends StatelessWidget {
  const FishermanList({Key? key}) : super(key: key);
  static final UserList users = Listuser.userList as UserList;

  @override
  Widget build(BuildContext context) {
    final alluser = users.data;
    int count = users.data!.length;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        final user = alluser![index];
        String name = user.name as String;
        String phone = user.phone.toString();
        String address = user.address as String;
        String iD = user.id.toString();
        String imageProfile = user.profileImage.toString();
        var image = imageProfile.contains('https://') ? NetworkImage(imageProfile) : FileImage(File(imageProfile));
        return ListTile(
          onTap: () async {
            print("nani");
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      height: 500,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Fisherman Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              //crossAxisAlignment:
                              //    CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 15,),
                                Center(
                                  //mainAxisAlignment:
                                  //    MainAxisAlignment.spaceBetween,
                                  child:
                                  Stack(
                                    children: <Widget>[
                                      CircleAvatar( // Image profile
                                        radius: 120 / 2,
                                        backgroundColor: Colors.blueGrey[100],
                                        backgroundImage: image as ImageProvider,
                                        //child: Text(user.name!.substring(0, 1), style: TextStyle(fontWeight: FontWeight.bold, fontSize:30),),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                Center(
                                    child:
                                    Expanded(
                                      child:
                                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                    )
                                ),
                                const SizedBox(height: 12,),
                                Row(
                                  children: [
                                    const SizedBox(width: 20,),
                                    const Icon(Icons.phone, size: 22, color: Colors.grey,),
                                    Expanded(
                                      child:
                                      Text(" $phone", style: const TextStyle(color: Colors.grey)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 3,),
                                Row(
                                  children: [
                                    const SizedBox(width: 20,),
                                    const Icon(Icons.perm_identity, size: 22, color: Colors.grey,),
                                    Expanded(
                                      child:
                                      Text(" $iD", style: const TextStyle(color: Colors.grey)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 3,),
                                Row(
                                  children:[
                                    const SizedBox(width: 20,),
                                    const Icon(Icons.home, size: 22, color: Colors.grey,),
                                    Expanded(
                                      child:
                                      Text(" $address", style: const TextStyle(color: Colors.grey),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            height: 400,
                            color: Colors.white,
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[100]),
                                child: const Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          title: Text(user.name as String),
          leading: CircleAvatar(
            backgroundImage: image as ImageProvider,
            //child: Text(user.name!.substring(0, 1)),
          ),
          subtitle: Text(user.icNumber as String),
        );
      },
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    final alluser = users.data;
    int count = users.data!.length;
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView.builder(
        shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        final user = alluser![index];
        String name = user.name as String;
        String phone = user.phone.toString();
        String address = user.address as String;
        String iD = user.id.toString();
        return ListTile(
          /*onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 500,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Fisherman Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              //crossAxisAlignment:
                              //    CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "ID:",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      "$iD",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Name:",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      "$name",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phone Number:",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      "$phone",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Address",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      "$address",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            height: 400,
                            color: Colors.white,
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.grey[200]),
                                child: Text("OK"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent[100],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  );
                });
          },*/
          tileColor: Color.fromARGB(255, 58, 181, 234),
          shape: RoundedRectangleBorder(

            side: const BorderSide(color: Color.fromARGB(255, 76, 185, 224), width: 1,style: BorderStyle.none),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
                    "${user.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),

                  ),
          leading: CircleAvatar(
            child: Text(user.name!.substring(0, 1)),
          ),
          subtitle: Text(user.phone as String, style: TextStyle(fontSize: 20),),
        );
      },
    ),

    );
  }*/
}
