import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

import '../../../Services/detaillist.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile>{
  //final ImagePicker _picker = ImagePicker();
  String? imagepath;
  String? image;
  int value = 0;
  var newName;
  var newPhone;
  var newAddress;
/*
  Future takePhoto(ImageSource source) async{
    final pickedFile = await _picker.getImage(source: source);

    if(pickedFile==null) return;
    /*final directory = await getApplicationDocumentsDirectory();
    final name = basename(pickedFile.path);
    final imageFile = File('${directory.path}/$name');*/
    //final newImage = await File(pickedFile.path).copy(imageFile.path);
    setState(() {
      image = pickedFile.path;
      value = 1;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var userDetail = Detail.information;
    /*var sensorDetail = Detail.information;
    var vesselDetail = Detail.information;*/
    if (userDetail==null) return const SizedBox.shrink();
    //if (sensorDetail==null) return SizedBox.shrink();
    //if (vesselDetail==null) return SizedBox.shrink();
    var user = userDetail.user;
    /*final sensor = sensorDetail.sensor;
    final vessel = vesselDetail.vessel;*/

    value == 0 ? imagepath = user!.profileImage : imagepath = image;
    //imagepath = user!.profileImage;
    var imageProfile = imagepath!.contains('https://') ? NetworkImage(imagepath!) : FileImage(File(imagepath!));
    var name = TextEditingController();
    var phone = TextEditingController();
    var address = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        //physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20,),
          Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 144 / 2,
                  backgroundImage: imageProfile as ImageProvider,
                  backgroundColor: Colors.black26,
                ),
                Positioned(
                    bottom: 0,
                    right: 4,
                    child: ClipOval(
                      child: Container(
                          padding: const EdgeInsets.all(8), color: Colors.blueGrey,
                          child: InkWell(
                            child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28.0,),
                            onTap: (){
                              //showModalBottomSheet(context: context, builder: (builder) => bottomSheet());
                            },
                          )
                      ),
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              const SizedBox(height: 8,),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              const SizedBox(height: 8,),
              TextField(
                controller: phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              )
            ],
          ),
          const SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              const SizedBox(height: 8,),
              TextField(
                controller: address,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 5,
              )
            ],
          ),
          const SizedBox(height: 28,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueGrey, shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text("Save"),
            onPressed: (){
              setState(() {
                newName = name.text;
                newPhone = phone.text;
                newAddress = address.text;
              });
              //Listuser.updateuserdetails(newName, newPhone, newAddress, imagepath);
              //Navigator.of(context).pop();  go to MyApp()
            },
          ),
        ],
        /*
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.username, //"Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 8,),
                TextField(
                  controller: TextEditingController(text: "${user.name}"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                  //onChanged: (name) => user = user!.copy(name: name),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.ic, //"IC Number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 8,),
                TextField(
                  controller: TextEditingController(text: "${user.icNumber}"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                  //onChanged: (icNumber) => user = user!.copy(icNumber: icNumber),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.f_pNumber, //"Phone Number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 8,),
                TextField(
                  controller: TextEditingController(text: "${user.phone}"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                  //onChanged: (phone) => user = user!.copy(phone: phone),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.f_address, //"Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 8,),
                TextField(
                  controller: TextEditingController(text: "${user.address}"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 1,
                  //onChanged: (address) => user = user!.copy(address: address),
                )
              ],
            ),
            const SizedBox(height: 24,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.cyan[100],
                onPrimary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text("Save"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),*/
      ),
    );
  }
/*
  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20, vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text("Choose profile photo",
              style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera")
              ),
              FlatButton.icon(
                onPressed: (){
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }*/
}