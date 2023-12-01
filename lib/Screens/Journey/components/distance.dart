import 'package:flutter/material.dart';
import 'package:nelayannet/influx.dart';
import 'package:nelayannet/Model/monthly_distance.dart';
import 'package:nelayannet/Model/weeklydistance.dart';
import 'package:nelayannet/Services/getcurrentmonth.dart';
import 'package:nelayannet/Services/getcurrentweek.dart';
import 'package:geolocator/geolocator.dart';

class DistanceTracelled extends StatefulWidget {
  const DistanceTracelled({Key? key}) : super(key: key);

  @override
  _DistanceTracelledState createState() => _DistanceTracelledState();
}

class _DistanceTracelledState extends State<DistanceTracelled> {
  double totaldistance = 0;
  Getdata data = Getdata();
  final GetcurrentMonth _getcurrentMonth = GetcurrentMonth();
  late Future<MonthlyDistance> monthlydistance;
  final GetcurrentWeek _getcurrentWeek = GetcurrentWeek();
  late Future<WeeklyDistance> weeklydistance;

  @override
  void initState() {
    super.initState();
    monthlydistance = _getcurrentMonth.getcurrentmonth();
    weeklydistance = _getcurrentWeek.getcurrentweek();
    distance();
  }

  void distance() async {
    await data.getjourney();
    if (data.myjourney.isNotEmpty && data.myjourney.length > 1) {
      setState(() {
        for (int x = 0; x < data.myjourney.length - 1; x++) {
          totaldistance = double.parse((Geolocator.distanceBetween(
                      data.myjourney[x].lat,
                      data.myjourney[x].long,
                      data.myjourney[x + 1].lat,
                      data.myjourney[x + 1].long) /
                  1000)
              .toStringAsFixed(2));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 20, left: 20, right: 20),
        child: Container(
          height: 280,//size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.5),
            color: Colors.blue[50],
          ),
          child: Column(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: const Text("Daily Travelled Distance"),
                  subtitle: Text("$totaldistance km"),
                ),
              ),
              FutureBuilder<WeeklyDistance>(
                future: weeklydistance,
                builder: (context, info) {
                  if (info.hasData) {
                    
                    double distance = info.data!.distance as double;
                    double round = double.parse(distance.toStringAsFixed(2));
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: const Text("Weekly Travelled Distance"),
                        subtitle: Text("$round km"),
                      ),
                    );
                  } else if (info.hasError) {
                    return const Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Weekly Travelled Distance"),
                        subtitle: Text("No Data Found"),
                      ),
                    );
                  }
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder<MonthlyDistance>(
                future: monthlydistance,
                builder: (context, info) {
                  if (info.hasData) {
                    double distance = info.data!.distance as double;
                    double round = double.parse(distance.toStringAsFixed(2));
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: const Text("Monthly Travelled Distance"),
                        subtitle: Text("$round km"),
                      ),
                    );
                  } else if (info.hasError) {
                    return const Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Monthly Travelled Distance"),
                        subtitle: Text("No Data Found"),
                      ),
                    );
                  }
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
