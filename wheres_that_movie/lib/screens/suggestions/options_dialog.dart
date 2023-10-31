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
    double screenHeight = MediaQuery.of(context).size.height;

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
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: SizedBox(
        width: screenWidth / 1.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       visualDensity: VisualDensity.compact,
            //       splashRadius: 15,
            //       // splashColor: Colors.green,
            //       icon: Icon(
            //         CupertinoIcons.xmark_circle,
            //         color: Theme.of(context).primaryColor, // Specify the color
            //       ),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      alertTitle,
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.center,

                      // textAlign: TextAlign.left,
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    // padding: EdgeInsets.only(right: .0),
                    // alignment: Alignment.topRight,
                    // padding: const EdgeInsets.only(bottom: 10.0),
                    height: screenHeight / 20,

                    child: IconButton(
                      alignment: const Alignment(0.5, -0.5),
                      visualDensity: VisualDensity.compact,
                      splashRadius: 15,
                      padding: EdgeInsets.all(0.0),
                      // splashColor: Colors.green,
                      icon: Icon(
                        CupertinoIcons.xmark_circle,
                        color:
                            Theme.of(context).primaryColor, // Specify the color
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
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
      ),
    );
  }
}
