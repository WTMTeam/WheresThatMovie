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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/movie_model.dart';
import 'package:wheres_that_movie/screens/trending_page/filter.dart';
import 'package:wheres_that_movie/screens/trending_page/trending_appbar.dart';
import 'package:wheres_that_movie/screens/trending_page/trending_card.dart';

// carousel https://itnext.io/dynamically-sized-animated-carousel-in-flutter-8a88b005be74

class MyTrending extends StatefulWidget {
  const MyTrending({super.key});

  @override
  State<MyTrending> createState() => _MyTrendingState();
}

class _MyTrendingState extends State<MyTrending> {
  List<Movie> trendingMovies = [];
  List trendingTitles = [];
  List voteAverageMovie = [];
  List cards = [];
  bool _isLoading = false;
  bool _isError = false;
  String _errorText = "";
  bool isHorizontal = false;
  bool cardsVisible = true;
  final carouselController = PageController(viewportFraction: 0.8);
  final carouselController2 = PageController(viewportFraction: 0.8);

  loadTrendingMovies() async {
    _isLoading = true;
    String timeWindow = "week";
    try {
      trendingMovies = await MovieService().getTrendingMovies(timeWindow);
      makeCardList();
    } catch (error) {
      _errorText = error.toString();
      _isError = true;
      _isLoading = false;
    } finally {
      setState(() {});
    }
  }

  // Make the card list
  makeCardList() {
    List newCards = [];
    for (int i = 0; i < 10; i++) {
      try {
        newCards.add(CarouselCard(
          movie: trendingMovies[i],
          isHorizontal: isHorizontal,
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

  double getViewportFraction(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust these threshold values based on your preference
    if (screenWidth > 400) {
      return 0.8;
    } else {
      return 0.9;
    }
  }

  @override
  void initState() {
    loadTrendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          surfaceTintColor: Colors.transparent,
          shadowColor: Theme.of(context).colorScheme.secondary,
          elevation: 10.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.arrow_down,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
    } else if (_isError) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            surfaceTintColor: Colors.transparent,
            shadowColor: Theme.of(context).colorScheme.secondary,
            elevation: 10.0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                CupertinoIcons.arrow_down,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              "Something went wrong",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Icon(CupertinoIcons.wifi_exclamationmark),
                Text(_errorText),
              ],
            ),
          ));
    } else if (!isHorizontal) {
      print('vertical');
      return Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: screenHeight,
                  viewportFraction: 0.7,
                  scrollDirection: Axis.vertical,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43.0),
                    child: InkWell(child: cards[index]),
                  );
                },
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   width: screenWidth,
            //   height: 150,
            //   //color: Color.fromARGB(200, 0, 0, 0),
            //   child: IconButton(
            //     highlightColor: Colors.transparent,
            //     alignment: Alignment.bottomRight,
            //     icon: Icon(CupertinoIcons.bars),
            //     onPressed: () {
            //       showModalBottomSheet(
            //         backgroundColor: Theme.of(context).cardColor,
            //         context: context,
            //         builder: (BuildContext context) {
            //           return filterModal(context, (String selectedOption) {
            //             setState(() {
            //               //currentOption = selectedOption;
            //             });
            //           });
            //         },
            //       );
            //     },
            //   ),
            // ),
            MyCustomAppBar(
              title: "Trending",
              onBackButtonPressed: () {
                setState(() {
                  cardsVisible = false;
                });
                Navigator.of(context).pop();
              },
              onSwipeDown: () {
                setState(() {
                  cardsVisible = false;
                });
                cardsVisible = false;
                Navigator.of(context).pop();
              },
              makeCardList: makeCardList(),
              direction: isHorizontal,
              onIsHorizontalChanged: (newIsHorizontal) {
                setState(() {
                  isHorizontal = newIsHorizontal;
                  makeCardList();
                });
              },
            ),
          ]),
        ),
      );
    } else {
      return Scaffold(
          body: SafeArea(
        bottom: false,
        child: Column(children: <Widget>[
          MyCustomAppBar(
            title: "Trending",
            onBackButtonPressed: () {
              Navigator.of(context).pop();
            },
            onSwipeDown: () {
              Navigator.of(context).pop();
            },
            makeCardList: makeCardList(),
            direction: isHorizontal,
            onIsHorizontalChanged: (newIsHorizontal) {
              setState(() {
                isHorizontal = newIsHorizontal;
                makeCardList();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 8),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 450.0,
                aspectRatio: 1.5,
                viewportFraction: getViewportFraction(context),
              ),
              itemCount: cards.length,
              itemBuilder: (context, index, realIndex) {
                return InkWell(child: cards[index]);
              },
            ),
          ),
        ]),
      ));
    }
  }
}
