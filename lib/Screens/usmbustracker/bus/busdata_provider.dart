/*import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nelayannet/influx.dart';
//import 'package:provider/provider.dart';
import 'dart:async';
import 'package:nelayannet/Services/distance_matrix_api.dart';

class BusDataProvider with ChangeNotifier {
  final Getfirstdata getFirstData;
  final Getsecdata getSecData;

  Map<String, double> _firstBusData = {};
  Map<String, double> _secBusData = {};
  Map<String, Map<String, double>> _routeEtas = {};

  final Map<String, Map<String, Map<String, double>>> _routes = {
    'laluan B': {
      'Comp Sc': {'lat': 5.354, 'lng': 100.3027},
      'Aman Damai': {'lat': 5.355, 'lng': 100.2969},
      'Komca': {'lat': 5.360, 'lng': 100.3022},
      'DKSK': {'lat': 5.3593, 'lng': 100.3046},
      'HBP': {'lat': 5.3558, 'lng': 100.3062},
      // Add more stops as needed for route1
    },
    'laluan D': {
      'Padang Kawad': {'lat': 5.223, 'lng': 100.556},
      'Komca': {'lat': 5.360, 'lng': 100.3022},
      'DKSK': {'lat': 5.3593, 'lng': 100.3046},
      'HBP': {'lat': 5.3558, 'lng': 100.3062},
      'Aman Damai': {'lat': 5.355, 'lng': 100.2969},
      'Indah Kembara': {'lat': 5.3560, 'lng': 100.2953},

      // Add more stops as needed for route2
    },
  };

  BusDataProvider(this.getFirstData, this.getSecData) {
    _fetchDataPeriodically();
  }

  Map<String, double> get firstBusData => _firstBusData;

  Map<String, double> get secBusData => _secBusData;

  Map<String, Map<String, double>> get routeEtas => _routeEtas;

  Future<void> fetchBusData() async {
    _firstBusData = await getFirstData.fetchfirstData();
    _secBusData = await getSecData.fetchsecData();
    await _calculateEtas();
    notifyListeners();
  }

  Future<void> _fetchDataPeriodically() async {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      await fetchBusData();
    });
  }


  Future<void> _calculateEtas() async {
    _routeEtas.clear();

    for (var route in _routes.entries) {
      var etas = <String, double>{};

      for (var stop in route.value.entries) {
        Map<String, double> busData;
        if (route.key == 'laluan B') {
          busData = _firstBusData;
        } else {
          busData = _secBusData;
        }

        if (busData.isNotEmpty) {
          // Use Distance Matrix API to calculate ETA
          double firstEta = await DistanceMatrixAPI.getEta(
              firstBusData['latitude']!, firstBusData['longitude']!,
              stop.value['lat']!, stop.value['lng']!);

          double secEta = await DistanceMatrixAPI.getEta(
              secBusData['latitude']!, secBusData['longitude']!,
              stop.value['lat']!, stop.value['lng']!);

          etas[stop.key] = {'firstBus': firstEta, 'secBus': secEta};
        }
      }

      _routeEtas[route.key] = etas;
    }

    notifyListeners();
  }
}

 */

