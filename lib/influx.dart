import 'package:influxdb_client/api.dart';
import 'package:nelayannet/Services/flutter_secure_storage.dart';

class UserLocation {
  double lat;
  double long;
  String measurement;

  UserLocation(this.lat, this.long, this.measurement);
}

class Journey {
  double lat;
  double long;
  String measurement;
  DateTime time;

  Journey(this.lat, this.long, this.measurement, this.time);
}

class Getdata {
  String bucket = "nelayannet";
  //String measurement = "testing";
  List<UserLocation> userlocation = [];
  List<String> measure = [];
  UserLocation? mylocation;
  List<Journey> myjourney = [];
  double distancetravelled = 0;
  var client = InfluxDBClient(
    url: 'http://moby.cs.usm.my:8086',
    token:
        'YpyO36S58otyYxbv9aFlVkKuG7dMz-juccTGaEm-bZsGWiXqpN50YdSdF8MBOUk3IIQLFamiBwXQSoXn1Wfgvw==',
    org: 'medinalab',
    bucket: 'nelayannet',
  );

  getUserLocation() async {
    print("this mesasge is to check whether this function is run or no");
    measure.clear();
    userlocation.clear();
    String? eui = await Localstorage.geteui();
    print(eui);
    var queryService = client.getQueryService();
    var recordStream = await queryService.query('''
    import "experimental/geo"
    import "date"
  from(bucket: "$bucket")
  |> range(start: -2h)
  |> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude")
  |> filter(fn: (r) => date.yearDay(t: r["_time"]) == date.yearDay(t: now()))
  |> geo.shapeData(
    latField: "latitude",
    lonField: "longitude",
    level: 1
  )
  |> tail(n: 1)
  ''');

  await recordStream.forEach((record) {
      print(record);
      double lat, long;
      String measurement;
      lat = record['lat'];
      long = record['lon'];
      measurement = record['_measurement'];
      userlocation.add(UserLocation(lat, long, measurement));
      measure.add(measurement);

      if (record["_measurement"] == eui) {
        mylocation = UserLocation(lat, long, measurement);
      }
    });
  }

  getcurrentlocation() async {
    String? eui = await Localstorage.geteui() as String;
    var queryService = client.getQueryService();
    var recordStream = await queryService.query('''
    import "experimental/geo"
    import "date"
  from(bucket: "$bucket")
  |> range(start: -2h)
  |> filter(fn: (r) => r["_measurement"] == "$eui")
  |> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude")
  |> filter(fn: (r) => date.yearDay(t: r["_time"]) == date.yearDay(t: now()))
  |> geo.shapeData(
    latField: "latitude",
    lonField: "longitude",
    level: 1
  )
  |> tail(n: 1)
  ''');
  await recordStream.forEach((record) {
      double lat, long;
      String measurement;
      lat = record['lat'];
      long = record['lon'];
      measurement = record['_measurement'];
      mylocation = UserLocation(lat, long, measurement);
    });

  }

  getjourney() async {
    var queryService = client.getQueryService();
    String? eui = await Localstorage.geteui() as String;
    var recordStream = await queryService.query('''
    import "experimental/geo"
    import "date"
  from(bucket: "$bucket")
  |> range(start: -10d)
  |> filter(fn: (r) => r["_measurement"] == "$eui")
  |> filter(fn: (r) => r["_field"] == "latitude" or r["_field"] == "longitude")
  |> filter(fn: (r) => date.yearDay(t: r["_time"]) == date.yearDay(t: now()))
  |> geo.shapeData(
    latField: "latitude",
    lonField: "longitude",
    level: 1
  )
  ''');

    await recordStream.forEach((record) {
      double lat, long;
      String measurement;
      lat = record['lat'];
      long = record['lon'];
      DateTime currenttime;
      measurement = record['_measurement'];
      currenttime = DateTime.parse(record['_time']).toLocal();
      myjourney.add(Journey(lat, long, measurement, currenttime));
    });
  }
}
