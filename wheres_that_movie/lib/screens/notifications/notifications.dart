// my_list.dart
// Author: Samuel Rudqvist
// Date Created: 10/24/2022
//

//********************************************************************//
//*       This is the screen the user they clicked the               *//
//        notifications card in the drawer in the menu on            *//
//                          logged in page                           *//
//********************************************************************//

import 'package:flutter/material.dart';

class MyNotifications extends StatelessWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      const SizedBox(
        height: 200.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 8.0,
        ),
        child: Text(
          "Notifications",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]));
  }
}
