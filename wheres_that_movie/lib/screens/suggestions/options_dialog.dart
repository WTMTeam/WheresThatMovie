import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsDialog extends StatelessWidget {
  final List<String> options;
  final Function(String) onOptionSelected;

  const OptionsDialog({
    super.key,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    String alertTitle = "";
    if (options[0] == "Netflix") {
      alertTitle = "Streaming Service";
    } else if (options[0] == "Comedy") {
      alertTitle = "Genre";
    } else if (options[0] == "Movie") {
      alertTitle = "Movie or TV-Show";
    } else if (options[0] == "<30min") {
      alertTitle = "Choose Length";
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text(alertTitle),
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SizedBox(
        width: screenWidth / 1.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              heightFactor: 0.35,
              // alignment: Alignment.topRight,
              alignment: const Alignment(1.1, -0.1),
              child: IconButton(
                splashRadius: 10,
                padding: const EdgeInsets.all(0.0),
                icon: Icon(
                  CupertinoIcons.xmark_circle,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    alertTitle,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Divider(
                thickness: 5.0,
                // color: Colors.red,
              ),
            ),

            // Convert the iterable to a list of widgets
            // Padding(padding: EdgeInsets.only(left: 8.0, right: 8.0, b))
            ...options.map((option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    onOptionSelected(option);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
