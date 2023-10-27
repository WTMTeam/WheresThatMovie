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
    // List options = [];
    return AlertDialog(
      title: Text('Select an Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map((option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    onOptionSelected(option);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ),
    );
  }
}
