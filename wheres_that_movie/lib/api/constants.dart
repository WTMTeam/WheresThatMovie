//
//
//
//

class ApiEndPoint {
  late String getMovieSuggestions;
  late String getMovieGenresUrl;
  late String getTvShowGenresUrl;
  late String getMovieStreamingProviderInfo;
  late String getMovieStreamingProviderInfoRegion;
  late String getCountries;

  // * Genre Docs: https://developer.themoviedb.org/reference/genre-movie-list

  ApiEndPoint({int? id, List? suggestionsVariables}) {
    //Value added for simplicity but it is always better
    //  to add it in a configuration file
    String baseUrlPath = 'https://api.themoviedb.org/3';

    String region = "US";
    String genreIDs = "35|53"; // Use pipe | for "or".
    String providers = "8|9";

    getMovieSuggestions =
        '$baseUrlPath/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&watch_region=$region&with_genres=$genreIDs&with_watch_providers=$providers';

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