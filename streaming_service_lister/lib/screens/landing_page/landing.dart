// landing.dart
// Author: Samuel Rudqvist
// Date Created: 08/30/2022

//********************************************************************//
//* This is the landing page for the StreamingServicesLister project *//
//********************************************************************//

import 'package:flutter/material.dart';

class MyLanding extends StatelessWidget {
  const MyLanding({Key? key}) : super(key: key);

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
                  child: Text(
                    "SSL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(190, 255, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      letterSpacing: 8,
                      ),
                    ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}