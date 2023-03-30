// flash_message.dart
// Author: Samuel Rudqvist
// Date Created: 02/25/2023
//
// Purpose:
//    Display an error message to the user on the detailed screen
//    when the movie or show is not available for Streaming, Buying, or Renting

// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//

import 'package:flutter/material.dart';

class MyCustomErrorMessage extends StatelessWidget {
  final String errorText;
  final bool isMovie;
  const MyCustomErrorMessage(
      {super.key, required this.errorText, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "Oh Snap!",
                //   style: TextStyle(fontSize: 18, color: Colors.white),
                // ),
                // const Spacer(),
                Text(
                  isMovie
                      ? "It looks like this movie is not available for ${errorText}ing in your region"
                      : "It looks like this show is not available for ${errorText}ing in your region",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              ],
            ))
          ]),
        ),
      ],
    );
  }
}
