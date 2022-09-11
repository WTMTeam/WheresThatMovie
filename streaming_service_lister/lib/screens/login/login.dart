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
              children:  <Widget>[

                // Insert padding on the top to move down the back button and form
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  // child: Image.asset("assets.logo.png"),
                  //child: Text("Login Page"),
                ),

                // Align the back button on the left side.
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    BackButton(),
                  ],
                ),

                // Add some space between the back button and login form
                const SizedBox(
                  height: 20.0,
                ),
                const MyLoginForm(),
                
              ],
            )
          )
        ],
      ),
    );
  }
}