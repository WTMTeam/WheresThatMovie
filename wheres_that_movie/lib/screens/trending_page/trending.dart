import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tmdb_api/tmdb_api.dart';

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

  loadTrendingMovies() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text("Trending Movies"),
        Expanded(
            child: ListView.builder(
                itemCount: trendingMovies.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      //Image(image: NetworkImage())
                      Image.network(
                        'https://image.tmdb.org/t/p/w500' +
                            trendingMovies[index]['poster_path'],
                      ),
                      Text(trendingMovies[index]['title'] ??
                          trendingMovies[index]['name']),
                      Text(trendingMovies[index]['overview']),
                      Text("Rating:"),
                      Text(trendingMovies[index]['vote_average']
                          .toStringAsFixed(2)),
                    ]),
                  );
                })))
      ],
    ));
    //   TrendingMovies(
    //   movieTitles: trendingTitles,
    //   votes: voteAverageMovie,
    // ));
  }
}


// children: [
//                         Container(
//                           height: 200,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: NetworkImage(
//                                       'https://image.tmdb.org/t/p/w500' +
//                                           trendingMovies[index]
//                                               ['poster_path']))),
//                         ),
//                         Text(trendingMovies[index]["title"] ??
//                             trendingMovies[index]["name"])
//                       ],
