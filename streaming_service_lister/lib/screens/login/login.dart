// login.dart
// Author: Samuel Rudqvist
// Date Created:


import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streaming_service_lister/screens/login/local_widgets/login_form.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(40.0),
                  // child: Image.asset("assets.logo.png"),
                  child: Text("Login Page"),
                  ),
                SizedBox(
                  height: 20.0,
                ),
                MyLoginForm(),
              ],
            )
          )
        ],
      ),
    );
  }
}