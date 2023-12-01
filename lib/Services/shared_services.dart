import 'package:flutter/cupertino.dart';
import 'package:nelayannet/Services/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != "" ? true : false;
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token != "" ? token : "");
  }

  static Future<void> savehistory(List<String> abc) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("history", abc);
  }

  static Future<List<String>?> gethistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("history");
  }

  static Future<void> logout(BuildContext context) async {
    await setToken("");
    await savehistory([]);
    await Localstorage.saveEUI("");
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
