/*
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:nelayannet/influx.dart';
import 'package:geolocator/geolocator.dart';

Future<Map<String, dynamic>> fetchData(String sensorId, Getfirstdata getFirstData, Getsecdata getSecData) async {
  try {
    Map<String, double> data;
    if (sensorId == 'sensor1') {
      data = await getFirstData.fetchfirstData();
    } else if (sensorId == 'sensor2') {
      data = await getSecData.fetchsecData();
    } else {
      throw Exception('Invalid sensorId');
    }

    double accelerationX = (data['acceleration_x'] ?? 0) * 9.81;
    double accelerationY = (data['acceleration_y'] ?? 0) * 9.81;
    double accelerationZ = (data['acceleration_z'] ?? 0) * 9.81;

    return {
      'latitude': data['latitude'],
      'longitude': data['longitude'],
      'acceleration_x': accelerationX,
      'acceleration_y': accelerationY,
      'acceleration_z': accelerationZ,
    };
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to load data');
  }
}

/*
double calculateSpeed(double acceleration_x, double acceleration_y, double acceleration_z, double time) {
  double acceleration = sqrt(pow(acceleration_x, 2) + pow(acceleration_y, 2) + pow(acceleration_z, 2));
  return acceleration * time; // speed in m/s
}

 */

//kalau takleh jugak, guna geolocator.distancebetween je
/*
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371e3; // Earth radius in meters
  final phi1 = lat1 * pi / 180;
  final phi2 = lat2 * pi / 180;
  final deltaPhi = (lat2 - lat1) * pi / 180;
  final deltaLambda = (lon2 - lon1) * pi / 180;

  final a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
      cos(phi1) * cos(phi2) *
          sin(deltaLambda / 2) * sin(deltaLambda / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c; // distance in meters
}

 */

double calculateSpeed(double acceleration_x, double acceleration_y, double acceleration_z, double time) {


  // Convert acceleration from g to m/s²
  /*
  double acceleration_x = acceleration_x_g * 9.81;
  double acceleration_y = acceleration_y_g * 9.81;
  double acceleration_z = acceleration_z_g * 9.81;
   */

  // Calculate acceleration magnitude
  double acceleration = sqrt(pow(acceleration_x, 2) + pow(acceleration_y, 2) + pow(acceleration_z, 2));

  return acceleration * time; // speed in m/s
}

double calculateETA(double distance, double speed) {
  return distance / speed / 60; // ETA in minutes
}
 */

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:nelayannet/influx.dart';
import 'package:geolocator/geolocator.dart';

// Function to fetch data from sensors
Future<Map<String, dynamic>> fetchData(String sensorId, Getfirstdata getFirstData, Getsecdata getSecData) async {
  try {
    Map<String, double> data;
    if (sensorId == 'sensor1') {
      data = await getFirstData.fetchfirstData();
    } else if (sensorId == 'sensor2') {
      data = await getSecData.fetchsecData();
    } else {
      throw Exception('Invalid sensorId');
    }

    return {
      'latitude': data['latitude'],
      'longitude': data['longitude'],
    };
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to load data');
  }
}

// Fixed average speed in m/s (30 km/h)
//const double fixedSpeed = 8.33;

//double calculateETA(double distance, double speed) {
  //return distance / speed / 60; // ETA in minutes
//}


