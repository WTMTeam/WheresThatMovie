import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wheres_that_movie/api/constants.dart';

class Movie {
  final int movieID;
  final List<dynamic> genreIDs;
  final String title;
  final String overview;
  final String imageUrl;
  final double rating;

  const Movie({
    required this.movieID,
    required this.genreIDs,
    required this.title,
    required this.overview,
    required this.imageUrl,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieID: json['id'],
      genreIDs: json['genre_ids'],
      title: json['title'],
      overview: json['overview'],
      imageUrl: json['poster_path'],
      rating: json['vote_average'],
    );
  }
}

class MovieService {
  // Todo:
  // - Sort based on something
  // - Accept and send on provider data, genre data osv.
  // - is there additional data we want to grab?
  Future<List<Movie>> getMovieSuggestions() async {
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY',
    };
    var response = await http.get(Uri.parse(ApiEndPoint().getMovieSuggestions),
        headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List<Movie> movieList = [];

      for (var i = 0; i < data['results'].length; i++) {
        final entry = data['results'][i];
        try {
          movieList.add(Movie.fromJson(entry));
        } catch (e) {
          print("Exception: $e");
        }
      }
      for (Movie movie in movieList) {
      print(movie.title);
    }
      return movieList;
    } else {
      throw Exception('HTTP FAILED with status code: ${response.statusCode}');
    }
  }
}
