// login.dart
// Author: Samuel Rudqvist
// Date Created:

import 'package:flutter/material.dart';
import 'package:wheres_that_movie/screens/login/local_widgets/login_form.dart';

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
              // Insert padding on the top to move down the back button and form
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                // child: Image.asset("assets.logo.png"),
                //child: Text("Login Page"),
              ),

              // Align the back button on the left side.
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: const <Widget>[
              //     BackButton(),
              //   ],
              // ),

              // Add some space between the back button and login form
              SizedBox(
                height: 100.0,
              ),
              MyLoginForm(),
            ],
          ))
        ],
      ),
    );
  }
}
