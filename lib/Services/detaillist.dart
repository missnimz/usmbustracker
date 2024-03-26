import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:nelayannet/Model/fishermans_model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:nelayannet/Model/sensors_model.dart';
import 'package:nelayannet/Model/user_model.dart';
import 'package:nelayannet/Model/vessels_model.dart';
import 'package:nelayannet/Services/flutter_secure_storage.dart';

import '../Model/userposts_model.dart';

class Detail {
  static UserInfo? information;

  factory Detail() => Detail._internal();
  Detail._internal();

  static Future<void> getuserdetail() async {
    String token = await Localstorage.getToken() as String;
    print(token);
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/current_user'),
        Uri.parse('http://10.0.2.2:8000/api/v1/current_user'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    final responsejson = jsonDecode(response.body);

    information = UserInfo.fromJson(responsejson);
  }
}

class Listuser {
  static UserList? userList;

  factory Listuser() => Listuser._internal();
  Listuser._internal();

  static Future<void> getlistuser() async {
    String token = await Localstorage.getToken() as String;
    print(token);
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/users'),
        Uri.parse('http://10.0.2.2:8000/api/v1/users'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    final responsejson = jsonDecode(response.body);
    userList = UserList.fromJson(responsejson);
  }
}

class Listsensor {
  static SensorList? sensorlist;

  factory Listsensor() => Listsensor._internal();
  Listsensor._internal();

  static Future<void> getlistsensor() async {
    String token = await Localstorage.getToken() as String;
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/sensors'),
        Uri.parse('http://10.0.2.2:8000/api/v1/sensors'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    final responsejson = jsonDecode(response.body);
    sensorlist = SensorList.fromJson(responsejson);
  }
}

class Listvessel {
  static VesselList? vesselList;

  factory Listvessel() => Listvessel._internal();
  Listvessel._internal();

  static Future<void> getlistvessel() async {
    String token = await Localstorage.getToken() as String;
    print(token);
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/vessels'),
        Uri.parse('http://10.0.2.2:8000/api/v1/vessels'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    final responsejson = jsonDecode(response.body);
    vesselList = VesselList.fromJson(responsejson);
  }
}

class Listpost{
  static UserPostList? userpostlist;

  factory Listpost() => Listpost._internal();
  Listpost._internal();

  // GET ALL USERPOSTS (ALL USERS) FROM SERVER
  static Future<void> getlistpost() async {
    String token = await Localstorage.getToken() as String;
    print(token);
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/userposts'),
        Uri.parse('http://10.0.2.2:8000/api/v1/userposts'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    final responsejson = jsonDecode(response.body);
    userpostlist = UserPostList.fromJson(responsejson);
  }

// class Adminpost{
//   static AdminPostList? userpostlist;
//
//   factory Listpost() => Listpost._internal();
//   Listpost._internal();
//
//   // GET ALL USERPOSTS (ALL USERS) FROM SERVER
//   static Future<void> getlistpost() async {
//   String token = await Localstorage.getToken() as String;
//   print(token);
//   final response = await http.get(
//   // Uri.parse('http://moby.cs.usm.my:8000/api/v1/userposts'),
//   Uri.parse('http://10.0.2.2:8000/api/v1/adminposts'),
//   headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
//
//   final responsejson = jsonDecode(response.body);
//   adminpostlist = AdminPostList.fromJson(responsejson);
// }

  // GET USERPOSTS BY USER ID FROM SERVER
  static Future<void> getbyuserid() async {
    int userId = Detail.information!.user!.id as int;
    String token = await Localstorage.getToken() as String;
    print(token);
    final response = await http.get(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/userposts/user/id/$userId'));
    Uri.parse('http://10.0.2.2:8000/api/v1/userposts/user/id/$userId'));

    final responsejson = jsonDecode(response.body);
    userpostlist = UserPostList.fromJson(responsejson);
  }

  // POST A PHOTO POST INTO SERVER
  static Future<void> adduserpost(String? imageUrl, int? userId, String? caption) async {
    final response = await http.post(
        // Uri.parse('http://moby.cs.usm.my:8000/api/v1/userposts'),
        Uri.parse('http://10.0.2.2:8000/api/v1/userposts'),
        body: jsonEncode(
            {"image_url": imageUrl, "user_id": userId, "caption": caption})
    );

    print(jsonEncode(
        {"image_url": imageUrl, "user_id": userId, "caption": caption}));

    if (response.statusCode == 201) {
      print("UPDATED");
    } else {
      throw Exception(response.statusCode);
    }
  }

  // UPDATE USERPOST
  static Future<void> updateuserpost(String? caption, int? id) async {
    // final response = await http.put(Uri.parse("http://moby.cs.usm.my:8000/api/v1/userposts/$id"),
    final response = await http.put(Uri.parse("http://10.0.2.2:8000/api/v1/userposts/$id"),
        body: jsonEncode({"caption":caption})
    );

    if(response.statusCode == 200){
      print("UPDATED");
    }else{
      throw Exception(response.statusCode);
    }
  }

  // DELETE USERPOST
  static Future<void> deleteuserpost(int? id) async {
    // final response = await http.delete(Uri.parse("http://moby.cs.usm.my:8000/api/v1/userposts/$id"));
    final response = await http.delete(Uri.parse("http://10.0.2.2:8000/api/v1/userposts/$id"));

    if(response.statusCode == 200){
      print("UPDATED");
    }else{
      throw Exception(response.statusCode);
    }
  }
}
