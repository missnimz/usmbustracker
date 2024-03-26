import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/tracking/components/mapscreen.dart';


class LocationsList extends StatefulWidget {
  const LocationsList({Key? key}) : super(key: key);

  @override
  State<LocationsList> createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  final List<Map<String, dynamic>> locations = [
    {
      "name": "Bus Stop 1",
      "coordinates": "5.356630, 100.289000",
      "info": "Near Faculty of Engineering",
      "type": "Bus Stop",
    },
    {
      "name": "Accommodation 1",
      "coordinates": "5.356590, 100.295000",
      "info": "Close to Cafeteria",
      "type": "Accommodation",
    },
    // Add more locations as needed
  ];

  String _selectedType = "Bus Stop"; // Default selection

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredLocations = locations
        .where((location) => location['type'] == _selectedType)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Adjusting the dropdown width
            child: DropdownButton<String>(
              value: _selectedType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              items: <String>['Bus Stop', 'Accommodation']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true, // Add this to constrain the list's size
            physics: NeverScrollableScrollPhysics(), // Add this to disable the ListView's own scrolling
            itemCount: filteredLocations.length,
            itemBuilder: (context, index) {
              return LocationCard(location: filteredLocations[index]);
            },
          ),
          // child: ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: filteredLocations.length,
          //   itemBuilder: (context, index) {
          //     final location = filteredLocations[index];
          //     return LocationCard(
          //       location: location,
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(selectedLocation: location)));
          //       },
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}

class LocationCard extends StatelessWidget {
  final Map<String, dynamic> location;

  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped on ${location['name']}");
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location['name'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Coordinates: ${location['coordinates']}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 5),
            Text(
              location['info'],
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}


// class LocationCard extends StatelessWidget {
//   final Map<String, dynamic> location;
//   final VoidCallback onTap;
//
//   const LocationCard({Key? key, required this.location, required this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // Use the callback here
//       child: Container(
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.purple.shade50,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               location['name'],
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               'Coordinates: ${location['coordinates']}',
//               style: TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             SizedBox(height: 5),
//             Text(
//               location['info'],
//               style: TextStyle(fontSize: 16, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
