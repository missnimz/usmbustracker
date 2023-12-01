import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nelayannet/Model/user_monthly_distance.dart';
import 'package:nelayannet/Services/flutter_secure_storage.dart';
//import 'package:tracker_fisherman/Services/detailslist.dart';

class GetEveryMonthDistance {
  Future<UserEveryMonthDistance> geteverymonthdistance() async {
    //String user = Detail.information!.sensor![0].eui as String;
    String? eui = await Localstorage.geteui();
    final response = await http.get(
      Uri.parse('http://moby.cs.usm.my:5000/distance/$eui'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return UserEveryMonthDistance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("No Data Found");
    }
  }
}
