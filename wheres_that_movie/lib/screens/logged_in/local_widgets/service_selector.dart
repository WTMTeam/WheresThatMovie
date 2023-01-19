// service_selector.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the container for selecting the streaming          *//
//*               services to include in the search.                 *//
//********************************************************************//

import 'package:flutter/material.dart';
import 'package:wheres_that_movie/widgets/my_container.dart';

class MyServiceSelector extends StatefulWidget {
  const MyServiceSelector({Key? key}) : super(key: key);

  @override
  State<MyServiceSelector> createState() => _MyServiceSelectorState();
}

class _MyServiceSelectorState extends State<MyServiceSelector> {
  bool netflixValue = false;
  bool huluValue = false;
  bool amazonValue = false;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: Text(
              "Select Streaming Services",
              style: Theme.of(context).textTheme.headline2,

              // style: TextStyle(
              //   //color: Theme.of(context).primaryColor,
              //   color: Theme.of(context).colorScheme.primary,
              //   fontSize: 20.0,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Netflix",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              //
              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),
                value: netflixValue,
                onChanged: (value) {
                  setState(() {
                    netflixValue = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Amazon",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              //
              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),
                value: amazonValue,
                onChanged: (value) {
                  setState(() {
                    amazonValue = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              ),
              Expanded(
                child: Text(
                  "Hulu",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              //

              Checkbox(
                checkColor: const Color.fromARGB(255, 0, 255, 0),
                activeColor: const Color.fromARGB(0, 0, 0, 0),
                value: huluValue,
                onChanged: (value) {
                  setState(() {
                    huluValue = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
