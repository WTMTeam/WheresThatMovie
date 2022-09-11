// logged_in.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//********************************************************************//

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streaming_service_lister/screens/logged_in/local_widgets/service_selector.dart';

class MyLoggedIn extends StatelessWidget {
  const MyLoggedIn({Key? key}) : super(key: key);

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
                  padding: EdgeInsets.all(10.0),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    // TODO: Put the menu button here
                  ],
                ),

                const SizedBox(
                  height: 50.0,
                ),

                Text(
                  "Search for a movie or tv-show",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined)
                  ),
                ),

                const SizedBox(
                  height: 25.0,
                ),
                const MyServiceSelector(),
                
                const SizedBox(
                  height: 25.0,
                ),

                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),                
                  ),                  
                  onPressed: (){},                   
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

