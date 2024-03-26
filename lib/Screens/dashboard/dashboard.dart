import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:nelayannet/Screens/FishingSpot/saved_spot.dart';
import 'package:nelayannet/Services/shared_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../Services/detaillist.dart';
import '../../../Model/userposts_model.dart';
import 'package:nelayannet/Screens/profile/components/viewpost_interface.dart';
// import 'package:nelayannet/Screens/profile/components/post_interface.dart';
import 'dart:io';
import 'package:intl/intl.dart';
// import '../profile/profile.dart';


// import '../Analytic/analytic.dart';
// import '../Journey/journey.dart';
// import '../fishermanlist/fishermanlist.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

  static void checkLogin(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token') ?? '';
    bool isExpired = JwtDecoder.isExpired(token);

    if (isExpired) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Session has Expired"),
              content: const Text("You will be logged out after pressing OK"),
              actions: [
                TextButton(
                  onPressed: () {
                    SharedService.logout(context);
                  },
                  child: const Text("OK"),
                )
              ],
            );
          });
    }
  }
}

class _DashboardState extends State<Dashboard> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  // Assume userPosts is defined and populated within this class
  List<UserPost> userPosts = []; // Populate this list as per your logic

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 500) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<String> imgList = [
      'assets/images/image1.png',
      'assets/images/image2.png',
      'assets/images/image3.png',
    ];

    final List<Map<String, String>> phoneNumbers = [
      {'name': 'Security Department', 'number': '04-653 4333'},
      {'name': 'Pegawai Fajar Harapan', 'number': '04-333 6565'},
      {'name': 'Pegawai Cahaya Gemilang', 'number': '04-444 6565'},
      {'name': 'Pegawai Aman Damai', 'number': '04-555 6565'},
      {'name': 'Pegawai Indah Kembara', 'number': '04-666 6565'},
      {'name': 'Pegawai Tekun', 'number': '04-777 6565'},
      {'name': 'Pegawai Restu', 'number': '04-888 6565'},
      {'name': 'Pegawai Saujana', 'number': '04-999 6565'},
    ];


    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Homepage",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => const Profilepage()),
          //     );
          //   },
          //   child: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     radius: 18,
          //     child: const Icon(Icons.person, color: Colors.purple),
          //   ),
          // ),
          // const SizedBox(width: 10), // Optional, for spacing
          // InkWell(
          //   onTap: () {
          //   },
          //   child: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     radius: 18,
          //     child: const Icon(Icons.search, color: Colors.purple),
          //   ),
          // ),
          // const SizedBox(width: 10), // Optional, for spacing
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), // Makes the corners rounded
                    child: Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints(maxHeight: 500), // Adjust the size as needed
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Makes the dialog height fit the content
                        children: <Widget>[
                          Text(
                            'Contact Numbers',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              itemCount: phoneNumbers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(phoneNumbers[index]['name']!),
                                  subtitle: Text(phoneNumbers[index]['number']!),
                                  onTap: () {
                                    // Optional: action on tap
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Close'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Background color
                              onPrimary: Colors.white, // Text color
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: const Icon(Icons.phone, color: Colors.purple),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              SharedService.logout(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: const Icon(Icons.logout, color: Colors.purple),
            ),
          ),
          const SizedBox(width: 10),
        ],
        flexibleSpace: Container(
          color: Colors.purple,
        ),
      ),
      body: Column(
        children: [
          // Secondary toolbar-like row
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.purpleAccent, Colors.purple, Colors.purpleAccent],
          //       begin: Alignment.bottomRight,
          //       end: Alignment.topLeft,
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         IconButton(
          //           icon: const Icon(Icons.home, color: Colors.white),
          //           onPressed: () {
          //             // Action for homepage icon
          //           },
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.person, color: Colors.white),
          //           onPressed: () {
          //             // Action for profile icon
          //           },
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.warning, color: Colors.white),
          //           onPressed: () {
          //             // Action for emergency icon
          //           },
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.directions_bus, color: Colors.white),
          //           onPressed: () {
          //             // Action for bus icon
          //           },
          //         ),
          //         IconButton(
          //           icon: const Icon(Icons.notifications, color: Colors.white),
          //           onPressed: () {
          //             // Action for notification icon
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            // Wrap the carousel and content below it in a SingleChildScrollView
            child: SingleChildScrollView(
              controller: _scrollController, // Attach the ScrollController here
              child: Column(
                children: [
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.5,
                      enlargeCenterPage: true,
                      viewportFraction: 0.6,
                    ),
                    items: imgList.map((item) => Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                    )).toList(),
                  ),
                  const SizedBox(height: 14),
                  // Announcement Section with Icon
                  Container(
                    width: double.infinity, // Ensures it stretches across the screen
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: Colors.purple.shade100, // Example color
                    // decoration: BoxDecoration(
                    //     color: Colors.purple.shade100
                    //   // border: Border(
                    //   //   bottom: BorderSide(
                    //   //     color: Colors.purple.shade100, // Color of the bottom border
                    //   //     width: 5.0, // Thickness of the bottom border
                    //     ),
                    //   ),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the content
                      children: [
                        Icon(
                          Icons.campaign, // Example icon
                          color: Colors.red, // Icon color
                          size: 24, // Icon size
                        ),
                        SizedBox(width: 10), // Space between icon and text
                        Text(
                          "Announcements",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // The rest of your body content
                  GridPost(id: 1), // Assuming GridPost is a custom widget for displaying posts.
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo( // Scroll back to the top
            0,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
          );
        },
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white, // Set the icon color to white
        ),
        backgroundColor: Colors.purple, // You can adjust the button color as needed
      ),
    );
  }
}

class GridPost extends StatefulWidget {
  final int? id;

  const GridPost({Key? key, required this.id}) : super(key: key);

  @override
  _GridPostState createState() => _GridPostState();
}

class _GridPostState extends State<GridPost> {
  List<UserPost> userPosts = [];
  late UserPostList posts;
  var allPosts;
  var count;

  @override
  void initState() {
    super.initState();
    refreshPost();
  }

  Future<void> refreshPost() async {
    await Listpost.getbyuserid();

    userPosts.clear();
    setState(() {
      posts = Listpost.userpostlist as UserPostList;
      allPosts = posts.data;
      count = posts.data?.length ?? 0;

      for (var upost in allPosts ?? []) {
        addList(upost.id, upost.image_url, upost.caption, upost.uploaded_at); // Assuming you've added 'uploaded_at'
      }

      // Sort userPosts in descending order based on the ID
      userPosts.sort((a, b) => b.id!.compareTo(a.id!));
    });
  }

  void addList(int? id, String? imageUrl, String? caption, String? uploadedAt) { // Modify this line
    final addToList = UserPost(id: id, image_url: imageUrl, caption: caption, uploaded_at: uploadedAt); // Modify this line
    setState(() {
      userPosts.add(addToList);
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPost,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(), // Important to avoid scrolling within scrolling
        shrinkWrap: true, // Important to adapt to content size within a non-scrolling parent
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          final post = userPosts[index];
          var imagePath = post.image_url;
          var image = imagePath!.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));
          DateTime parsedDate = post.uploaded_at != null ? DateTime.parse(post.uploaded_at!) : DateTime.now();
          String formattedDate = DateFormat('d MMMM yyyy, hh:mm a').format(parsedDate);

          return GestureDetector(
            onTap: () {
              // Navigation logic, if any
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${formattedDate} - ${post.caption ?? ''}'),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image(
                        image: image as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

