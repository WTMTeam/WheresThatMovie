// suggestions.dart
// Author: Samuel Rudqvist
// Date Created: 07/24/2023
//
// Purpose:
//   This is the screen where the user can select their
//   streaming services and one or more genres of movies
//   and get a suggestion of what to watch.
//
// Todo:
// * See #17
// Modification Log:
//    (xx/xx/xxxx)(SR):

import 'package:flutter/material.dart';
import 'package:wheres_that_movie/screens/suggestions/options_dialog.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  final List<String> providers = ['Netflix', 'Apple TV', 'Disney'];
  final List<String> otherOptions = ['Option 1.1', 'Option 2.1', 'Option 3.1'];
  final List<String> otherOptions2 = ['Option 1.2', 'Option 2.2', 'Option 3.2'];
  String currentProvider = 'Option 1';
  String currentOption2 = 'Option 1.1';
  String currentOption3 = 'Option 1.2';

  void setProviders(dynamic option) {
    setState(() {
      currentProvider = option;
    });
  }

  void setCurrentOption2(dynamic option) {
    setState(() {
      currentOption2 = option;
    });
  }

  void setCurrentOption3(dynamic option) {
    setState(() {
      currentOption3 = option;
    });
  }

  void _showOptionsDialog(BuildContext context, List<String> options,
      Function(dynamic) setCurrentOption) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OptionsDialog(
          options: options,
          onOptionSelected: (option) {
            setCurrentOption(option);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _showOptionsDialog(context, providers, setProviders);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(currentProvider),
          ),
          ElevatedButton(
            onPressed: () {
              _showOptionsDialog(context, otherOptions2, setCurrentOption2);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(currentOption2),
          ),
        ],
      ),
    )));
  }
}
