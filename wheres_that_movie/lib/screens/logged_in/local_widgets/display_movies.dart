// display_movies.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DisplayMovies extends StatelessWidget {
  final List<dynamic> movieList;
  // const DisplayMovies({super.key, required this.movieList});

  const DisplayMovies({Key? key, required this.movieList}) : super(key: key);

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //     color: Colors.black, borderRadius: BorderRadius.circular(10.0),
        //     border: ),
        child: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            movieList.isEmpty
                ? const Text(
                    "empty",
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: movieList.length,
                    itemBuilder: ((context, index) {
                      String myUrl = "";
                      if (movieList[index][movieList[index].length - 1] ==
                          null) {
                        // do nothing
                      } else {
                        myUrl = 'https://image.tmdb.org/t/p/w200' +
                            movieList[index][movieList[index].length - 1];
                      }

                      return Card(
                        elevation: 5.0,
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(children: [
                              CachedNetworkImage(
                                imageUrl: myUrl,
                                placeholder: _loader,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Text(movieList[index][1].toString()),
                            ])),
                      );
                    }))
          ],
        )
      ],
    ));
  }
}
