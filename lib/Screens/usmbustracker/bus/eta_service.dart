/*
import 'dart:convert';
//import 'package:http/http.dart' as http;

Future<List<ETA>> fetchETA() async {
  final response = await http.get(Uri.parse('http://10.207.201.177:5000/etas'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => ETA.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load ETA data');
  }
}


class ETA {
  final int id;
  final int routeId;
  final int busId;
  final int stopId;
  final DateTime estimatedTimeArrival;
  final DateTime timestamp;

  ETA({
    required this.id,
    required this.routeId,
    required this.busId,
    required this.stopId,
    required this.estimatedTimeArrival,
    required this.timestamp,
  });

  factory ETA.fromJson(Map<String, dynamic> json) {
    return ETA(
      id: json['id'],
      routeId: json['route_id'],
      busId: json['bus_id'],
      stopId: json['stop_id'],
      estimatedTimeArrival: DateTime.parse(json['estimated_time_arrival']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

 */
