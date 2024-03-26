// import 'package:flutter/material.dart';
// import 'package:nelayannet/Screens/Journey/components/distance.dart';
// import 'package:nelayannet/Screens/tracking/components/locationlist.dart';
//
// // class TrackingPage extends StatelessWidget {
// //   const TrackingPage({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: <Widget>[
// //             Container(
// //               padding: const EdgeInsets.symmetric(
// //                 vertical: 20.0,
// //                 horizontal: 20.0,
// //               ),
// //               // Example content here
// //             ),
// //             Container(
// //               height: 300, // Adjust based on your needs
// //               child: const LocationsList(),
// //             ),
// //             // Other widgets can go here
// //           ],
// //         ),
// //       ),
// //     );
// //
// //   }
// // }
//
// class TrackingPage extends StatelessWidget {
//   const TrackingPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 20.0,
//                 horizontal: 20.0,
//               ),
//               // Example content here, such as a title or introductory text.
//             ),
//             ElevatedButton(
//               onPressed: () => _showLocationsList(context),
//               child: Text('Show Locations'),
//             ),
//             // Other widgets can go here.
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showLocationsList(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75, // Adjust the height as needed
//         child: const LocationsList(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/Journey/components/distance.dart';
import 'package:nelayannet/Screens/tracking/components/locationlist.dart';
import 'package:nelayannet/Screens/tracking/components/mapscreen.dart';


class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Use Stack to layer your widgets
        children: <Widget>[
          MapScreen(), // This is your background map
          SingleChildScrollView( // Your UI elements on top of the map
            child: Column(
              children: <Widget>[
                // Use Container with decoration to ensure the text or buttons are visible on the map
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withOpacity(0.8), // Semi-transparent white background
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  // child: Text(
                  //   'Your Location',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                ),
                ElevatedButton(
                  onPressed: () => _showLocationsList(context),
                  child: Text('Show Emergency Button Locations'),
                ),
                // Other widgets can go here.
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationsList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75, // Adjust the height as needed
        child: const LocationsList(),
      ),
    );
  }
}
