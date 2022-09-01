// login_form.dart
// Author: Samuel Rudqvist
// Date Created: 08/31/2022

// Purpose:
//    A login form to be used on the login page

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streaming_service_lister/widgets/my_container.dart';
import 'package:flutter/material.dart';

class MyLoginForm extends StatelessWidget {
  const MyLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: const <Widget>[
          Text("Hello")
        ]
      ),
    );
  }
}