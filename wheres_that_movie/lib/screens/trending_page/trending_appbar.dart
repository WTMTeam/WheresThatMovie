import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onSwipeDown;
  final VoidCallback? makeCardList;
  final bool direction;
  final Function(bool) onIsHorizontalChanged;

  MyCustomAppBar({
    required this.title,
    this.onBackButtonPressed,
    this.onSwipeDown,
    this.makeCardList,
    required this.direction,
    required this.onIsHorizontalChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = direction;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          // A downward swipe on the custom AppBar has been detected
          if (onSwipeDown != null) {
            onSwipeDown!();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        // margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(100, 0, 0, 0),
              blurRadius: 2.0,
              offset: Offset(0,
                  4), // Set the offset to (0, 4) to create a shadow only at the bottom
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (onBackButtonPressed != null)
              IconButton(
                onPressed: onBackButtonPressed,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            IconButton(
              onPressed: () {
                isHorizontal ? isHorizontal = false : isHorizontal = true;
                onIsHorizontalChanged(isHorizontal);
                // makeCardList!();
              },
              icon: isHorizontal
                  ? Icon(
                      Icons.swap_vert,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(
                      Icons.swap_horiz,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
