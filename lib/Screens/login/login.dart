import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:nelayannet/Screens/login/components/body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Press again to exit"),
        ),
        child: Body(),
      ),
    );
  }
}
