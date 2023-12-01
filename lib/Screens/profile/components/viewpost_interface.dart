import 'package:flutter/material.dart';
import 'dart:io';

import '../../../Services/detaillist.dart';

class ViewPost extends StatefulWidget{

  final String imageTemp;
  final int? id;
  late String? caption;

  ViewPost({
    Key? key,
    this.caption,
    required this.id,
    required this.imageTemp,
  }) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  bool isEdit = false;
  late TextEditingController controller;
  //var updatedCaption;

  @override
  void initState(){
    controller = TextEditingController(text: widget.caption);
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  void _updateCaption(val){
    setState(() {
      widget.caption = val;
    });
  }

  @override
  Widget build(BuildContext context){
    //var controller = TextEditingController(text: widget.caption);
    var userDetail = Detail.information;
    if (userDetail==null) return const SizedBox.shrink();
    final user = userDetail.user;
    String? imagepath = user!.profileImage;
    var imageProfile = imagepath!.contains('https://') ? NetworkImage(imagepath) : FileImage(File(imagepath));
    var image = widget.imageTemp.contains('https://') ? NetworkImage(widget.imageTemp) : FileImage(File(widget.imageTemp));

    return Scaffold(
        appBar: AppBar(
          /*leading:
          isEdit?
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: (){
              setState(() {
                this.isEdit = false;
              });
            },
          ): BackButton(),*/
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          children: [
            Container(
              width: double.infinity, height: 400,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              isEdit
                                  ? IconButton(
                                icon: const Icon(Icons.cancel_outlined),
                                onPressed: (){
                                  setState(() {
                                    isEdit = false;
                                  });
                                },
                              )
                                  : CircleAvatar(
                                backgroundImage: imageProfile as ImageProvider,
                              ),
                              const SizedBox(width: 10,),
                              Text("${user.name}", style: const TextStyle(fontWeight: FontWeight.w700),),
                            ],
                          ),
                          !isEdit ?
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            icon: const Icon(Icons.menu_outlined),
                            onSelected: (newValue) {
                              if (newValue == 0) {
                                //edit post (caption)
                                setState(() {
                                  isEdit = true;
                                });
                              }
                              else if (newValue == 1) {
                                //delete post
                                Listpost.deleteuserpost(widget.id);
                                Navigator.of(context).pushNamed("/home");
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit_outlined),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text('Edit'),
                                    ),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                              : IconButton(
                            icon: const Icon(Icons.done),
                            onPressed: (){
                              setState(() {
                                Listpost.updateuserpost(widget.caption, widget.id);
                                isEdit = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      width: double.infinity, height: 190,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Image(image: image as ImageProvider, fit: BoxFit.cover,),
                    ),
                    /*Row(
                    children: [
                      IconButton(icon: Icon(Icons.thumb_up_alt_outlined), onPressed: (){},),

                    ],
                  ),*/
                    !isEdit
                        ? Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: RichText(textAlign: TextAlign.start,
                        text: TextSpan(
                          text: widget.caption,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8,),
                          TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLines: 2,
                            onChanged: (val){
                              _updateCaption(val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}