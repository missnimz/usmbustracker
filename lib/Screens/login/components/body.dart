import 'package:nelayannet/Services/detaillist.dart';
import 'package:flutter/material.dart';
import 'package:nelayannet/Model/login_model.dart';
import 'package:nelayannet/Screens/login/components/backgroundUI.dart';
import 'package:nelayannet/Services/flutter_secure_storage.dart';
import 'package:nelayannet/Services/login_api.dart';
import 'package:nelayannet/Services/shared_services.dart';
import 'package:nelayannet/progress_Indicator.dart';
import 'package:nelayannet/Model/user_model.dart';
import 'package:nelayannet/Model/error.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isHidepass = true;
  final _formkey = GlobalKey<FormState>();
  final icController = TextEditingController();
  final passController = TextEditingController();
  bool isLoading = false;
  final Login _login = Login();

  @override
  void dispose() {
    icController.dispose();
    passController.dispose();
    super.dispose();
  }

  String? userValidation(String? ic) {
    if (ic!.isEmpty) {
      return "Identification card no. can't be empty.";
    } else if (ic.length < 0) {
      return "Identification card no. length must be 12";
    }
    return null;
  } //this function is used to validate username

  String? passwordValidation(String? password) {
    if (password!.isEmpty) {
      return "Password can't be empty.";
    } else if (password.length < 6) {
      return "Password length must be more than 5";
    }
    return null;
  } //this funtion is used to validate password

  bool _handleLogin() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  } // this function is used to check whether the login is valid or not

  @override
  Widget build(BuildContext context) {
    return Progressindicator(child: uibody(context), inAsyncCall: isLoading);
  }

  Widget uibody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Background(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /*Container(
                alignment: Alignment.center,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Text(
                  "NELAYANNET",

                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),*/
                const SizedBox(
                  height: 330,//20//30,
                ),
                /*Container(
                alignment: Alignment.center,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 20, //30,
              ),*/
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: icController,
                    validator: userValidation,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: "IC Number",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,//60,
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: passController,
                    validator: passwordValidation,
                    obscureText: isHidepass,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHidepass = !isHidepass;
                          });
                        },
                        icon: Icon(
                            isHidepass ? Icons.visibility_off : Icons.visibility),
                      ),
                      hintText: "Password",
                    ),
                    cursorHeight: 17,
                  ),
                ),
                const SizedBox(
                  height: 50, //100,
                ),
                Container(
                  width: 120, //100,
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[50],
                      ),
                      child: const Text("Login"),
                      onPressed: () async {
                        LoginResponse loginResponse = LoginResponse();
                        Error errorResponse = Error();

                        if (_handleLogin()) {
                          setState(() {
                            isLoading = true;
                          });
                          print("DONE THIS PART");
                          _login
                              .authenticate(
                              icController.text, passController.text)
                              .then((value) async {
                            if (value != null) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            print("DONE THIS PART 2");
                            if (value['code'] == 200) {
                              loginResponse = LoginResponse.fromJson(value);

                              const snackbar = SnackBar(
                                content: Text("Login Successful"),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              SharedService.setToken(
                                  loginResponse.token as String);
                              Localstorage.savetoken(
                                  loginResponse.token as String);
                              await Listsensor.getlistsensor();
                              await Listuser.getlistuser();
                              await Listvessel.getlistvessel();
                              await Detail.getuserdetail();
                              UserInfo? userDetail = Detail.information;
                              //print("DONE THIS PART");
                              if (userDetail != null){
                                var userSensor = userDetail.sensor;
                                if(userSensor != null){
                                  Localstorage.saveEUI(userSensor[0].eui as String);
                                }
                              }
                              Navigator.of(context).pushNamed("/home");
                              //Navigator.of(context).pushNamedAndRemoveUntil(
                              //    '/home', (Route<dynamic> route) => false);
                              //'/homepage', (Route<dynamic> route) => false);
                            } else {
                              errorResponse = Error.fromJson(value);

                              final snackbar = SnackBar(
                                content: Text(errorResponse.errors as String),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
