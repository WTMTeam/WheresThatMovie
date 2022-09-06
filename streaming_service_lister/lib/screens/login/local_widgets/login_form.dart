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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Log In", 
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.alternate_email), 
            hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.lock_outline), 
            hintText: "Password",
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
                  fontSize: 20.0
                  ),
                ),
              ),
            onPressed: (){}, // Do nothing for now            
          ),
          TextButton(
            child: const Text(
              "Don't have an account? Sign up here.", 
              style: TextStyle(
                color: Color.fromARGB(255, 255, 0, 0)
              ),
            ),
            onPressed: (){}, // Do nothing for now
          )
        ]
      ),
    );
  }
}