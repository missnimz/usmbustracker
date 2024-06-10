/*
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistanceMatrixAPI {
  static const String apiKey = 'AIzaSyDkuGZreKvhWhLfN5MqHhL9ysYk9Yq1HwY';

  static Future<double> getEta(double originLat, double originLng, double destLat, double destLng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$originLat,$originLng&destinations=$destLat,$destLng&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final elements = jsonResponse['rows'][0]['elements'];
      if (elements[0]['status'] == 'OK') {
        final durationInSeconds = elements[0]['duration']['value'];
        final etaMinutes = durationInSeconds / 60.0;
        return etaMinutes;
      } else {
        throw Exception('Error calculating ETA: ${elements[0]['status']}');
      }
    } else {
      throw Exception('Failed to load Distance Matrix API');
    }
  }
}

 */

/*
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> calculateETA({LatLng origin, String destination}) async {
  // Replace with your Distance Matrix API key
  String apiKey = 'YOUR_API_KEY';

  // Example destination coordinates (replace with actual data)
  Map<String, LatLng> busStopCoordinates = {
    'Stop 1': LatLng(5.3544, 100.3019),
    'Stop 2': LatLng(5.3545, 100.3020),
    'Stop 3': LatLng(5.3546, 100.3021),
  };

  LatLng destCoords = busStopCoordinates[destination];

  String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${origin.latitude},${origin.longitude}&destinations=${destCoords.latitude},${destCoords.longitude}&key=$apiKey';

  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);

  if (json['status'] == 'OK') {
    var elements = json['rows'][0]['elements'][0];
    if (elements['status'] == 'OK') {
      var duration = elements['duration']['text'];
      return duration;
    }
  }

  return 'N/A';
}

 */
/*
import 'dart:convert';
import 'package:http/http.dart' as http;


class DistanceMatrixApi {
  final String apiKey;

  DistanceMatrixApi(this.apiKey);

  Future<int> getETA(String origin, String destination) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final duration = data['rows'][0]['elements'][0]['duration']['value'];
      return duration; // Duration in seconds
    } else {
      throw Exception('Failed to load ETA');
    }
  }
}

 */


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceMatrixApi {
  final String apiKey;

  DistanceMatrixApi(this.apiKey);

  Future<int> getETA(LatLng origin, LatLng destination) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/distancematrix/json'
          '?units=metric&origins=${origin.latitude},${origin.longitude}'
          '&destinations=${destination.latitude},${destination.longitude}'
          '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final duration = data['rows'][0]['elements'][0]['duration']['value'];
      return (duration / 60).round(); // Convert to minutes
    } else {
      throw Exception('Failed to load distance matrix data');
    }
  }
}

