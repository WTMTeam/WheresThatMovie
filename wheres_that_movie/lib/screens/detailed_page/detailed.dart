// detailed.dart
// Author: Samuel Rudqvist
// Created Date: Feb 12 2023
// Purpose:
//    The detailed screen provides details about where the
//    movie or show is available for Streaming, Buying and Renting.
//
// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//    (03/07/2023)(SR): Changed deprecated headlines and interpolation
//                      for the image path for the icons.
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:wheres_that_movie/database/database_helper.dart';
import 'package:wheres_that_movie/screens/detailed_page/local_widgets/country_dropdown.dart';
import 'package:wheres_that_movie/widgets/flash_message.dart';
import 'package:wheres_that_movie/widgets/my_container.dart';

class DetailedPage extends StatefulWidget {
  final int id;
  final bool isMovie;
  const DetailedPage({
    Key? key,
    required this.id,
    required this.isMovie,
  }) : super(key: key);

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  final String apiKey = 'dbffa0d16fb8dc2873531156a5c5f41a';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY';
  List streamingProviders = [];
  List logoPaths = [];
  List purchaseProviders = [];
  List locations = ["US", "SE"];
  List<String> options = ["Stream", "Buy", "Rent"];

  String title = "No title";
  String posterPath = " No posterPath";
  String mediaType = "No mediaType";
  String description = "No description";
  String currentOption = "Stream";
  String countryCode = "";

  bool _isLoading = false;
  bool _wentWrong = false;
  bool _noSuchMethod = false;
  bool itemExists = false;

  List myList = [];

  late Map movieResult;
  late Map showResult;

  // Function to get the different providers for the
  // current movie or show
  getProviders(int id, String currentOption) async {
    _isLoading = true;
    _noSuchMethod = false;

    try {
      final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, readAccessToken), //ApiKeys instance with your keys,
        logConfig: const ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        ),
      );

      Map providerResult;
      // Check if it is a movie or show and call the proper function \\

      if (widget.isMovie) {
        movieResult = await tmdbWithCustomLogs.v3.movies.getDetails(id);
        providerResult =
            await tmdbWithCustomLogs.v3.movies.getWatchProviders(id);
      } else {
        showResult = await tmdbWithCustomLogs.v3.tv.getDetails(id);
        providerResult =
            await tmdbWithCustomLogs.v3.tv.getWatchProviders(id.toString());
        print(providerResult);
      }

      setState(() {
        if (widget.isMovie) {
          title = movieResult['title'];
          description = movieResult['overview'];
          posterPath = movieResult['poster_path'];
        } else {
          title = showResult['name'];
          description = showResult['overview'];
          posterPath = showResult['poster_path'];
        }
        if (currentOption == "Stream") {
          if (providerResult['results'][countryCode]['flatrate'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['flatrate'] ?? [];
          }
        } else if (currentOption == "Buy") {
          if (providerResult['results'][countryCode]['buy'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['buy'] ?? [];
          }
        } else if (currentOption == "Rent") {
          if (providerResult['results'][countryCode]['rent'] == null) {
            _noSuchMethod = true;
          } else {
            streamingProviders =
                providerResult['results'][countryCode]['rent'] ?? [];
          }
        }
      });
      _isLoading = false;
    } on NoSuchMethodError {
      setState(() {
        _noSuchMethod = true;
        _isLoading = false;
      });
    } catch (e) {
      if (e is NoSuchMethodError) {
        setState(() {
          _isLoading = false;
          _noSuchMethod = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          _wentWrong = true;
        });
      }
    }
  }

  getMyList() async {
    bool currExists = await SQLHelper.checkItem(widget.id);
    setState(() {
      itemExists = currExists;
    });
  }

  @override
  void initState() {
    currentOption = "Stream";
    getProviders(widget.id, currentOption);
    getMyList();

    super.initState();
  }

  final ScrollController _myController = ScrollController();

  // Insert a new journal to the database
  Future<void> _addItem(
      int movieId, String movieTitle, String moviePath, bool isMovie) async {
    int isMovieInt = 0;
    if (isMovie) {
      isMovieInt = 1;
    }
    await SQLHelper.createItem(movieId, movieTitle, moviePath, isMovieInt);
    setState(() {
      getMyList();
    });
  }

  void _deleteItem(int movieOrShowId) async {
    List<Map<String, dynamic>> currItem =
        await SQLHelper.getItem(movieOrShowId);
    int id = currItem[0]['id'];
    await SQLHelper.deleteItem(id);
    getMyList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (_isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    } else if (_wentWrong) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Text(
                "Something Went Wrong",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 55.0,
            ),
            SizedBox(
              width: screenWidth,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: MyContainer(
                  child: Text(description,
                      style: Theme.of(context).textTheme.bodyLarge)),
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: itemExists
                    ? const Text(
                        "Remove from My List",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "Add to My List",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              onPressed: () {
                if (itemExists) {
                  _deleteItem(widget.id);
                } else {
                  _addItem(widget.id, title, posterPath, widget.isMovie);
                }
                getMyList();
              },
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                child: CountryDropdown(
                  onChanged: (code) {
                    countryCode = code;
                    print("here");
                    getProviders(widget.id, currentOption);
                  },
                )),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MyContainer(
                child: DropdownButton(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                  value: currentOption,
                  items: options
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) => setState(
                    () {
                      if (value != null) currentOption = value;
                      getProviders(widget.id, currentOption);
                    },
                  ),
                ),
              ),
            ),
            _noSuchMethod
                ? MyCustomErrorMessage(
                    errorText: currentOption,
                    isMovie: widget.isMovie,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: streamingProviders.length,
                    controller: _myController,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: MyContainer(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            leading: CachedNetworkImage(
                              imageUrl:
                                  "https://image.tmdb.org/t/p/w45${streamingProviders[index]['logo_path']}",
                              width: 50.0,
                            ),
                            title: Text(
                                streamingProviders[index]['provider_name']),
                          ),
                        ),
                      );
                    })),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ));
    }
  }
}
