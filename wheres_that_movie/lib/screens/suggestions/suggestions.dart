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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheres_that_movie/api/models/movie_model.dart';
import 'package:wheres_that_movie/api/models/genre_model.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';
import 'package:wheres_that_movie/screens/detailed_page/detailed.dart';
import 'package:wheres_that_movie/screens/suggestions/options_dialog.dart';
import 'package:wheres_that_movie/widgets/my_container.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
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
  List<Provider>? currentProviders;
  List<Genre>? currentGenres;
  String currentMovieOrShow = 'Movie';
  dynamic currentLength = 'Choose Length';
  bool lengthLessThan = false;

  Future<List<Movie>>? movieSuggestions;

  List<int> testList = [1, 2, 3, 4, 5, 6];

  void setProviders(dynamic selectedProviders) {
    setState(() {
      if (selectedProviders.isEmpty) {
        currentProviders = null;
      } else {
        currentProviders = selectedProviders;
      }
    });
  }

  void setGenres(dynamic selectedGenres) {
    setState(() {
      if (selectedGenres.isEmpty) {
        currentGenres = null;
      }
      currentGenres = selectedGenres;
    });
  }

  void setMovieOrShow(dynamic option) {
    if (option == "Movie") {
      option = "TV Show";
    } else if (option == "TV Show") {
      option = "Movie";
    }
    setState(() {
      currentMovieOrShow = option;
    });
  }

  void setLength(dynamic lengthList) {
    setState(() {
      currentLength = lengthList[0];
      lengthLessThan = lengthList[1];
    });
  }

  void _showOptionsDialog(
      BuildContext context, Function(dynamic) setCurrentOption, button,
      {List<Provider>? currentProviders, List<Genre>? currentGenres}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OptionsDialog(
          button: button,
          currentProviders: currentProviders,
          currentGenres: currentGenres,
          onOptionSelected: (option) {
            setCurrentOption(option);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
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
                          _showOptionsDialog(context, setProviders, "Provider",
                              currentProviders: currentProviders);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(175, 40),
                          // maximumSize: const Size(200, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text("Providers"),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showOptionsDialog(context, setGenres, "Genre",
                              currentGenres: currentGenres);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(175, 40),
                          // maximumSize: const Size(200, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text("Genres"),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     ElevatedButton.icon(
                  //       //icon: const Icon(Icons.sync_outlined),
                  //       icon: const Icon(CupertinoIcons.shuffle),
                  //       onPressed: () {
                  //         // * Todo:
                  //         //    - Change this to have a toggle switch and don't call _showOptionsDialog
                  //         setMovieOrShow(currentMovieOrShow);
                  //         // _showOptionsDialog(
                  //         //     context, setMovieOrShow, "movieOrShow");
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //           minimumSize: const Size(175, 40),
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20.0))),
                  //       label: Text(currentMovieOrShow),
                  //     ),
                  //     const SizedBox(
                  //       height: 4.0,
                  //     ),
                  //     ElevatedButton.icon(
                  //       icon: const Icon(CupertinoIcons.timer),
                  //       onPressed: () {
                  //         _showOptionsDialog(context, setLength, "length");
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //           minimumSize: const Size(175, 40),
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20.0))),
                  //       label: Text('${currentLength.toString()}min'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                child: Divider(
                  thickness: 2.0,
                  color: Theme.of(context).highlightColor,
                ),
              ),
              if (currentProviders != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8.0,
                    children: currentProviders!
                        .map(
                          (provider) => ElevatedButton(
                            onPressed: () {
                              print(provider.providerName);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                side: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColor)),
                            child: Text(provider.providerName),
                          ),
                        )
                        .toList(),
                  ),
                ),
              if (currentGenres != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8.0,
                    children: currentGenres!
                        .map(
                          (genre) => ElevatedButton(
                            onPressed: () {
                              print(genre.genreName);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                side: BorderSide(
                                    width: 2.0,
                                    color: Theme.of(context).primaryColor)),
                            child: Text(genre.genreName),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ElevatedButton(
                child: const Text("Get Suggestions"),
                onPressed: () async {
                  try {
                    // Call the asynchronous function and wait for the result
                    setState(() {
                      movieSuggestions = MovieService().getMovieSuggestions(
                        providers: currentProviders,
                        genres: currentGenres,
                      );
                    });
                  } catch (error) {
                    // Handle errors if any
                    print("Error fetching movie suggestions: $error");
                  }
                },
                // onPressed: () {
                //   setState(() {
                //     movieSuggestions = MovieService().getMovieSuggestions(
                //         providers: currentProviders, genres: currentGenres);
                //   });
                // },
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                  child: FutureBuilder<List<Movie>>(
                    future: movieSuggestions,
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("No movie suggestions."));
                      } else {
                        print("Snapshot: ${snapshot.data.length}");
                        return CarouselSlider.builder(
                            options: CarouselOptions(height: 700.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index, realIndex) {
                              Movie movie = snapshot.data[index];
                              String posterUrl =
                                  "https://image.tmdb.org/t/p/w500${movie.posterPath}";
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailedPage(
                                          id: movie.movieID, isMovie: true),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: CachedNetworkImage(
                                      imageUrl: posterUrl,
                                      width: 500,
                                      errorWidget:
                                          (context, posterUrl, error) =>
                                              const Icon(
                                                Icons.no_photography_outlined,
                                                size: 50,
                                              )),
                                ),
                              );
                            });
                        //             return ListView.builder(
                        //               shrinkWrap: true,
                        //               itemBuilder: (context, index) {
                        //                 Movie movie = snapshot.data[index];
                        //                 String posterUrl =
                        //                     "https://image.tmdb.org/t/p/w45${movie.posterPath}";
                        //
                        //                 return Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       vertical: 10.0, horizontal: 10.0),
                        //                   child: MyContainer(
                        //                     child: ListTile(
                        //                       dense: true,
                        //                       visualDensity:
                        //                           const VisualDensity(vertical: 0.0),
                        //                       leading: CachedNetworkImage(
                        //                         imageUrl: posterUrl,
                        //                         width: 50.0,
                        //                         errorWidget: (context, imgUrl, error) =>
                        //                             const Icon(
                        //                                 Icons.no_photography_outlined,
                        //                                 size: 50),
                        //                       ),
                        //                       title: Text(movie.title,
                        //                           style: TextStyle(
                        //                               color:
                        //                                   Theme.of(context).primaryColor,
                        //                               fontSize: 20.0,
                        //                               fontWeight: FontWeight.bold)),
                        //                       onTap: () {
                        //                         Navigator.of(context).push(
                        //                           MaterialPageRoute(
                        //                             builder: (context) => DetailedPage(
                        //                               id: movie.movieID,
                        //                               isMovie: true,
                        //                             ),
                        //                           ),
                        //                         );
                        //                       },
                        //                     ),
                        //                   ),
                        //                 );
                        //               },
                        //               itemCount: snapshot.data!.length,
                        //             );
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
