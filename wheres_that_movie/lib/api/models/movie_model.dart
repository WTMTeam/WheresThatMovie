import 'package:http/http.dart' as http;

class Movie {
  final int movieID;
  final List<int> genreIDs;
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
      movieID: json['movie_id'],
      genreIDs: json['genre_ids'],
      title: json['title'],
      overview: json['overview'],
      imageUrl: json['poster_path'],
      rating: json['vote_average'],
    );
  }
}
