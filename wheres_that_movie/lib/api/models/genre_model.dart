import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wheres_that_movie/api/constants.dart';

class Genre {
  final int genreID;
  final String genreName;

  const Genre({
    required this.genreID,
    required this.genreName,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreID: json['id'],
      genreName: json['name'],
    );
  }
}

class GenreService {
  Future<List<Genre>> getGenres() async {
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYmZmYTBkMTZmYjhkYzI4NzM1MzExNTZhNWM1ZjQxYSIsInN1YiI6IjYzODYzNzE0MDM5OGFiMDBjODM5MTJkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qQjwnSQLDfVNAuinpsM-ATK400-dnwuWUVirc7_AiQY',
    };
    var response = await http.get(Uri.parse(ApiEndPoint().getMovieGenresUrl),
        headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List<Genre> genreList = [];

      for (var i = 0; i < data['genres'].length; i++) {
        final entry = data['genres'][i];
        genreList.add(Genre.fromJson(entry));
      }
      return genreList;
    } else {
      throw Exception(
          'HTTP FAILED getting genres with status code: ${response.statusCode}');
    }
  }
}
