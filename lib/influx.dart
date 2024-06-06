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






/*------first draft yg jadi
import 'package:influxdb_client/api.dart';
import 'dart:async';


class Getfirstdata {

  String bucket = "LoRASensors"; // Replace with your actual bucket name

  var client = InfluxDBClient(
    url: 'http://moby.cs.usm.my:8086',
    token: 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==', // Replace with your actual token
    org: 'medinalab', // Replace with your actual organization name
    bucket: 'LoRASensors', // Replace with your actual bucket name
  );

  Future<Map<String, double>> fetchfirstData() async {
    String measurement = "AC1F09FFFE0037B5"; // Replace with your actual measurement name
    String query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "$measurement")
      |> filter(fn: (r) => r._field == "latitude" or r._field == "longitude" or r._field == "accelerationX" or r._field == "accelerationY" or r._field == "accelerationZ")
    ''';

    var fdata = {
      "latitude": 0.0,
      "longitude": 0.0,
      "accelerationX": 0.0,
      "accelerationY": 0.0,
      "accelerationZ": 0.0,
    };

    try {
      var queryService = client.getQueryService();
      var queryResult = await queryService.query(query);
      await queryResult.forEach((record) {
        if (record['_field'] == 'latitude') {
          fdata['latitude'] = record['_value'];
        } else if (record['_field'] == 'longitude') {
          fdata['longitude'] = record['_value'];
        } else if (record['_field'] == 'accelerationX') {
          fdata['accelerationX'] = record['_value'];
        } else if (record['_field'] == 'accelerationY') {
          fdata['accelerationY'] = record['_value'];
        } else if (record['_field'] == 'accelerationZ') {
          fdata['accelerationZ'] = record['_value'];
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
    print('FAccelerationX: ${data['accelerationX']}');
    print('FAccelerationY: ${data['accelerationY']}');
    print('FAccelerationZ: ${data['accelerationZ']}');
  }
}

class Getsecdata {
  String bucket = "LoRASensors"; // Replace with your actual bucket name

  var client = InfluxDBClient(
    url: 'http://moby.cs.usm.my:8086',
    token: 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==', // Replace with your actual token
    org: 'medinalab', // Replace with your actual organization name
    bucket: 'LoRASensors', // Replace with your actual bucket name
  );

  Future<Map<String, double>> fetchsecData() async {
    String measurement = "AC1F09FFFE0037B7"; // Replace with your actual measurement name
    String query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "$measurement")
      |> filter(fn: (r) => r._field == "latitude" or r._field == "longitude" or r._field == "accelerationX" or r._field == "accelerationY" or r._field == "accelerationZ")
    ''';

    var sdata = {
      "latitude": 0.0,
      "longitude": 0.0,
      "accelerationX": 0.0,
      "accelerationY": 0.0,
      "accelerationZ": 0.0,
    };

    try {
      var queryService = client.getQueryService();
      var queryResult = await queryService.query(query);
      await queryResult.forEach((record) {
        if (record['_field'] == 'latitude') {
          sdata['latitude'] = record['_value'];
        } else if (record['_field'] == 'longitude') {
          sdata['longitude'] = record['_value'];
        } else if (record['_field'] == 'accelerationX') {
          sdata['accelerationX'] = record['_value'];
        } else if (record['_field'] == 'accelerationY') {
          sdata['accelerationY'] = record['_value'];
        } else if (record['_field'] == 'accelerationZ') {
          sdata['accelerationZ'] = record['_value'];
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      client.close();
    }
    return sdata;
  }

  Future<void> fetchAndPrintData() async {
    Map<String, double> data = await fetchsecData();
    print('SLatitude: ${data['latitude']}');
    print('SLongitude: ${data['longitude']}');
    print('SAccelerationX: ${data['accelerationX']}');
    print('SAccelerationY: ${data['accelerationY']}');
    print('SAccelerationZ: ${data['accelerationZ']}');
  }
}

 */










