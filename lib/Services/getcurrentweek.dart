import 'package:nelayannet/Model/weeklydistance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:nelayannet/Services/flutter_secure_storage.dart';

class GetcurrentWeek {
  Future<WeeklyDistance> getcurrentweek() async {
    String? eui = await Localstorage.geteui();

    /*try {
      final response = await http.get(
      Uri.parse('http://moby.cs.usm.my:5000/currentweek/$eui'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return WeeklyDistance.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception("No Data Found");
    }*/

    final response = await http.get(
      Uri.parse('http://moby.cs.usm.my:5000/currentweek/$eui'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      //final responsejson = jsonDecode(response.body);
      return WeeklyDistance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("No Data Found");
      
    }
  }
}
