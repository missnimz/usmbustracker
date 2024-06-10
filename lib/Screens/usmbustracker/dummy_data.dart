/*
import 'dart:convert';
class BusStop {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String eta;

  BusStop({required this.id, required this.name, required this.latitude, required this.longitude, required this.eta});

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      eta: json['eta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'eta': eta,
    };
  }
}

Future<List<BusStop>> fetchDummyBusStops() async {
  await Future.delayed(Duration(seconds: 1)); // Simulate network delay

  final dummyResponse = '''
  [
    {"id": 1, "name": "Padang Kawad", "latitude": 5.35704, "longitude": 100.29335, "eta": "5 mins"},
    {"id": 2, "name": "Indah Kembara", "latitude": 5.35599, "longitude": 100.29518, "eta": "10 mins"},
    {"id": 3, "name": "Aman Damai", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    {"id": 4, "name": "", "latitude": 5.35628, "longitude": 100.30054, "eta": "15 mins"}
    {"id": 5, "name": "Pusat Sejahtera", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    {"id": 6, "name": "Aman Damai", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    {"id": 7, "name": "Aman Damai", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    {"id": 8, "name": "Aman Damai", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    {"id": 9, "name": "Aman Damai", "latitude": 5.35504, "longitude": 100.297, "eta": "15 mins"}
    
  ]
  ''';

  List<dynamic> jsonData = json.decode(dummyResponse);
  return jsonData.map((json) => BusStop.fromJson(json)).toList();
}

 */
