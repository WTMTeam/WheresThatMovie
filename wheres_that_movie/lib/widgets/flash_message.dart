//
//
//
// displays a message
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
          height: 90,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(children: [
            // const SizedBox(
            //   width: 48,
            // ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Oh Snap!",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  isMovie
                      ? "It looks like this movie is not available for ${errorText}ing"
                      : "It looks like this show is not available for ${errorText}ing",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ]),
        ),
        // Positioned(
        //     bottom: 0,
        //     child: ClipRRect(
        //       borderRadius:
        //           const BorderRadius.only(bottomLeft: Radius.circular(20)),
        //       child: Stack(children: [
        //         Icon(Icons.exit_to_app)
        //         // SvgPicture.asset("asset_path",
        //         //     height: 48, width: 40, color: const Color(0xFF801336))
        //       ]),
        //     )),
        // Positioned(
        //     top: -10,
        //     right: -10,
        //     child: ClipRRect(
        //       borderRadius:
        //           const BorderRadius.only(bottomLeft: Radius.circular(20)),
        //       child: Stack(children: [
        //         IconButton(
        //             onPressed: () {
        //               print("Closed");
        //             },
        //             color: Theme.of(context).colorScheme.secondary,
        //             iconSize: 40,
        //             icon: Icon(Icons.close_rounded)),
        //         // SvgPicture.asset("asset_path",
        //         //     height: 40, color: const Color(0xFF801336)),
        //       ]),
        //     )),
      ],
    );
  }
}
