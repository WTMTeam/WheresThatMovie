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

import 'dart:convert';
// import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:developer';

// GENRE CODES
//https://www.themoviedb.org/talk/5daf6eb0ae36680011d7e6ee
// MOVIE
// Action          28
// Adventure       12
// Animation       16
// Comedy          35
// Crime           80
// Documentary     99
// Drama           18
// Family          10751
// Fantasy         14
// History         36
// Horror          27
// Music           10402
// Mystery         9648
// Romance         10749
// Science Fiction 878
// TV Movie        10770
// Thriller        53
// War             10752
// Western         37

// TV SHOW
// Action & Adventure  10759
// Animation           16
// Comedy              35
// Crime               80
// Documentary         99
// Drama               18
// Family              10751
// Kids                10762
// Mystery             9648
// News                10763
// Reality             10764
// Sci-Fi & Fantasy    10765
// Soap                10766
// Talk                10767
// War & Politics      10768
// Western             37

// ? https://levelup.gitconnected.com/how-i-organize-api-files-in-my-flutter-project-8f21c17050df

// * Example: https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=true&language=en-US&page=1&sort_by=popularity.desc&watch_region=US&with_genres=35&with_watch_providers=8'

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/constants.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';
import 'package:wheres_that_movie/screens/suggestions/options_dialog.dart';
import 'package:wheres_that_movie/screens/suggestions/suggestion_apis.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  // late Future<List<User>> futureUsers;
  late Future<List<Provider>> futureProviders;
  final List<String> providers = ['Netflix', 'Apple TV', 'Disney'];
  final List<String> genres = ['Comedy', 'Horror', 'Thriller'];
  final List<String> movieOrShow = ['Movie', 'TV-Show'];
  final List<String> lengths = [
    '<30min',
    '30-60min',
    '60-90min',
    '90-120min',
    '120min>'
  ];
  String currentProvider = 'Choose Provider';
  String currentGenre = 'Choose Genre';
  String currentMovieOrShow = 'Movie';
  String currentLength = 'Choose Length';

  void setProviders(dynamic option) {
    setState(() {
      currentProvider = option;
    });
  }

  void setGenre(dynamic option) {
    setState(() {
      currentGenre = option;
    });
  }

  void setMovieOrShow(dynamic option) {
    setState(() {
      currentMovieOrShow = option;
    });
  }

  void setLength(dynamic option) {
    setState(() {
      currentLength = option;
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

  loadUsers() async {
    final results = await UserService().getUser();
    print(results.length);
    for (var element in results) {
      print(element.name.first);
    }
  }

  @override
  void initState() {
    super.initState();
    // loadUsers();
    // futureUsers = UserService().getUser();
    // getAllFilms();
    futureProviders = ProviderService().getProviders();
  }

  // Future<List<dynamic>> getAllFilms() async {
  //   print("here");
  //   final Map<String, String> headers = {
  //     'accept': 'application/json',
  //     'Authorization':
  //         'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY',
  //   };
  //   var response = await http.get(
  //       Uri.parse(ApiEndPoint().getMovieStreamingProviderInfo),
  //       headers: headers);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     log("Data: $data");

  //     // final List<User> userList = [];

  //     // for (var i = 0; i < data['results'].length; i++) {
  //     //   final entry = data['results'][i];
  //     //   userList.add(User.fromJson(entry));
  //     // }
  //     // return userList;
  //   } else {
  //     throw Exception('HTTP FAILED with status code: ${response.statusCode}');
  //   }

  //   throw Exception("Test Failed");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              // Icons.arrow_back_ios,
              CupertinoIcons.arrow_left,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            "Suggestions",
            style: Theme.of(context).textTheme.displayLarge,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 10.0,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showOptionsDialog(context, providers, setProviders);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 40),
                            // maximumSize: const Size(200, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        child: Text(currentProvider),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showOptionsDialog(context, genres, setGenre);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 40),
                            // maximumSize: const Size(200, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        child: Text(currentGenre),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showOptionsDialog(
                              context, movieOrShow, setMovieOrShow);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 40),
                            // maximumSize: const Size(250, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        child: Text(currentMovieOrShow),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showOptionsDialog(context, lengths, setLength);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 40),
                            // maximumSize: const Size(250, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        child: Text(currentLength),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: FutureBuilder<List<Provider>>(
                    future: futureProviders,
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              Provider provider = snapshot.data?[index];
                              return ListTile(
                                title: Text(provider.providerName),
                                subtitle: Text(provider.providerID.toString()),
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.amberAccent,
                              );
                            },
                            itemCount: snapshot.data!.length);
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
