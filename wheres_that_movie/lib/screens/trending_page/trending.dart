import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utils/provider/dark_theme_provider.dart';

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
  bool _isLoading = false;

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
    _isLoading = false;

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
        print(title);
        print(vote);
      } catch (e) {
        print(e);
        // print(trendingMovies[i]);
      }
    }
    print(trendingTitles);
    print(trendingMovies[0]);
    // print(trendingMovies[0]);
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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    if (_isLoading) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
            // SizedBox(
            //   // height: 50.0,
            //   // width: 50.0,
            //   child: CircularProgressIndicator(),
            // )
          ],
        ),
      );
      // return Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const <Widget>[
      //       SizedBox(
      //         height: 50.0,
      //         width: 50.0,
      //         child: CircularProgressIndicator(),
      //       )
      //     ],),
      // );
    } else {
      return Scaffold(
          body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50.0, bottom: 10.0)),
          Text(
            "Trending Movies",
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: trendingMovies.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(children: [
                        //Image(image: NetworkImage())

                        // )
                        // Image.network(
                        //   'https://image.tmdb.org/t/p/w500' +
                        //       trendingMovies[index]['poster_path'],
                        // ),

                        // ! Check if this is actually showing a loader.
                        Text(
                          trendingMovies[index]['title'] ??
                              trendingMovies[index]['name'],
                          style: Theme.of(context).textTheme.headline2,
                        ),

                        CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w500' +
                              trendingMovies[index]['poster_path'],
                          placeholder: _loader,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                          trendingMovies[index]['overview'],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),

                        Text(
                          "Rating:",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(trendingMovies[index]['vote_average']
                            .toStringAsFixed(2)),
                      ]),
                    );
                  })))

          // itemBuilder:
          // (BuildContext context, int index) => CachedNetworkImage(
          //   imageUrl: 'https://image.tmdb.org/t/p/w500' +
          //       trendingMovies[index]['poster_path'],
          //   placeholder: _loader,
          // ),
          // ))
        ],
      ));
    }
  }
}
