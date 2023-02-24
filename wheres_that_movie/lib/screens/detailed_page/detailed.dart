// detailed.dart
// Created Date: Feb 12 2023

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:tmdb_api/tmdb_api.dart';
import 'package:wheres_that_movie/database/database_helper.dart';
import 'package:wheres_that_movie/widgets/my_container.dart';

class DetailedPage extends StatefulWidget {
  final int id;
  const DetailedPage({
    Key? key,
    required this.id,
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

  bool _isLoading = false;
  bool _wentWrong = false;

  // Function to get the different providers for the
  // current movie or show
  getProviders(int id, String currentOption) async {
    _isLoading = true;
    try {
      final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, readAccessToken), //ApiKeys instance with your keys,
        logConfig: const ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        ),
      );

      Map providerResult =
          await tmdbWithCustomLogs.v3.movies.getWatchProviders(id);
      Map movieResult = await tmdbWithCustomLogs.v3.movies.getDetails(id);

      print(providerResult);
      // print(providerResult['result']);
      // streamingProviders = providerResult['results']["US"]['flatrate'];
      setState(() {
        if (currentOption == "Stream") {
          streamingProviders = providerResult['results']["US"]['flatrate'];
        } else if (currentOption == "Buy") {
          streamingProviders = providerResult['results']["US"]['buy'];
        } else if (currentOption == "Rent") {
          streamingProviders = providerResult['results']["US"]['rent'];
        }
        title = movieResult['title'];
        description = movieResult['overview'];
        posterPath = movieResult['poster_path'];
      });
      _isLoading = false;
    } catch (e) {
      setState(() {
        _isLoading = false;
        _wentWrong = true;
      });

      print(e);
    }
  }

  // getInfo(int id) async {
  //   is
  // }

  @override
  void initState() {
    currentOption = "Stream";
    getProviders(widget.id, currentOption);

    super.initState();
  }

  ScrollController _myController = ScrollController();

  // Insert a new journal to the database
  Future<void> _addItem(
      int movieId, String movieTitle, String moviePath) async {
    print("adding item: ${movieId}");
    await SQLHelper.createItem(movieId, movieTitle, moviePath);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                style: Theme.of(context).textTheme.headline1,
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
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: MyContainer(
                  child: Text(description,
                      style: Theme.of(context).textTheme.bodyLarge)),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            //   child: MyContainer(
            //     child: CachedNetworkImage(
            //         imageUrl: 'https://image.tmdb.org/t/p/w500' + posterPath),
            //   ),
            // ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: Text(
                  "Add to My List",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              onPressed: () {
                _addItem(widget.id, title, posterPath);
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              // padding: EdgeInsets.only(left: 10.0, right: 10.0),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Theme.of(context).primaryColor,
                // color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: MyContainer(
                child: DropdownButton(
                  // alignment: Alignment.topLeft,
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
            ListView.builder(
                padding: EdgeInsets.only(top: 10),
                shrinkWrap: true,
                itemCount: streamingProviders.length,
                controller: _myController,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: MyContainer(
                      // margin: EdgeInsets.only(
                      //     left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      child: ListTile(
                        // tileColor: Theme.of(context).colorScheme.primaryContainer,
                        contentPadding: EdgeInsets.all(5),
                        leading: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w45' +
                              streamingProviders[index]['logo_path'],
                          width: 50.0,
                        ),
                        title: Text(streamingProviders[index]['provider_name']),
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
