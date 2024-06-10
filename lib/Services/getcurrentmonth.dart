//import 'package:nelayannet/Model/monthly_distance.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'dart:async';

//import 'package:nelayannet/Services/detailslist.dart';
//import 'package:nelayannet/Services/flutter_secure_storage.dart';
/*
//class GetcurrentMonth {
  Future<MonthlyDistance> getcurrentmonth() async {
    String? eui = await Localstorage.geteui();

    final response = await http.get(
      Uri.parse('http://moby.cs.usm.my:5000/currentmonth/$eui'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return MonthlyDistance.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("No Data Found");
      
    }

    /*if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 404) {
      //final responsebody = LoginResponse.fromJson(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception("Failed to login ${response.body}");
    }*/
  }
}

 */