/*--------------------------YANG KELUAR 0.0----------------------------
import 'dart:async';
import 'package:influxdb_client/api.dart';
//import 'package:nelayannet/Services/flutter_secure_storage.dart';


class UserLocation {
  double lat;
  double long;
  double accelerationX;
  double accelerationY;
  double accelerationZ;
  //String measurement;

  UserLocation(this.lat, this.long, this.accelerationX, this.accelerationY, this.accelerationZ);

  @override
  String toString() {
    return 'UserLocation(lat: $lat, long: $long, accelerationX: $accelerationX, accelerationY: $accelerationY, accelerationZ: $accelerationZ )';
  }
}



class Getdata {
  String bucket = "LoRASensors";
  //List<UserLocation> userlocation = [];
  List<String> measurement = ["AC1F09FFFE0037B5", "AC1F09FFFE0037B7"];
  //String measurement = "Lora Environmental Node 1";

  Future<void> getUserLocation() async {
    var client = InfluxDBClient(
      url: 'http://moby.cs.usm.my:8086',
      token: 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
      org: 'medinalab',
      bucket: 'LoRASensors',
    );

    var query = '''
      from(bucket: "$bucket")
      |> range(start: -1h)
      |> filter(fn: (r) => r["_measurement"] == "$measurement")
      |> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude" or r["_field"] == "acceleration_x" or r["_field"] == "acceleration_y" or r["_field"] == "acceleration_z")
      
    ''';
    //|> filter(fn: (r) => r._field == "temp" or r._field == "gaslevel" or r._field == "humidity")
    //|> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude" or r["_field"] == "acceleration_x" or r["_field"] == "acceleration_y" or r["_field"] == "acceleration_z")
    //var data = <UserLocation>[];
    var queryService = client.getQueryService();
    var recordStream = await queryService.query(query);

    await recordStream.forEach((record) {

      double lat = double.tryParse(record['latitude'] ?? '') ?? 0.0;
      double long = double.tryParse(record['longitude'] ?? '') ?? 0.0;
      double accX = double.tryParse(record['acceleration_x'] ?? '') ?? 0.0;
      double accY = double.tryParse(record['acceleration_y'] ?? '') ?? 0.0;
      double accZ = double.tryParse(record['acceleration_z'] ?? '') ?? 0.0;
      //double temp = double.tryParse(record['temp'] ?? '') ?? 0.0;
      //double gaslevel = double.tryParse(record['gaslevel'] ?? '') ?? 0.0;
      //double humidity = double.tryParse(record['humidity'] ?? '') ?? 0.0;

      //data.add(UserLocation(lat, long, accX, accY, accZ));
      //print('temp: $temp, gas level: $gaslevel, humid: $humidity');
       print('Latitude: $lat, Longitude: $long, AccX: $accX, AccY: $accY, AccZ: $accZ');
    });
    //return data;
  }
}

 -----------------------------------------------------------------------------------*/



/*
class Getdata {
  String bucket = "LoRASensors";

  //List<String> measurement = ["AC1F09FFFE0037B5", "AC1F09FFFE0037B7"];
  //List<UserLocation> userlocation = [];
  //List<String> measure = [];
  UserLocation? mylocation;

  //final _locationStreamController = StreamController<UserLocation>();

  //Stream<UserLocation> get locationStream => _locationStreamController.stream;

  var client = InfluxDBClient(
    url: 'http://moby.cs.usm.my:8086',
    token: 'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
    org: 'medinalab',
    bucket: 'LoRASensors',
  );
}

 */

/*
  Future <void> getUserLocation() async {
    List<String> measurement = ["AC1F09FFFE0037B5", "AC1F09FFFE0037B7"];
    List<UserLocation> userlocation = [];
    print("this message is to check whether this function is run or no");
    //measure.clear();
    userlocation.clear();
    //String? eui = await Localstorage.geteui();
    //print(eui);
    //var queryService = client.getQueryService();
    //var recordStream = await queryService.query('''
    //from(bucket: "$bucket")
    //|> range(start: -1h)
    //|> filter(fn: (r) => r["_measurement"] == "$measurement")
    //|> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude" or r["_field"] == "acceleration_x" or r["_field"] == "acceleration_y" or r["_field"] == "acceleration_z")
    //''');

   */

    /*
    await recordStream.forEach((record) {
      // Process each record here and add it to the data variable
      double lat = double.tryParse(record['latitude'] ?? '') ?? 0.0;
      double long = double.tryParse(record['longitude'] ?? '') ?? 0.0;
      double accelerationX = double.tryParse(record['acceleration_x'] ?? '') ??
          0.0;
      double accelerationY = double.tryParse(record['acceleration_y'] ?? '') ??
          0.0;
      double accelerationZ = double.tryParse(record['acceleration_z'] ?? '') ??
          0.0;

      var location = UserLocation(
          lat, long, accelerationX, accelerationY, accelerationZ);
      data.add(location);
    });

// Now the data variable contains all the processed records
    print(data);
  }
     */
//}












