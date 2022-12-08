import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:streaming_service_lister/widgets/my_container.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies(
      {Key? key, required this.movieTitles, required this.votes})
      : super(key: key);
  final List movieTitles;
  final List votes;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(children: <Widget>[
        movieTitles.isEmpty
            ? Text(
                "There should have been movie titles here",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 8.0,
                ),
                child: Text(
                  "Trending Movies",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: movieTitles.length,
          // Build each item of the list
          itemBuilder: ((context, index) {
            return ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: 0.0),
                title: Text(
                  movieTitles[index],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  votes[index].toStringAsFixed(2),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ));
          }),
        ),
      ]),
    );
  }
}
