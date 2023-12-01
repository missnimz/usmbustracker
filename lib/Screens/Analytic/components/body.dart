import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:nelayannet/Model/user_monthly_distance.dart';
import 'package:nelayannet/Services/user_distance.dart';

class Distance {
  int month;
  double distance;
  Distance(this.month, this.distance);
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Distance> alldistance = [];
  late Future<UserEveryMonthDistance> everydistance;
  final GetEveryMonthDistance _getEveryMonthDistance = GetEveryMonthDistance();

  @override
  void initState() {
    super.initState();
    everydistance = _getEveryMonthDistance.geteverymonthdistance();
    everydistance.then((value) => value.result);
  }

  Widget showGraph(alldistance) {
    return Column(
        children: [
        //Initialize the chart widget
        SfCartesianChart(
      title: ChartTitle(
        text: "Monthly Distance Travelled Graph",
      ),
      primaryXAxis: CategoryAxis(),

      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<Distance, String>>[
        LineSeries<Distance, String>(
            dataSource: alldistance,
            xValueMapper: (Distance distances, _) => distances.month.toString(),
            yValueMapper: (Distance distances, _) => distances.distance,
            name: 'Monthly Distance',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ],
    ),
    ],
    );
  }

  Widget noGraph(alldistance) {
    return Column(
        children: [
        //Initialize the chart widget
        SfCartesianChart(
          annotations: <CartesianChartAnnotation>[
                  CartesianChartAnnotation(
                    coordinateUnit: CoordinateUnit.percentage,
                    widget: 
                      Container(
                        child: const Text('No Data')
                      ),
                      x: '50%',
                      y: '20%',
                      )],
      title: ChartTitle(
        text: "Monthly Distance Travelled Graph",
      ),
      primaryXAxis: CategoryAxis(),

      // Enable tooltip
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<Distance, String>>[
        LineSeries<Distance, String>(
            dataSource: alldistance,
            xValueMapper: (Distance distances, _) => distances.month.toString(),
            yValueMapper: (Distance distances, _) => distances.distance,
            name: 'Monthly Distance',
            // Enable data label
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ],
    ),
    ],
    );
  }

  List<DataRow> getRows(List<Distance> distance) =>
      distance.map((Distance distance) {
        final cells = [distance.month, distance.distance];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  @override
  Widget build(BuildContext context) {
    var monthDistance = {
      '1' : 0.0,
      '2' : 0.0,
      '3' : 0.0,
      '4' : 0.0,
      '5' : 0.0,
      '6' : 0.0,
      '7' : 0.0,
      '8' : 0.0,
      '9' : 0.0,
      '10' : 0.0,
      '11' : 0.0,
      '12' : 0.0,
    };
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 5, left: 20, right: 20),
        child: Container(
          height: size.height * 0.4,
          width: size.width,
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: FutureBuilder<UserEveryMonthDistance>(
            future: everydistance,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var results = snapshot.data!.result;
                for (final x in results!) {
                  int month = x.month as int;
                  String convertmonth = x.month.toString();
                  double distance = x.distance as double;
                  double distances = double.parse(distance.toStringAsFixed(2));
                  //month_distance.update(convertmonth, (value) => distances);
                  if (x.year == DateTime.now().year){
                    monthDistance.update(convertmonth, (value) => distances);
                    //alldistance.add(Distance(month, distances));
                  }
                }
                monthDistance.forEach((key, value){
                  int getmonth;
                  double getdistance;

                  getmonth = int.parse(key);
                  getdistance = value;
                  alldistance.add(Distance(getmonth, getdistance));


                });
                return showGraph(alldistance);
              }
              else if (snapshot.hasError) {
                monthDistance.forEach((key, value){
                  int getmonth;
                  double getdistance;

                  getmonth = int.parse(key);
                  getdistance = value;
                  alldistance.add(Distance(getmonth, getdistance));


                });
                return noGraph(alldistance);
              }
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
