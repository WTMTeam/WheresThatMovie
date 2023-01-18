// logged_in.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//********************************************************************//

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service_lister/screens/landing_page/landing.dart';
import 'package:streaming_service_lister/screens/logged_in/local_widgets/service_selector.dart';
import 'package:streaming_service_lister/screens/logged_in/local_widgets/trending_movies_container.dart';
import 'package:streaming_service_lister/screens/my_list/local_widgets/my_list_container.dart';
import 'package:streaming_service_lister/screens/my_list/my_list.dart';
import 'package:streaming_service_lister/screens/notifications/notifications.dart';
import 'package:streaming_service_lister/screens/trending_page/trending.dart';
import 'package:streaming_service_lister/utils/provider/dark_theme_provider.dart';

import 'package:http/http.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MyLoggedIn extends StatefulWidget {
  const MyLoggedIn({Key? key}) : super(key: key);

  @override
  State<MyLoggedIn> createState() => _MyLoggedInState();
}

// * https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=dbffa0d16fb8dc2873531156a5c5f41a

// https://www.youtube.com/watch?v=ll8B8OnqVp4
class _MyLoggedInState extends State<MyLoggedIn> {
  final String apiKey = 'dbffa0d16fb8dc2873531156a5c5f41a';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  List searchResults = [];
  List tvShows = [];
  List movies = [];
  List people = [];

  mySearch() async {
    print("My Controller: ${myController.text}");
    final tmdbWithCustomLogs = TMDB(
      //TMDB instance
      ApiKeys(apiKey, readAccessToken), //ApiKeys instance with your keys,
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    String query = myController.text;
    Map result = await tmdbWithCustomLogs.v3.search.queryMulti(query);
    // Map result = await tmdbWithCustomLogs.v3.search.queryTvShows(query);
    setState(() {
      searchResults = result['results'];
    });
    print("searchResults: ${searchResults}");
    for (int i = 0; i < searchResults.length; i++) {
      if (searchResults[i]['media_type'] == "movie") {
        print(
            "${searchResults[i]['media_type']}: ${searchResults[i]['title']}");
        print("movie id: ${searchResults[i]['id']}");
        List movie = [];
        movie.add(searchResults[i]['id']);
        movie.add(searchResults[i]['title']);
        movie.add(searchResults[i]['overview']);
        movie.add(searchResults[i]['poster_path']);
        print("currMovie: ${movie}");
        movies.add(movie);
      } else if (searchResults[i]['media_type'] == "tv") {
        print("${searchResults[i]['media_type']}: ${searchResults[i]['name']}");
        List show = [];
        show.add(searchResults[i]['id']);
        show.add(searchResults[i]['name']);
        show.add(searchResults[i]['overview']);
        show.add(searchResults[i]['poster_path']);
        tvShows.add(show);
      } else if (searchResults[i]['media_type'] == "person") {
        print("${searchResults[i]['media_type']}: ${searchResults[i]['name']}");
        people.add(searchResults[i]['name']);
      }
    }
    print("movie list: ${movies}");
    print("tv-show list: ${tvShows}");
    print("people list: ${people}");
    // Map providerResult = await tmdbWithCustomLogs.v3.discover.getMovies(withWatchProviders: "netflix", watchRegion: "US");
    Map providerResult =
        await tmdbWithCustomLogs.v3.movies.getWatchProviders(movies[1][0]);
    print('');
    print(providerResult['results']["SE"]['flatrate'][0]);
    print(providerResult['results']["US"]['flatrate'][0]);

    // log(providerResult['results']["US"]);
    // for (int i = 0; i < providerResult['results'].length; i++) {}
    // List flatrates = providerResult['results']['AD'];
    // print(flatrates);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      // Used for opening the drawer header
      key: _scaffoldKey,

      // The settings button
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        // foregroundColor: Colors.white,
        elevation: 0.0,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(
          Icons.menu,
          size: 30.0,
        ),
      ),

      // Setting the location of the settings button
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                Text(
                  "Search for a movie or tv-show",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      //color: Theme.of(context).secondary,
                    ),
                    //focusColor: Colors.red,
                  ),
                  //autofocus: true,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const MyServiceSelector(),
                const SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  onPressed: () {
                    mySearch();
                  },
                ),
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   primary: const Color.fromARGB(255, 255, 0, 0)
                  // ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "See Trending",
                      style: TextStyle(
                          //color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyTrending(),
                      ),
                    );
                  }, // Do nothing for now
                ),
              ],
            ),
          ),
        ],
      ),

      // Settings Menu
      drawer: Drawer(
          //width: 200,

          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),
              children: [
                Row(
                  children: const <Widget>[
                    Icon(
                      Icons.account_circle_rounded,
                      size: 50.0,
                    ),
                    // Add space between the logo and the username
                    SizedBox(
                      width: 10.0,
                    ),
                    // Add the logged in users name
                    Text(
                      "username",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),

                // Add some space between the username/logo and the first option
                const SizedBox(
                  height: 20.0,
                ),

                Card(
                  //color: Theme.of(context).,
                  child: ListTile(
                    title: Text(
                      "My List",
                      style: Theme.of(context).textTheme.labelMedium,
                      // style: TextStyle(
                      //   fontSize: 20.0
                      // ),
                    ),
                    leading: const Icon(Icons.list),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyList(),
                      ));
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    title: Text(
                      "Notifications",
                      style: Theme.of(context).textTheme.labelMedium,
                      // style: TextStyle(
                      //   fontSize: 20.0
                      // ),
                    ),
                    leading: const Icon(Icons.notifications),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MyNotifications(),
                      ));
                    },
                  ),
                ),

                Card(
                  child: SwitchListTile(
                    title: Text(
                      "Theme",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    secondary: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    // activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsetsDirectional.only(bottom: 75.0),
            child: Card(
              child: ListTile(
                title: const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: const Icon(
                  Icons.logout_rounded,
                ),
                //style: ListTileTheme.of(context),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyLanding(),
                  ));
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
