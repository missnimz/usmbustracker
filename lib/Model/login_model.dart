class LoginResponse {
  String? expire;
  String? token;

  LoginResponse({this.expire, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    expire = json['expire'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expire'] = expire;
    data['token'] = token;
    return data;
  }
}


/*import 'package:flutter/material.dart';
import 'package:testing/api.dart';
import 'package:testing/sucess.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //Gettting the JwtToken object and making the instance of it

  Future<LoginResponse> _futureJwt;
  final TextEditingController _controller = TextEditingController();
  //Getting the password from the textField
  final TextEditingController _controller1 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      // ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        // padding: const EdgeInsets.all(8.0),
        //if Field have the null values then Get the value from the textField

        child: (_futureJwt == null)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 1 / 3,
                    //   child: Image.asset(
                    //     "assets/IMG_2382.png",
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // SizedBox(height: 45.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: TextField(
                        style: style,
                        decoration: InputDecoration(

                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: _controller,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: TextField(
                        controller: _controller1,
                        obscureText: true,
                        style: style,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: RaisedButton(                    
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),

                          ),
                          color: Colors.grey[800],
                          // padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            setState(() {
                              _futureJwt = createLoginState(
                                  _controller.text, _controller1.text);
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              )
            //If the Conditiion (_futureJwt == null) is false then
            : FutureBuilder<LoginResponse>(
                //refer the object to the future
                future: _futureJwt,
                //
                builder: (context, snapshot) {
                  //if the data is getting
                  if (snapshot.hasData) {
                    var token = snapshot.data.token;
                    print(token);
                    return Sucess();
                  }
                  //if the data results an error
                  else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}*/