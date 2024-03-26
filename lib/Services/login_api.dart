import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  Future authenticate(String ic, String password) async {
    // Uri link = Uri.parse("http://moby.cs.usm.my:8000/api/v1/login");
    Uri link = Uri.parse("http://10.0.2.2:8000/api/v1/login");

    var response = await http.post(link,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"ic": ic, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 400) {
      //final responsebody = LoginResponse.fromJson(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception("Failed to login ${response.body}");
    }
  }
}
