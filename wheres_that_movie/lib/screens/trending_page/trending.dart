// trending.dart
// Author: Samuel Rudqvist
// Date Created: Unknown

// Purpose:
//    This is the screen where the user can see the movies and shows
//    that are currently trending.

// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//    (03/07/2023)(SR): Changed deprecated headlines
//

import 'dart:math';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:wheres_that_movie/screens/trending_page/trending_card.dart';

// carousel https://itnext.io/dynamically-sized-animated-carousel-in-flutter-8a88b005be74

class MyTrending extends StatefulWidget {
  const MyTrending({Key? key}) : super(key: key);

  @override
  State<MyTrending> createState() => _MyTrendingState();
}

class _MyTrendingState extends State<MyTrending> {
  final String apiKey = 'dbffa0d16fb8dc2873531156a5c5f41a';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY';
  List trendingMovies = [];
  List trendingTitles = [];
  List voteAverageMovie = [];
  List cards = [];
  bool _isLoading = false;
  bool isHorizontal = false;
  final carouselController = PageController(viewportFraction: 0.8);
  final carouselController2 = PageController(viewportFraction: 0.8);

  loadTrendingMovies() async {
    _isLoading = true;
    final tmdbWithCustomLogs = TMDB(
      //TMDB instance
      ApiKeys(apiKey, readAccessToken), //ApiKeys instance with your keys,
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    Map result = await tmdbWithCustomLogs.v3.trending.getTrending();

    setState(() {
      trendingMovies = result['results'];
    });
    for (int i = 0; i < 10; i++) {
      try {
        // if title returns null, then try name instead
        String title = trendingMovies[i]["title"] ?? trendingMovies[i]['name'];

        double vote = trendingMovies[i]["vote_average"];
        trendingTitles.add(title);
        voteAverageMovie.add(vote);
      } catch (e) {
        // Print error message
      }
    }
    makeCardList();
  }

  // Make the card list
  makeCardList() {
    // reset the cards list
    List newCards = [];
    for (int i = 0; i < 10; i++) {
      try {
        // if title returns null, then try name instead
        String title = trendingMovies[i]["title"] ?? trendingMovies[i]['name'];
        // ignore: prefer_interpolation_to_compose_strings
        String imgUrl = 'https://image.tmdb.org/t/p/w500' +
            trendingMovies[i]['poster_path'];
        String overview = trendingMovies[i]['overview'];
        double vote = trendingMovies[i]["vote_average"];
        int id = trendingMovies[i]["id"];
        String mediaType = trendingMovies[i]["media_type"];
        bool isMovie = false;
        if (mediaType == "movie") {
          isMovie = true;
        }

        // Add the current card to the list of new cards
        newCards.add(CarouselCard(
          id: id,
          imgUrl: imgUrl,
          title: title,
          overview: overview,
          rating: vote,
          isHorizontal: isHorizontal,
          isMovie: isMovie,
        ));
        setState(() {
          cards = newCards;
        });
      } catch (e) {
        // Print error message
      }
    }
    // All the information should be loaded by now
    _isLoading = false;
  }

  @override
  void initState() {
    loadTrendingMovies();
    super.initState();
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
    } else if (!isHorizontal) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0.0,
          onPressed: () {
            isHorizontal ? isHorizontal = false : isHorizontal = true;
            makeCardList();
          },
          child: isHorizontal
              ? const Icon(
                  Icons.swap_vert,
                )
              : const Icon(
                  Icons.swap_horiz,
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: SafeArea(
          bottom: false,
          child: Column(children: <Widget>[
            SizedBox(
              height: 50.0,
              child: Text(
                "Trending",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight / 1.2,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExpandablePageView.builder(
                            scrollDirection: Axis.vertical,
                            controller: carouselController,
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
                                        (carouselController.page! - index)
                                                .abs() /
                                            2),
                                  ),
                                  child: cards[index],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    } else {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            elevation: 0.0,
            onPressed: () {
              isHorizontal ? isHorizontal = false : isHorizontal = true;
              makeCardList();
            },
            child: isHorizontal
                ? const Icon(Icons.swap_vert)
                : const Icon(Icons.swap_horiz),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: SafeArea(
            bottom: false,
            child: Column(children: <Widget>[
              SizedBox(
                height: 50.0,
                child: Text(
                  "Trending",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              SizedBox(
                height: screenHeight / 1.2,
                width: screenWidth,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExpandablePageView.builder(
                            controller: carouselController2,
                            // allows our shadow to be displayed outside of widget bounds
                            clipBehavior: Clip.none,
                            itemCount: cards.length,
                            itemBuilder: (_, index) {
                              if (!carouselController2
                                  .position.haveDimensions) {
                                return const SizedBox();
                              }
                              return AnimatedBuilder(
                                animation: carouselController2,
                                builder: (_, __) => Transform.scale(
                                  scale: max(
                                    0.85,
                                    (1 -
                                        (carouselController2.page! - index)
                                                .abs() /
                                            2),
                                  ),
                                  child: cards[index],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ));
    }
  }
}
