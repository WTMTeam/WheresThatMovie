// my_container.dart
// Author: Samuel Rudqvist
// Date Created: 08/31/2022

// Purpose:
//    Create a container that can be used throughout the app

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyContainer extends StatelessWidget {
  final Widget child;

  static const Color _containerBackground = Color.fromARGB(255, 40, 40, 40);
  static const Color _boxShadowColor = Color.fromARGB(255, 25, 25, 25);

  const MyContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _containerBackground,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: _boxShadowColor,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              4.0,
              4.0,
            ),
          )
        ],
      ),
      child: child,
    );
  }
}