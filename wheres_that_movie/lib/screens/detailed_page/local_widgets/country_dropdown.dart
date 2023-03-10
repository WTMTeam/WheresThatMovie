// logged_in.dart
// Author: Samuel Rudqvist
// Date Created: 03/08/2023
//
// Purpose:
//    This is the a searchable dropdown that gets the countries
//    from tmdb, adds them to the dropdown and updates the database
//    with the choice the user made.
//
// Modification Log:

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:wheres_that_movie/database/database_helper.dart';

class CountryDropdown extends StatefulWidget {
  final Function(String) onChanged;
  const CountryDropdown({super.key, required this.onChanged});

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  final String apiKey = 'dbffa0d16fb8dc2873531156a5c5f41a';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY';

  List<String> countryCodes = [];
  List<String> countryNames = [];
  String selectedCountry = "";
  String selectedCode = "";

  // Get the index of the code/name from the list
  getIndex(String codeOrName) {
    int index = 0;
    if (codeOrName.length > 2) {
      index = countryNames.indexOf(codeOrName);
    } else {
      index = countryCodes.indexOf(codeOrName);
    }
    return index;
  }

  checkDB() async {
    final result = await SQLHelper.getCountry();

    String code = result[0]['code'].toString();
    setState(() {
      selectedCode = code;
      selectedCountry = countryNames[getIndex(code)];
      widget.onChanged(code);
    });
  }

  // Insert a new journal to the database
  Future<void> _setCountry(String countryCode) async {
    await SQLHelper.setCountry(countryCode);
  }

  // reads the json file that contains the countries
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final data = json.decode(response);

    for (final country in data) {
      // print("Country: $country");
      // print("Country: ${country['iso_3166_1']}");
      // print("Country: ${country['english_name']}");
      countryCodes.add(country['iso_3166_1'].toString());
      countryNames.add(country['english_name'].toString());
    }

    return data;
  }

  @override
  void initState() {
    super.initState();
    readJson();
    checkDB();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          // onDismissed: () {
          //   print("Dismissed");
          //   // Future.delayed(const Duration(milliseconds: 4500));
          //   Future.delayed(const Duration(milliseconds: 4500), () {
          //     Navigator.of(context).pop();
          //   });
          //   print("here");
          // },
          // itemBuilder: (context, item, isSelected) {
          //   // Delay the dismissal of the menu by 4.5 seconds
          //   Future.delayed(const Duration(milliseconds: 4500), () {
          //     Navigator.of(context).pop();
          //   });
          //   isSelected = isSelected;
          // },
          menuProps: MenuProps(
            borderRadius: BorderRadius.circular(10.0),
          ),
          constraints: const BoxConstraints(maxHeight: 200)),
      items: countryNames,
      dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        labelText: "Select Country",
      )),
      selectedItem: selectedCountry,
      onChanged: (value) async {
        String code = countryCodes[getIndex(value!)];
        await Future.delayed(const Duration(milliseconds: 500));
        _setCountry(code);
        widget.onChanged(code);
      },
    );
  }
}
