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
    String alertTitle = "";
    if (options[0] == "Netflix") {
      alertTitle = "Choose a Streaming Service";
    } else if (options[0] == "Comedy") {
      alertTitle = "Choose a Genre";
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // title: Text(alertTitle),
      contentPadding: const EdgeInsets.all(0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                // padding: const EdgeInsets.only(bottom: 10.0),
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 15,
                  // splashColor: Colors.green,
                  icon: Icon(
                    CupertinoIcons.xmark_circle,
                    color: Theme.of(context).primaryColor, // Specify the color
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Text(
                  alertTitle,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
    );
  }
}
