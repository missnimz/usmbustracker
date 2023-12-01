import 'package:flutter/material.dart';
import 'package:nelayannet/Model/user_monthly_distance.dart';
import 'package:nelayannet/Services/user_distance.dart';

class Distance {
  int month;
  double distance;
  double subsidy;
  Distance(this.month, this.distance, this.subsidy);
}

class ShowTable extends StatefulWidget {
  const ShowTable({Key? key}) : super(key: key);

  @override
  _ShowTableState createState() => _ShowTableState();
}

class _ShowTableState extends State<ShowTable> {
  List<Distance> alldistance = [];
  late Future<UserEveryMonthDistance> everydistance;
  final GetEveryMonthDistance _getEveryMonthDistance = GetEveryMonthDistance();

  @override
  void initState() {
    super.initState();
    everydistance = _getEveryMonthDistance.geteverymonthdistance();
    everydistance.then((value) => value.result);
  }

  Widget viewTable(alldistance) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
        DataTable(
          columns: const [
            DataColumn(
              label: Text(
                "Month",
                style: TextStyle(decorationThickness: 2.00),
                textAlign: TextAlign.center,
              ),
            ),
            DataColumn(
              label: Text(
                "Distance Travelled",
                style: TextStyle(decorationThickness: 2.00),
                textAlign: TextAlign.center,
              ),
            ),
            DataColumn(
              label: Text(
                "Petrol Subsidy RM3.50/km",
                textAlign: TextAlign.center,
                style: TextStyle(decorationThickness: 2.00),
              )
            )
          ],
          rows: getRows(alldistance),
        ),
    ],
    )
    );
  }

  List<DataRow> getRows(List<Distance> distance) =>
      distance.map((Distance distance) {
        final cells = [distance.month, distance.distance, distance.subsidy];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data', textAlign: TextAlign.right,))).toList();

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
        padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
        child: Container(
          height: size.height * 0.7,
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
                  double subsidyAmount;

                  getmonth = int.parse(key);
                  getdistance = value;
                  subsidyAmount = getdistance * 3.5;
                  subsidyAmount = double.parse(subsidyAmount.toStringAsFixed(2));

                  if (getdistance!=0){
                    alldistance.add(Distance(getmonth, getdistance, subsidyAmount));
                  }
                });
                return viewTable(alldistance);
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
