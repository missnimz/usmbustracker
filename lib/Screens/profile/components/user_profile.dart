import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/profile/components/viewpost_interface.dart';
import 'package:nelayannet/Screens/profile/components/post_interface.dart';
import 'package:nelayannet/Services/detaillist.dart';
import '../../../Model/userposts_model.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  //final ImagePicker _picker = ImagePicker();

  Widget _buildlist() {
    //var sensor = Detail.information!.sensor;
    //var user = Detail.information!.user;
    //var vessel = Detail.information!.vessel;
    var userDetail = Detail.information;
    var sensorDetail = Detail.information;
    var vesselDetail = Detail.information;
    if (userDetail==null) return const SizedBox.shrink();
    if (sensorDetail==null) return const SizedBox.shrink();
    if (vesselDetail==null) return const SizedBox.shrink();
    final user = userDetail.user;
    final sensor = sensorDetail.sensor;
    final vessel = vesselDetail.vessel;

    String? imagepath = user!.profileImage;
    var imageProfile = imagepath!.contains('https://') ? NetworkImage(imagepath) : FileImage(File(imagepath));

    // return DefaultTabController(
    //   length: 1,
    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 24),
    //           Stack(
    //             alignment: Alignment.topCenter,
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(top: 60),
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.shade300,
    //                   borderRadius: BorderRadius.circular(8),
    //                 ),
    //                 padding: EdgeInsets.fromLTRB(16, 80, 16, 16),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Icon(Icons.badge, color: Colors.purple),
    //                         SizedBox(width: 8),
    //                         Expanded(child: Text("ID: ${user.icNumber}", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18))),
    //                       ],
    //                     ),
    //                     SizedBox(height: 8),
    //                     Row(
    //                       children: [
    //                         Icon(Icons.email, color: Colors.purple),
    //                         SizedBox(width: 8),
    //                         Expanded(child: Text("Email: ${user.email}", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18))),
    //                       ],
    //                     ),
    //                     SizedBox(height: 8),
    //                     Row(
    //                       children: [
    //                         Icon(Icons.person, color: Colors.purple),
    //                         SizedBox(width: 8),
    //                         Expanded(child: Text("Name: ${user.name}", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18))),
    //                       ],
    //                     ),
    //                     SizedBox(height: 8),
    //                     Row(
    //                       children: [
    //                         Icon(Icons.home, color: Colors.purple),
    //                         SizedBox(width: 8),
    //                         Expanded(child: Text("Address: ${user.address}", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 18))),
    //                       ],
    //                     ),
    //                     // Add more details here as needed
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 width: 120,
    //                 height: 120,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   border: Border.all(color: Colors.white, width: 4),
    //                   image: DecorationImage(
    //                     image: imageProfile as ImageProvider,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Purple rectangle
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      // Adjusted container for details
                      Container(
                        margin: EdgeInsets.only(top: 80, left: 32, right: 32),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name centered
                            Center(
                              child: Text("${user.name}",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Email centered and in italic
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min, // Ensure the row only takes up necessary space
                                children: [
                                  Icon(Icons.email, color: Colors.purple),
                                  SizedBox(width: 8), // Provide some spacing between the icon and the text
                                  Text(
                                    "razak@student.usm.my",
                                    style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // Other details adjusted as requested
                            Row(
                              children: [
                                Icon(Icons.badge, color: Colors.purple),
                                SizedBox(width: 8),
                                Expanded(child: Text("${user.icNumber}", style: TextStyle(color: Colors.black, fontSize: 18))), // Non-bold
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.home, color: Colors.purple),
                                SizedBox(width: 8),
                                Expanded(child: Text("${user.address}", style: TextStyle(color: Colors.black, fontSize: 18))), // Non-bold
                              ],
                            ),
                            // Add more details here as needed
                          ],
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            image: imageProfile as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(), // Use Spacer to push everything up
                ],
              ),
            ),
          ),
        ),
      ),
    );










    // return DefaultTabController(
    //   length: 1,
    //   child: Scaffold(
    //     //body: ListView(
    //     body: Column(
    //       //physics: BouncingScrollPhysics(),
    //         children: [
    //           const SizedBox(height: 24,),
    //           Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children:[
    //                 Stack(
    //                   children: <Widget>[
    //                     CircleAvatar(
    //                       backgroundImage: imageProfile as ImageProvider,
    //                       radius: 120 / 2,
    //                       backgroundColor: Colors.black26,
    //                     ),
    //                   ],
    //                 ),
    //
    //                 //const SizedBox(height: 24,),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text("${user.name}",
    //                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize:20),
    //                     ),
    //                     const SizedBox(height: 4,),
    //                     Row(
    //                       children: [
    //                         const Icon(Icons.phone,size: 15,color: Colors.grey,),
    //                         Text(" ${user.phone}",
    //                           style: const TextStyle(color: Colors.grey),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 4,),
    //                     Row(
    //                       children: [
    //                         const Icon(Icons.home,size: 15,color: Colors.grey,),
    //                         Text(" ${user.address}", //" Address",
    //                           style: const TextStyle(color: Colors.grey),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 4,),
    //                     Row(
    //                       children: [
    //                         const Icon(Icons.directions_boat,size: 15,color: Colors.grey,),
    //                         Text(" ${vessel![0].vesselNumber}",
    //                           style: const TextStyle(color: Colors.grey),
    //                         )
    //                       ],
    //                     ),
    //                     const SizedBox(height: 4,),
    //                     Row(
    //                       children: [
    //                         const Icon(Icons.sensors,size: 15,color: Colors.grey,),
    //                         Text(" ${sensor?[0].name}",
    //                           style: const TextStyle(color: Colors.grey),
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ]
    //           ),
    //           const SizedBox(height: 24,),
              /*IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(height: 2,),
                        Text(AppLocalizations.of(context)!.posts), //"Posts",),
                      ],
                    ),
                  ),
                  Container(height: 24, child: VerticalDivider()),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(height: 2,),
                        Text(AppLocalizations.of(context)!.followers), //"Followers",),
                      ],
                    ),
                  ),
                  Container(height: 24, child: VerticalDivider()),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){},
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("10",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(height: 2,),
                        Text(AppLocalizations.of(context)!.following), //"Following",),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
              // const SizedBox(height: 24,),
              //Post photos
              // Expanded(
              //     child: TabBarView(
              //       children: [
              //         GridPost(id: user.id),
              //       ],
              //     )
              // )
        //     ]
        // ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blueGrey,
        //   foregroundColor: Colors.black,
        //   onPressed: (){
        //     //Navigator.of(context).pushNamed("/post");
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const Post(),),);
        //   },
        //   child: const Icon(Icons.add, color: Colors.white,),
        // ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.81,
      width: size.width,
      child: _buildlist(),
    );
  }
}

// class GridPost extends StatefulWidget {
//   final int? id;
//
//   const GridPost({
//     Key? key,
//     required this.id
//   }) : super(key: key);
//
//   @override
//   _GridPost createState() => _GridPost();
// }

// class _GridPost extends State<GridPost>{
//   //List<String?> userPost = [];
//   List<UserPost> userPost = [];
//   late UserPostList posts; //= Listpost.userpostlist as UserPostList;
//   var allposts;
//   var count;
//
//   @override
//   void initState(){
//     refreshPost();
//     super.initState();
//   }
//
//   Future refreshPost() async {
//     //await Listpost.getlistpost();
//     await Listpost.getbyuserid();
//
//     userPost.clear();
//       setState(() {
//       posts = Listpost.userpostlist as UserPostList;
//       allposts = posts.data;
//       count = posts.data!.length;
//
//       //Store user photos in a list
//
//       for (int i=0; i<count; i++) {
//         final Upost = allposts![i];
//         //var userID = Upost.user_id;
//         //if (userID == widget.id) {
//         //var imagePath = Upost.image_url;
//         //userPost.add(imagePath);
//         addlist(Upost.id, Upost.image_url, Upost.caption);
//         //}
//       }
//
//     });
//   }
//
//
//   void addlist(int? id, String? imageUrl, String? caption){
//     final addtolist = UserPost(
//         id: id,
//         image_url: imageUrl,
//         //user_id: user_id,
//         caption: caption
//     );
//     setState(() {
//       userPost.add(addtolist);
//     });
//   }

  // @override
  // Widget build(BuildContext context){
  //   return RefreshIndicator(
  //     onRefresh: refreshPost,
  //     child: GridView.builder(
  //       //itemCount: count,
  //         itemCount: userPost.length,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
  //         itemBuilder: (context, index){
  //           //final post = allposts[index];
  //           //var imagePath = post.image_url;
  //           //var image = imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));
  //
  //           //----
  //           final post = userPost[index];
  //           var imagePath = post.image_url;
  //           var image = imagePath!.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));
  //
  //           //var image = post!.contains('https://') ? NetworkImage(post) : FileImage(File(post));
  //
  //
  //           return GestureDetector(
  //             child: Padding(
  //               padding: const EdgeInsets.all(2.0),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     image: DecorationImage(
  //                       image: image as ImageProvider,
  //                       fit: BoxFit.cover,
  //                     )
  //                 ),
  //               ),
  //             ),
  //             onTap: (){
  //               Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPost(imageTemp: imagePath, id: post.id, caption: post.caption),),);
  //             },
  //           );
  //         }
  //     ),
  //   );
  // }
// }


/*
class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  Widget _buildlist() {
    var sensor = Detail.information!.sensor;
    var user = Detail.information!.user;
    var vessel = Detail.information!.vessel;
    return ListView(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: 300,
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: FractionalOffset(0.025, 0.03),
                      child: Text(
                        "User Information",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ListTile(
                      title: Text("Name: ${user!.name}"),
                    ),
                    ListTile(
                      title: Text("IC number: ${user.icNumber}"),
                    ),
                    ListTile(
                      title: Text("Phone Number: ${user.phone}"),
                    ),
                    ListTile(
                      title: Text("Address: ${user.address}"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Card(
          color: Colors.transparent,
          child: ExpansionTile(
            initiallyExpanded: true,
            title: const Text(
              "Vessel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: const SizedBox.shrink(),
            children: <Widget>[
              ListTile(
                title: Text("Vessel Number: ${vessel![0].vesselNumber}"),
              ),
              ListTile(
                title: Text(
                    "License Insuance Date: ${vessel[0].licenseIssuanceDate}"),
              ),
              ListTile(
                title: Text(
                    "License valid date: ${vessel[0].licenseValidUntilDate}"),
              ),
            ],
          ),
        ),
        Card(
          color: Colors.transparent,
          child: ExpansionTile(
            initiallyExpanded: true,
            title: const Text(
              "Sensor",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            trailing: SizedBox.shrink(),
            children: <Widget>[
              ListTile(
                title: Text("Sensor Name: ${sensor![0].name}"),
              ),
              ListTile(
                title: Text("Sensor EUI: ${sensor[0].eui}"),
              ),
              ListTile(
                title: Text("Brand: ${sensor[0].brand}"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.9,
      width: size.width,
      child: _buildlist(),
    );
  }
}*/
