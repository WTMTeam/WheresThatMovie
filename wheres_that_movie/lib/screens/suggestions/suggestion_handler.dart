import 'package:wheres_that_movie/api/models/genre_model.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

// Create a function to return the nesessary data
// for displaying one or multiple movies
//
// This function takes in the variables from suggestions.dart
// when the user taps the suggestion button
//
//
class SuggestionsHandler {
  final List<Provider> providers;
  final List<Genre> genres;
  final int runningTime;
  final String movieOrShow;

  SuggestionsHandler({
    required this.providers,
    required this.genres,
    required this.runningTime,
    required this.movieOrShow,
  });

  String buildUrlString(dynamic urlVariable) {
    String urlString = "";
    return urlString;
  }

// url to be used?
//'$baseUrlPath/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=$region&with_genres=$genreIDs&with_watch_providers=$providers';

  SuggestionsHandler getSuggestion(List<Provider> providers, List<Genre> genres,
      int runningTime, String movieOrShow) {
    // Your function logic here
    return SuggestionsHandler(
        providers: providers,
        genres: genres,
        runningTime: runningTime,
        movieOrShow: movieOrShow);
  }
}
