/*--------------------TRY NI DULU----------------------------------
import 'package:influxdb_client/api.dart';
import 'dart:async';

class BusLocation {
  double lat;
  double long;
  double accelerationX;
  double accelerationY;
  double accelerationZ;
  //String measurement;

  BusLocation(this.lat, this.long, this.accelerationX, this.accelerationY, this.accelerationZ);

  @override
  String toString() {
    return 'BusLocation(lat: $lat, long: $long, accelerationX: $accelerationX, accelerationY: $accelerationY, accelerationZ: $accelerationZ )';
  }
}

class Getdata {
  String bucket = "LoRASensors"; // Replace with your actual bucket name

  var client = InfluxDBClient(
    url: 'http://moby.cs.usm.my:8086',
    token: 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==', // Replace with your actual token
    org: 'medinalab', // Replace with your actual organization name
    bucket: 'LoRASensors', // Replace with your actual bucket name
  );

  Future<Map<String, BusLocation>> fetchData() async {
    String sensor1 = "Sensor1"; // Replace with your actual sensor ID or name
    String sensor2 = "Sensor2"; // Replace with your actual sensor ID or name
    String query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["sensor_id"] == "$sensor1" or r["sensor_id"] == "$sensor2")
      |> filter(fn: (r) => r._field == "latitude" or r._field == "longitude" or r._field == "accelerationX" or r._field == "accelerationY" or r._field == "accelerationZ")
    ''';

    var data = {
      sensor1: BusLocation(0.0, 0.0, 0.0, 0.0, 0.0),
      sensor2: BusLocation(0.0, 0.0, 0.0, 0.0, 0.0),
    };

    try {
      var queryService = client.getQueryService();
      var queryResult = await queryService.query(query);
      await queryResult.forEach((record) {
        var sensorId = record['sensor_id'];
        if (sensorId == sensor1 || sensorId == sensor2) {
          if (record['_field'] == 'latitude') {
            data[sensorId]?.lat = record['_value'];
          } else if (record['_field'] == 'longitude') {
            data[sensorId]?.long = record['_value'];
          } else if (record['_field'] == 'accelerationX') {
            data[sensorId]?.accelerationX = record['_value'];
          } else if (record['_field'] == 'accelerationY') {
            data[sensorId]?.accelerationY = record['_value'];
          } else if (record['_field'] == 'accelerationZ') {
            data[sensorId]?.accelerationZ = record['_value'];
          }
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    return data;
  }

  Future<void> fetchAndPrintData() async {
    Map<String, BusLocation> data = await fetchData();
    data.forEach((sensorId, busLocation) {
      print('Sensor: $sensorId');
      print(busLocation);
    });
  }
}

 --------------------------------------------------*/

import 'package:influxdb_client/api.dart';
import 'dart:async';


class InfluxDBManager {
  final InfluxDBClient client;

  InfluxDBManager(String url, String token, String org, String bucket)
      : client = InfluxDBClient(url: url, token: token, org: org, bucket: bucket);

  void close() {
    client.close();
  }
}

class Getfirstdata {
  final InfluxDBManager influxDBManager;
  final String bucket = "LoRASensors"; // Replace with your actual bucket name

  Getfirstdata(this.influxDBManager);

  Future<Map<String, double>> fetchfirstData() async {
    String measurement = "AC1F09FFFE0037B5"; // Replace with your actual measurement name
    String query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "$measurement")
      |> filter(fn: (r) => r._field == "latitude" or r._field == "longitude" or r._field == "acceleration_x" or r._field == "acceleration_y" or r._field == "acceleration_z")
    ''';

    var fdata = {
      "latitude": 0.0,
      "longitude": 0.0,
      "acceleration_x": 0.0,
      "acceleration_y": 0.0,
      "acceleration_z": 0.0,
    };

    try {
      var queryService = influxDBManager.client.getQueryService();
      var queryResult = await queryService.query(query);
      await queryResult.forEach((record) {
        if (record['_field'] == 'latitude') {
          fdata['latitude'] = record['_value'];
        } else if (record['_field'] == 'longitude') {
          fdata['longitude'] = record['_value'];
        } else if (record['_field'] == 'acceleration_x') {
          fdata['acceleration_x'] = record['_value'];
        } else if (record['_field'] == 'acceleration_y') {
          fdata['acceleration_y'] = record['_value'];
        } else if (record['_field'] == 'acceleration_z') {
          fdata['acceleration_z'] = record['_value'];
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
    return fdata;
  }

  Future<void> fetchAndPrintData() async {
    Map<String, double> data = await fetchfirstData();
    print('FLatitude: ${data['latitude']}');
    print('FLongitude: ${data['longitude']}');
    print('FAccelerationX: ${data['acceleration_x']}');
    print('FAccelerationY: ${data['acceleration_y']}');
    print('FAccelerationZ: ${data['acceleration_z']}');
  }
}

class Getsecdata {
  final InfluxDBManager influxDBManager;
  final String bucket = "LoRASensors"; // Replace with your actual bucket name

  Getsecdata(this.influxDBManager);

  Future<Map<String, double>> fetchsecData() async {
    String measurement = "AC1F09FFFE0037B7"; // Replace with your actual measurement name
    String query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "$measurement")
      |> filter(fn: (r) => r._field == "latitude" or r._field == "longitude" or r._field == "acceleration_x" or r._field == "acceleration_y" or r._field == "acceleration_z")
    ''';

    var sdata = {
      "latitude": 0.0,
      "longitude": 0.0,
      "acceleration_x": 0.0,
      "acceleration_y": 0.0,
      "acceleration_z": 0.0,
    };

    try {
      var queryService = influxDBManager.client.getQueryService();
      var queryResult = await queryService.query(query);
      await queryResult.forEach((record) {
        if (record['_field'] == 'latitude') {
          sdata['latitude'] = record['_value'];
        } else if (record['_field'] == 'longitude') {
          sdata['longitude'] = record['_value'];
        } else if (record['_field'] == 'acceleration_x') {
          sdata['acceleration_x'] = record['_value'];
        } else if (record['_field'] == 'acceleration_y') {
          sdata['acceleration_y'] = record['_value'];
        } else if (record['_field'] == 'acceleration_z') {
          sdata['acceleration_z'] = record['_value'];
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
    return sdata;
  }

  Future<void> fetchAndPrintData() async {
    Map<String, double> data = await fetchsecData();
    print('SLatitude: ${data['latitude']}');
    print('SLongitude: ${data['longitude']}');
    print('SAccelerationX: ${data['acceleration_x']}');
    print('SAccelerationY: ${data['acceleration_y']}');
    print('SAccelerationZ: ${data['acceleration_z']}');
  }
}

Future<void> fetchDataAndClose() async {
  var influxDBManager = InfluxDBManager(
    'http://moby.cs.usm.my:8086',
    'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
    'medinalab',
    'LoRASensors',
  );

  var getFirstData = Getfirstdata(influxDBManager);
  var getSecData = Getsecdata(influxDBManager);

  await getFirstData.fetchAndPrintData();
  await getSecData.fetchAndPrintData();

  influxDBManager.close();
}






