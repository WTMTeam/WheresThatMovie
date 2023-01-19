// landing.dart
// Author: Samuel Rudqvist
// Date Created: 08/30/2022

//********************************************************************//
//* This is the landing page for the StreamingServicesLister project *//
//********************************************************************//

// TO DO:
// Add button for login
// Add button for signup

import 'package:flutter/material.dart';
import 'package:wheres_that_movie/screens/login/login.dart';
// import 'package:flutter/services.dart';
// import 'package:wheres_that_movie/widgets/my_container.dart';

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
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  "<Insert Logo Here>",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(190, 255, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    letterSpacing: 8,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   primary: const Color.fromARGB(255, 255, 0, 0)
                // ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        //color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyLogin(),
                    ),
                  );
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
