// my_container.dart
// Author: Samuel Rudqvist
// Date Created: 08/31/2022

// Purpose:
//    Create a container that can be used throughout the app

import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;

  static const Color _containerBackground = Color.fromARGB(255, 40, 40, 40);
  static const Color _boxShadowColor = Color.fromARGB(255, 25, 25, 25);

  const MyContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 600.0,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        // color: _containerBackground,
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            // color: _boxShadowColor,
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: const Offset(
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