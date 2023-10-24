// my_container.dart
// Author: Samuel Rudqvist
// Date Created: 08/31/2022

// Purpose:
//    Create a container that can be used throughout the app

// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;

  const MyContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
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
