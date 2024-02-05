//
//
//
//

import 'package:wheres_that_movie/api/models/genre_model.dart';
import 'package:wheres_that_movie/api/models/provider_model.dart';

class ApiEndPoint {
  late String getMovieSuggestions;
  late String getMovieGenresUrl;
  late String getTvShowGenresUrl;
  late String getMovieStreamingProviderInfo;
  late String getMovieStreamingProviderInfoRegion;
  late String getCountries;

  // * Genre Docs: https://developer.themoviedb.org/reference/genre-movie-list

  ApiEndPoint(
      {int? id,
      String? providerIDs,
      String? genreIDs,
      int? runtime,
      bool? runtimeLessThan,
      String? region}) {
    //Value added for simplicity but it is always better
    //  to add it in a configuration file
    String baseUrlPath = 'https://api.themoviedb.org/3';
    region ??= "US";
    genreIDs ??= ""; // Use pipe | for "or".
    //genreIDs ??= "35|53"; // Use pipe | for "or".
    providerIDs ??= "";
    //runtime ??= 300;
    //providerIDs ??= "8|9";
    getMovieSuggestions =
        '$baseUrlPath/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=$region&with_genres=$genreIDs&with_watch_providers=$providerIDs';

    if (runtime != null) {
      getMovieSuggestions += '&with_runtime.lte=$runtime';
    }
    print("URL: $getMovieSuggestions");
    // getMovieSuggestions =
    // '$baseUrlPath/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=$region&with_genres=$genreIDs&with_watch_providers=$providerIDs';

    // discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=US&with_genres=35&with_watch_providers=8

    // Get the list of genres for movies or shows
    getMovieGenresUrl = '$baseUrlPath/genre/movie/list?language=en';
    getTvShowGenresUrl = '$baseUrlPath/genre/tv/list?language=en';

    // Get the streaming provider information for movies
    getMovieStreamingProviderInfo =
        '$baseUrlPath/watch/providers/movie?language=en-US';
    getMovieStreamingProviderInfoRegion =
        '$baseUrlPath/watch/providers/movie?language=en-US&watch_region=US';

    // Get the Countries used in TMDB
    getCountries = '$baseUrlPath/configuration/countries?language=en-US';
  }
}

// * Use like this
// Future<List<Film>> getAllFilms() async {
//   var response = await http.get(
//     Uri.parse(ApiEndPoint().FILM_ALL),
//   );
// // ...
// }

// Future<Film> getSingleFilm(int idFilm) async {
//   var response = await http.get(
//     Uri.parse(ApiEndPoint(id: idFilm).FILM_SINGLE),
//   );
//   //...
// }
