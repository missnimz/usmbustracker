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
  final _adminFormKey = GlobalKey<FormState>();
  final TextEditingController icController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController adminUserController = TextEditingController();
  final TextEditingController adminPassController = TextEditingController();

  //final icController = TextEditingController();
  //final passController = TextEditingController();
  bool isLoading = false;
  final Login _login = Login();

  @override
  void dispose() {
    icController.dispose();
    passController.dispose();
    adminUserController.dispose();
    adminPassController.dispose();
    super.dispose();
  }

  String? adminValidation(String? icadmin) {
    if (icadmin!.isEmpty) {
      return "Identification card no. can't be empty.";
      // } else if (ic.length < 0) {
      //   return "Identification card no. length must be 12";
      // }
    }
    return null;
  } //this function is used to validate username

  String? passwordAdminValidation(String? passwordAdmin) {
    if (passwordAdmin!.isEmpty) {
      return "Password can't be empty.";
      // } else if (password.length < 6) {
      //   return "Password length must be more than 5";
      // }
    }
    return null;
  } //this funtion is used to validate password



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
  }// this function is used to check whether the login is valid or not

  bool _handleAdminLogin() {
    final form = _adminFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }





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

                const SizedBox(
                  height: 330,//20//30,
                ),

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
                  height: 40, //100,
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
                                // print("Evalue);
                            if (value != null) {
                              // print("value not null:: " + value);
                              setState(() {
                                isLoading = false;
                              });
                            }

                            print("DONE THIS PART 2");
                            if (value['token'] != null) {

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
                              //await Listsensor.getlistsensor();
                              //await Listuser.getlistuser();
                              // await Listvessel.getlistvessel();
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
                ),
                SizedBox( height: 10,),
            // Login as Administrator button
            TextButton(
                onPressed: () {
                  // Show modal dialog for administrator login
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Login as Bus Operator',
                          style: TextStyle(
                            fontSize: 18, // Adjust the font size as needed
                          ),
                        ),
                        backgroundColor: Colors.purple.shade50, // Set background color to purple shade 50
                        content: Form(
                          key: _adminFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: adminUserController,
                                decoration:
                                InputDecoration(labelText: 'IC'),
                                validator: adminValidation,
                              ),
                              TextFormField(
                                controller: adminPassController,
                                obscureText: true,
                                decoration:
                                InputDecoration(labelText: 'Password'),
                                validator: passwordAdminValidation,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              adminUserController.clear();
                              adminPassController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_handleAdminLogin()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  final value = await _login.authenticate(
                                      adminUserController.text, adminPassController.text);
                                  if (value != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (value['code'] == 200) {
                                      final loginResponse = LoginResponse.fromJson(value);

                                      SharedService.setToken(
                                          loginResponse.token as String);
                                      Localstorage.savetoken(
                                          loginResponse.token as String);
                                      // await Listsensor.getlistsensor();
                                      //await Listuser.getlistuser();
                                      // await Listvessel.getlistvessel();
                                      await Detail.getuserdetail();
                                      UserInfo? userDetail = Detail.information;

                                      if (userDetail != null && userDetail.user?.role == 'Admin') {
                                        print('User role: ${userDetail.user?.role}');

                                        const snackbar = SnackBar(
                                          content: Text("Login Successful"),
                                          duration: Duration(seconds: 1),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);


                                        // if (userDetail.sensor != null &amp;&amp; userDetail.sensor!.isNotEmpty) {
                                        //   await Localstorage.saveEUI(userDetail.sensor![0].eui as String);
                                        // }

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushNamed("/homeAdmin");
                                      } else {
                                        adminUserController.clear();
                                        adminPassController.clear();
                                        Navigator.of(context).pop();
                                        final snackbar = SnackBar(
                                          content: Text("You are not authorized to login as an administrator."),
                                          backgroundColor: Colors.red,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                      }
                                    } else {
                                      adminUserController.clear();
                                      adminPassController.clear();
                                      Navigator.of(context).pop();
                                      final errorResponse = Error.fromJson(value);
                                      final snackbar = SnackBar(
                                        content: Text(errorResponse.errors as String),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    }
                                  }
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  final snackbar = SnackBar(
                                    content: Text("Login Failed: $e"),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);

                                  // Clear the text fields
                                  adminUserController.clear();
                                  adminPassController.clear();
                                }
                              }
                            },
                            child: Text('Login'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Login as Bus Operator',
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontWeight: FontWeight.bold, // Make the text bold
                    decoration: TextDecoration.underline, // Underline the text
                    decorationColor: Colors.white, // Set underline color to white
                    )
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
