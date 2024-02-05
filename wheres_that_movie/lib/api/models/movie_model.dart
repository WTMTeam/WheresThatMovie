import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheres_that_movie/api/constants.dart';
import 'package:wheres_that_movie/api/models/genre_model.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class Movie {
  final int movieID;
  final List<dynamic> genreIDs;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final num rating;

  const Movie({
    required this.movieID,
    required this.genreIDs,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieID: json['id'],
      genreIDs: json['genre_ids'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
    );
  }
}

class MovieService {
  // Todo:
  // - Sort based on something
  // - Accept and send on provider data, genre data osv.
  // - is there additional data we want to grab?
  Future<List<Movie>> getMovieSuggestions(
      {List<Provider>? providers,
      List<Genre>? genres,
      String? region,
      int? runtime, // runtime in minutes
      bool? runtimeLessThan}) async {
    String providerIDs = "";
    String genreIDs = "";

    // Concatenate Provider IDs
    if (providers != null && providers.isNotEmpty) {
      for (Provider provider in providers) {
        providerIDs += "${provider.providerID}|";
      }

      // Remove the trailing "|"
      providerIDs = providerIDs.substring(0, providerIDs.length - 1);
    }
    //print("Provider IDs: $providerIDs");
    // Concatenate Genre IDs
    if (genres != null && genres.isNotEmpty) {
      for (Genre genre in genres) {
        genreIDs += "${genre.genreID}|";
      }

      // Remove the trailing "|"
      genreIDs = genreIDs.substring(0, genreIDs.length - 1);
    }

    runtime ??= 999;

    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY',
    };
    var response = await http.get(
        Uri.parse(ApiEndPoint(
          providerIDs: providerIDs,
          genreIDs: genreIDs,
          region: region,
          runtime: runtime,
        ).getMovieSuggestions),
        headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print("Data: $data");
      final List<Movie> movieList = [];

      //for (var i = 0; i < data['results'].length; i++) {
      for (var i = 0; i < 11; i++) {
        final entry = data['results'][i];
        try {
          movieList.add(Movie.fromJson(entry));
        } catch (e) {
          print("Exception: $e");
        }
      }
      // for (Movie movie in movieList) {
      //   print("${movie.movieID}, ${movie.title}");
      // }
      return movieList;
    } else {
      throw Exception('HTTP FAILED with status code: ${response.statusCode}');
    }
  }
}
