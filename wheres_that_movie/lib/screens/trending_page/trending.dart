import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:wheres_that_movie/screens/trending_page/trending_card.dart';

import '../../utils/provider/dark_theme_provider.dart';

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
    // _isLoading = false;

    setState(() {
      trendingMovies = result['results'];
    });
    for (int i = 0; i < 10; i++) {
      try {
        // if title returns null, then try name instead
        String title = trendingMovies[i]["title"] ?? trendingMovies[i]['name'];
        // ignore: prefer_interpolation_to_compose_strings
        // String imgUrl = 'https://image.tmdb.org/t/p/w500' +
        //     trendingMovies[i]['poster_path'];
        // String overview = trendingMovies[i]['overview'];
        double vote = trendingMovies[i]["vote_average"];
        trendingTitles.add(title);
        voteAverageMovie.add(vote);
        // cards.add(CarouselCard(
        //   imgUrl: imgUrl,
        //   title: title,
        //   overview: overview,
        //   rating: vote,
        // ));
        print(title);
        // print(vote);
      } catch (e) {
        // print(e);
        // print(trendingMovies[i]);
      }
    }
    makeCardList();

    // print(trendingTitles);
    // print(trendingMovies[0]);
    // print(trendingMovies[0]);
  }

  // Function to make the card list
  makeCardList() {
    // reset the cards list
    print("here2");
    List newCards = [];
    for (int i = 0; i < 10; i++) {
      try {
        // if title returns null, then try name instead
        String title = trendingMovies[i]["title"] ?? trendingMovies[i]['name'];
        print(title);
        // ignore: prefer_interpolation_to_compose_strings
        String imgUrl = 'https://image.tmdb.org/t/p/w500' +
            trendingMovies[i]['poster_path'];
        String overview = trendingMovies[i]['overview'];
        double vote = trendingMovies[i]["vote_average"];

        newCards.add(CarouselCard(
          imgUrl: imgUrl,
          title: title,
          overview: overview,
          rating: vote,
          isHorizontal: isHorizontal,
        ));
        setState(() {
          cards = newCards;
        });

        // print(title);
        // print(vote);
      } catch (e) {
        // print(e);
        // print(trendingMovies[i]);
      }
    }
    _isLoading = false;
    print("false");
  }

  @override
  void initState() {
    loadTrendingMovies();
    super.initState();
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  final carouselController = PageController(viewportFraction: 0.8);
  final carouselController2 = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
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
      // return Scaffold(
      //     body: Column(children: <Widget>[
      //   SizedBox(
      //     height: 55.0,
      //   ),
      //   SizedBox(
      //     height: 40.0,
      //     child: Text(
      //       "Trending",
      //       style: Theme.of(context).textTheme.headline1,
      //     ),
      //   ),
      //   SizedBox(
      //     height: screenHeight - 95.0,
      //     width: screenWidth,
      //     child: CustomScrollView(
      //       slivers: [
      //         SliverFillRemaining(
      //           hasScrollBody: false,
      //           child: Column(
      //             children: [
      //               const SizedBox(height: 15),
      //               ExpandablePageView.builder(
      //                 controller: carouselController,
      //                 // allows our shadow to be displayed outside of widget bounds
      //                 clipBehavior: Clip.none,
      //                 itemCount: cards.length,
      //                 itemBuilder: (_, index) {
      //                   if (!carouselController.position.haveDimensions) {
      //                     return const SizedBox();
      //                   }
      //                   return AnimatedBuilder(
      //                     animation: carouselController,
      //                     builder: (_, __) => Transform.scale(
      //                       scale: max(
      //                         0.85,
      //                         (1 -
      //                             (carouselController.page! - index).abs() / 2),
      //                       ),
      //                       child: cards[index],
      //                     ),
      //                   );
      //                 },
      //               ),
      //               const Spacer(),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ]));

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
          onPressed: () {
            isHorizontal ? isHorizontal = false : isHorizontal = true;
            makeCardList();
          },
          child: isHorizontal ? Icon(Icons.swap_vert) : Icon(Icons.swap_horiz),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Column(children: <Widget>[
          SizedBox(
            height: 55.0,
          ),
          SizedBox(
            height: 40.0,
            child: Text(
              "Trending",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight - 183,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: screenWidth,
                    height: screenHeight - 183,
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
                                      (carouselController.page! - index).abs() /
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
      );
    } else {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0.0,
            onPressed: () {
              isHorizontal ? isHorizontal = false : isHorizontal = true;
              makeCardList();
            },
            child:
                isHorizontal ? Icon(Icons.swap_vert) : Icon(Icons.swap_horiz),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: Column(children: <Widget>[
            SizedBox(
              height: 55.0,
            ),
            SizedBox(
              height: 40.0,
              child: Text(
                "Trending",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: screenHeight - 95.0,
              width: screenWidth,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const SizedBox(height: 70),
                        ExpandablePageView.builder(
                          controller: carouselController2,
                          // allows our shadow to be displayed outside of widget bounds
                          clipBehavior: Clip.none,
                          itemCount: cards.length,
                          itemBuilder: (_, index) {
                            if (!carouselController2.position.haveDimensions) {
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
                        const Spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]));
    }
  }
}
      // return Scaffold(
      //     body: Column(children: <Widget>[
      //   SizedBox(
      //     height: 55.0,
      //   ),
      //   SizedBox(
      //     height: 40.0,
      //     child: Text(
      //       "Trending",
      //       style: Theme.of(context).textTheme.headline1,
      //     ),
      //   ),
      //   SizedBox(
      //       width: screenWidth,
      //       height: screenHeight - 200,
      //       child: CustomScrollView(
      //         slivers: [
      //           SliverFillRemaining(
      //               hasScrollBody: false,
      //               // child: Center(
      //               child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     // Text(
      //                     //   "test",
      //                     //   style: Theme.of(context).textTheme.bodyLarge,
      //                     // ),
      //                     ExpandablePageView.builder(
      //                       scrollDirection: Axis.vertical,
      //                       controller: carouselController,
      //                       // allows our shadow to be displayed outside of widget bounds
      //                       clipBehavior: Clip.none,
      //                       itemCount: cards.length,
      //                       itemBuilder: (_, index) {
      //                         if (!carouselController.position.haveDimensions) {
      //                           return const SizedBox();
      //                         }
      //                         return AnimatedBuilder(
      //                           animation: carouselController,
      //                           builder: (_, __) => Transform.scale(
      //                             scale: max(
      //                               0.85,
      //                               (1 -
      //                                   (carouselController.page! - index)
      //                                           .abs() /
      //                                       2),
      //                             ),
      //                             child: cards[index],
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                     // const Spacer(),
      //                   ])),
      //           // )
      //         ],
      //       ))
      // ]));
//     }
//   }
// }

// * Kind of works for vertical scrolling
// return Scaffold(
//           body: SizedBox(
//         width: screenWidth,
//         height: screenHeight,
//         child: ExpandablePageView.builder(
//           scrollDirection: Axis.vertical,
//           controller: carouselController,
//           // allows our shadow to be displayed outside of widget bounds
//           clipBehavior: Clip.none,
//           itemCount: cards.length,
//           itemBuilder: (_, index) {
//             if (!carouselController.position.haveDimensions) {
//               return const SizedBox();
//             }
//             return AnimatedBuilder(
//               animation: carouselController,
//               builder: (_, __) => Transform.scale(
//                 scale: max(
//                   0.85,
//                   (1 - (carouselController.page! - index).abs() / 2),
//                 ),
//                 child: cards[index],
//               ),
//             );
//           },
//         ),
//         // const Spacer(),
//       ));

// * Works for horizontal scrolling
// return Scaffold(
//           body: Column(children: <Widget>[
//         SizedBox(
//           height: 55.0,
//         ),
//         SizedBox(
//           height: 40.0,
//           child: Text(
//             "Trending",
//             style: Theme.of(context).textTheme.headline1,
//           ),
//         ),
//         SizedBox(
//           height: screenHeight - 95.0,
//           width: screenWidth,
//           child: CustomScrollView(
//             slivers: [
//               SliverFillRemaining(
//                 hasScrollBody: false,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 15),
//                     ExpandablePageView.builder(
//                       controller: carouselController,
//                       // allows our shadow to be displayed outside of widget bounds
//                       clipBehavior: Clip.none,
//                       itemCount: cards.length,
//                       itemBuilder: (_, index) {
//                         if (!carouselController.position.haveDimensions) {
//                           return const SizedBox();
//                         }
//                         return AnimatedBuilder(
//                           animation: carouselController,
//                           builder: (_, __) => Transform.scale(
//                             scale: max(
//                               0.85,
//                               (1 -
//                                   (carouselController.page! - index).abs() / 2),
//                             ),
//                             child: cards[index],
//                           ),
//                         );
//                       },
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ]));


