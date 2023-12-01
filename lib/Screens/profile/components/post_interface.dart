import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../../../Services/detaillist.dart';

class Post extends StatefulWidget{
  const Post({Key? key}) : super(key: key);

  @override
  _Post createState() =>  _Post();
}

class _Post extends State<Post>{
  var imageTemp;
  var caption;
  var controller = TextEditingController();
  /*final ImagePicker _picker = ImagePicker();

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    if (pickedFile == null) return;
    setState(() {
      //imageTemp = File(pickedFile.path);
      imageTemp = pickedFile.path;
      //imageTemp = Path.basename(pickedFile.path);
      print(imageTemp);
    });
  }*/

  @override
  Widget build(BuildContext context){
    var userDetail = Detail.information;
    if (userDetail == null) return const SizedBox.shrink();
    var user = userDetail.user;

    return Scaffold(
      appBar: AppBar(
        /*leading: BackButton(
          onPressed: (){Navigator.of(context).pushNamed("/profile");},
        ),
        elevation: 0,
        backgroundColor: Colors.cyan[100],
        foregroundColor: Colors.black,*/
        title: const Text("Upload"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: (){
              //showModalBottomSheet(builder: (builder) => bottomSheet(), context: context);
            },
          )
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.blueGrey, Colors.black,],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft
            ),
          ),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          children: [
            Container(
              width: double.infinity, height: 250,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                          children: [
                            const Text("Preview"),
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              width: double.infinity, height: 190,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: imageTemp == null
                                  ? const Icon(Icons.image)
                                  : Image.file(File(imageTemp), fit: BoxFit.cover,),
                            )
                          ]
                      ),
                    )
                  ]
              ),
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Caption',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  maxLines: 5,
                )
              ],
            ),   //caption
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.blueGrey, shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text("Post", style: TextStyle(color: Colors.white),),
              onPressed: () async {
                setState(() {
                  caption=controller.text;
                });
                Listpost.adduserpost(imageTemp, user!.id, caption);
                //Navigator.of(context).pop();
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Profilepage()));
              },
            ),
          ]
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