// trending_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CarouselCard extends StatelessWidget {
  // final IconData icon;
  // final String label;
  final String imgUrl;
  final String title;
  final String overview;
  final double rating;
  final bool isHorizontal;

  const CarouselCard({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.overview,
    required this.rating,
    required this.isHorizontal,
  }) : super(key: key);

  Widget myRatingBar() {
    return RatingBar(
      onRatingUpdate: (value) => rating,
      initialRating: rating,
      itemCount: 10,
      allowHalfRating: true,
      itemSize: 30.0,
      ratingWidget: RatingWidget(
          full: const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          half: const Icon(
            Icons.star_half,
            color: Colors.amber,
          ),
          empty: const Icon(
            Icons.star_outline,
          )),
      ignoreGestures: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("");
    print("");
    print(isHorizontal);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (!isHorizontal) {
      return Container(
        // width: screenWidth - 90.0,
        // height: screenHeight - 1.0,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 4),
            // side: const BorderSide(color: Colors.red, width: 4),
            // side: const BorderSide(color: Colors.white, width: 4),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Colors.red.shade900,
              // Colors.red.shade500,

              // Standard card color
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,

              // Black with slightly lighter middle
              // Colors.black,
              // Theme.of(context).cardColor,
              // Colors.black,
            ],
          ),
          shadows: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              // color: Colors.red.withOpacity(0.5),
              // color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              // you can animate the radius to make the feeling of cards
              // 'coming closer to you' stronger
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
        // child: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(icon, color: Colors.white, size: 48),
            // SizedBox(
            //   width: 100.0,
            //   child: Text(title, style: Theme.of(context).textTheme.headline3),
            // ),

            Text(title, style: Theme.of(context).textTheme.headline3),

            const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: imgUrl,
              width: screenWidth - 122,
              // height: BoxFit
              // fit: BoxFit.scaleDown,
            ),
            // LayoutBuilder(
            //   builder: (BuildContext context, BoxConstraints constraints) {
            //     double scaleFactor = constraints.biggest.width / 500;
            //     return Transform.scale(
            //       scale: scaleFactor,
            //       child: CachedNetworkImage(
            //         imageUrl: imgUrl,
            //       ),
            //     );
            //   },
            // ),
            // LayoutBuilder(
            //   builder: (BuildContext context, BoxConstraints constraints) {
            //     double scaleFactor = constraints.biggest.width / 500;
            //     return Transform.scale(
            //       scale: scaleFactor,
            //       child: CachedNetworkImage(
            //         imageUrl: imgUrl,
            //         // width: double.infinity,
            //         // height: BoxFit
            //         // fit: BoxFit.contain,
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 12),
            // SizedBox(
            //   width: 100.0,
            //   child: Text(
            //     overview,
            //     style: Theme.of(context).textTheme.bodyLarge,
            //   ),
            // ),
            // Text(
            //   overview,
            //   style: Theme.of(context).textTheme.bodyLarge,
            // ),
            // const SizedBox(height: 12),
            myRatingBar(),

            // Text(rating.toStringAsFixed(2)),
          ],
        ),
        // )
      );
    } else {
      return Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 4),
            // side: const BorderSide(color: Colors.red, width: 4),
            // side: const BorderSide(color: Colors.white, width: 4),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Colors.red.shade900,
              // Colors.red.shade500,

              // Standard card color
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,

              // Black with slightly lighter middle
              // Colors.black,
              // Theme.of(context).cardColor,
              // Colors.black,
            ],
          ),
          shadows: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              // color: Colors.red.withOpacity(0.5),
              // color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              // you can animate the radius to make the feeling of cards
              // 'coming closer to you' stronger
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        // child: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon(icon, color: Colors.white, size: 48),
            // SizedBox(
            //   width: 100.0,
            //   child: Text(title, style: Theme.of(context).textTheme.headline3),
            // ),

            Text(title, style: Theme.of(context).textTheme.headline3),

            const SizedBox(height: 12),
            CachedNetworkImage(
              imageUrl: imgUrl,
            ),

            const SizedBox(height: 12),
            // SizedBox(
            //   width: 100.0,
            //   child: Text(
            //     overview,
            //     style: Theme.of(context).textTheme.bodyLarge,
            //   ),
            // ),
            // Text(
            //   overview,
            //   style: Theme.of(context).textTheme.bodyLarge,
            // ),
            // const SizedBox(height: 12),
            myRatingBar(),

            // Text(rating.toStringAsFixed(2)),
          ],
        ),
        // )
      );
    }
  }
}

// Text(
//                           trendingMovies[index]['overview'],
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),

//                         Text(
//                           "Rating:",
//                           style: Theme.of(context).textTheme.headline3,
//                         ),
//                         Text(trendingMovies[index]['vote_average']
//                             .toStringAsFixed(2)),
//                       ]),
