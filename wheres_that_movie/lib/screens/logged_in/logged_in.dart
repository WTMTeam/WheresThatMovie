// logged_in.dart
// Author: Samuel Rudqvist
// Date Created: 09/10/2022
//

//********************************************************************//
//*       This is the screen the user will see when logged in        *//
//********************************************************************//

import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheres_that_movie/screens/my_list/my_list.dart';
import 'package:wheres_that_movie/screens/trending_page/trending.dart';
import 'package:wheres_that_movie/utils/provider/dark_theme_provider.dart';

import 'package:tmdb_api/tmdb_api.dart';

import 'local_widgets/search_result_cards.dart';

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

  String previousSearch = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  List searchResults = [];
  List tvShows = [];
  List movies = [];
  List people = [];
  List cards = [];
  List showsAndMovies = [];

  mySearch() async {
    searchResults = [];
    tvShows = [];
    movies = [];
    people = [];
    showsAndMovies = [];

    print("My Controller: ${myController.text}");

    if (myController.text.isEmpty) {
      print("No Search Input");
      setState(() {
        cards = [];
      });
    } else if (myController.text == previousSearch) {
      // Do nothing
      print("Same search input as previous, not sending a new request");
    } else {
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
        previousSearch = myController.text;
        searchResults = result['results'];
      });
      print("searchResults: ${searchResults}");
      for (int i = 0; i < searchResults.length; i++) {
        if (searchResults[i]['media_type'] == "movie") {
          // print(
          //     "${searchResults[i]['media_type']}: ${searchResults[i]['title']}");
          // print("movie id: ${searchResults[i]['id']}");
          List movie = [];
          movie.add(searchResults[i]['id']);
          movie.add(searchResults[i]['title']);
          movie.add(searchResults[i]['overview']);
          movie.add(searchResults[i]['vote_average']);
          movie.add(searchResults[i]['poster_path']);
          // print("currMovie: ${movie}");
          movies.add(movie);
          // showsAndMovies.add(movie);
          var thisMovie = {
            'id': searchResults[i]['id'],
            'title': searchResults[i]['title'],
            'overview': searchResults[i]['overview'],
            'rating': searchResults[i]['vote_average'],
            'poster_path': searchResults[i]['poster_path'],
            'isMovie': true,
          };
          showsAndMovies.add(thisMovie);
        } else if (searchResults[i]['media_type'] == "tv") {
          // print("${searchResults[i]['media_type']}: ${searchResults[i]['name']}");
          List show = [];
          show.add(searchResults[i]['id']);
          show.add(searchResults[i]['name']);
          show.add(searchResults[i]['overview']);
          show.add(searchResults[i]['vote_average']);
          show.add(searchResults[i]['poster_path']);

          tvShows.add(show);
          // showsAndMovies.add(show);

          var thisShow = {
            'id': searchResults[i]['id'],
            'title': searchResults[i]['name'],
            'overview': searchResults[i]['overview'],
            'rating': searchResults[i]['vote_average'],
            'poster_path': searchResults[i]['poster_path'],
            'isMovie': false,
          };
          showsAndMovies.add(thisShow);
        } else if (searchResults[i]['media_type'] == "person") {
          // print("${searchResults[i]['media_type']}: ${searchResults[i]['name']}");
          people.add(searchResults[i]['name']);
        }
      }
      // print("movie list: ${movies}");
      // print("show list: ${tvShows}");
      // print("Shows and Movies: ${showsAndMovies[0]['id']}");

      makeCardList();
    }
  }

  // Function to make the card list
  makeCardList() {
    // reset the cards list
    print("here2");
    // print(movies[0]);
    List newCards = [];
    for (int i = 0; i < showsAndMovies.length; i++) {
      try {
        // if title returns null, then try name instead
        // int id = showsAndMovies[i][0];
        // String title = showsAndMovies[i][1];
        // print(title);
        // // ignore: prefer_interpolation_to_compose_strings
        // String imgUrl = 'https://image.tmdb.org/t/p/w200' +
        //     showsAndMovies[i][showsAndMovies[i].length - 1];
        // String overview = movies[i][2];
        // // double vote = movies[i][1];
        // double vote = 5.0;
        // print(showsAndMovies[i][showsAndMovies[i].length - 2]);

        // vote = showsAndMovies[i][showsAndMovies[i].length - 2];
        String imgUrl = 'https://image.tmdb.org/t/p/w200' +
            showsAndMovies[i]['poster_path'];

        if (imgUrl == null) {
          imgUrl = "";
        } else {
          // Do nothing
        }

        newCards.add(SearchCarouselCard(
          id: showsAndMovies[i]['id'],
          imgUrl: imgUrl,
          title: showsAndMovies[i]['title'],
          overview: showsAndMovies[i]['overview'],
          rating: showsAndMovies[i]['rating'],
          isMovie: showsAndMovies[i]['isMovie'],
        ));
        // newCards.add(SearchCarouselCard(
        //   id: id,
        //   imgUrl: imgUrl,
        //   title: title,
        //   overview: overview,
        //   rating: vote,
        // ));
        setState(() {
          cards = newCards;
        });

        // print(title);
        // print(vote);
      } catch (e) {
        print(e);
        // print(trendingMovies[i]);
      }
    }
    print(cards);
    print("done");
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final carouselController = PageController(viewportFraction: 0.8);
    final scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void toTop() {
      print(carouselController.offset);
      int animTime = carouselController.offset.round();
      if (animTime < 600) {
        animTime = 500;
      }
      print(animTime);
      // original time 200
      carouselController.animateTo(0,
          duration: Duration(milliseconds: animTime), curve: Curves.easeInOut);
    }

    return Scaffold(
      // Used for opening the drawer header
      key: _scaffoldKey,

      // The settings button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
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

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          controller:
              scrollController.hasClients ? scrollController : scrollController,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),

              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Search for a movie or tv-show",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    //focusColor: Colors.red,
                  ),
                  //autofocus: true,
                ),
              ),

              ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.0),
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                onPressed: () {
                  mySearch();
                  toTop();
                },
              ),
              cards.isEmpty
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ExpandablePageView.builder(
                        controller: carouselController,
                        // allows our shadow to be displayed outside of widget bounds
                        clipBehavior: Clip.none,
                        itemCount: cards.length,
                        itemBuilder: (_, index) {
                          if (!carouselController.position.haveDimensions) {
                            return const SizedBox();
                          }
                          return AnimatedBuilder(
                            animation: carouselController,
                            builder: (_, __) => Transform.scale(
                              scale: max(
                                0.85,
                                (1 -
                                    (carouselController.page! - index).abs() /
                                        2),
                              ),
                              child: cards[index],
                            ),
                          );
                        },
                      ),
                    ),

              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.0),
                    child: Text(
                      "See Trending",
                      style: TextStyle(
                        //color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    print("pressed");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyTrending(),
                      ),
                    );
                  }, // Do nothing for now
                ),
              ),
              // Spacer()
            ],
          ),
        ),
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
                  children: <Widget>[
                    // FlutterLogo(),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Image.asset(
                      'assets/logo2.png',
                      width: 45,
                      height: 45,
                    ),

                    SizedBox(
                      width: 10.0,
                    ),
                    // Add the logged in users name
                    Text(
                      "WMM",
                      style: Theme.of(context).textTheme.headline1,
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

                // * Card for notification * \\
                // Card(
                //   child: ListTile(
                //     title: Text(
                //       "Notifications",
                //       style: Theme.of(context).textTheme.labelMedium,
                //       // style: TextStyle(
                //       //   fontSize: 20.0
                //       // ),
                //     ),
                //     leading: const Icon(Icons.notifications),
                //     onTap: () {
                //       // Update the state of the app
                //       // ...
                //       // Then close the drawer
                //       Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => const MyNotifications(),
                //       ));
                //     },
                //   ),
                // ),
                // * End Card for notification * \\

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
                        previousSearch = "";
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                ),
              ],
            ),
          ),

          // * Container for log out button * \\
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   padding: const EdgeInsetsDirectional.only(bottom: 75.0),
          //   child: Card(
          //     child: ListTile(
          //       title: const Text(
          //         "Log Out",
          //         style: TextStyle(fontSize: 20.0),
          //       ),
          //       trailing: const Icon(
          //         Icons.logout_rounded,
          //       ),
          //       //style: ListTileTheme.of(context),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => const MyLanding(),
          //         ));
          //       },
          //     ),
          //   ),
          // ),
          // * End container for log out button * \\
        ],
      )),
    );
  }
}
