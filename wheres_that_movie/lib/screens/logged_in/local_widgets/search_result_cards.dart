// search_result_cards.dart
// Author: Samuel Rudqvist
// Date Created: Unknown
//
// Purpose:
//    This Class creates the card for the carousel on the logged in screen
// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//    (03/07/2023)(SR): Changed deprecated headlines
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../detailed_page/detailed.dart';

class SearchCarouselCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String overview;
  final double rating;
  final bool isMovie;

  final int id;

  const SearchCarouselCard({
    Key? key,
    required this.id,
    required this.imgUrl,
    required this.title,
    required this.overview,
    required this.rating,
    required this.isMovie,
  }) : super(key: key);

  Widget myRatingBar() {
    return RatingBar(
      onRatingUpdate: (value) => rating,
      initialRating: rating / 2,
      itemCount: 5,
      allowHalfRating: true,
      itemSize: 25.0,
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
    double textHeight =
        Theme.of(context).textTheme.displaySmall!.fontSize! * 1.5;
// Calculate the height of the Text widget based on the number of lines of text
    if (title != null && title.contains('\n')) {
      // If the title has multiple lines, multiply the text height by the number of lines
      textHeight *= (title.split('\n').length + 1);
    }
    // print("textHeight $textHeight");
    double imageHeight = 300;
    double totalHeight = (textHeight + imageHeight + 10) * 1.25;

    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Future.delayed(const Duration(milliseconds: 450), () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DetailedPage(
          //       id: id,
          //       isMovie: isMovie,
          //     ),
          //   ),
          // );
          Get.to(() => DetailedPage(id: id, isMovie: isMovie),
              transition: Transition.zoom);
        });
      },
      child: Container(
        height: totalHeight,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 4),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Standard card color
              Theme.of(context).cardColor,
              Theme.of(context).cardColor,
            ],
          ),
          shadows: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              spreadRadius: -2,
              // you can animate the radius to make the feeling of cards
              // 'coming closer to you' stronger
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 12),
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall),
                ),
              ),
            ),
            // const SizedBox(height: 12),
            // const Spacer(),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 300,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    errorWidget: (context, imgUrl, error) => Container(
                      height: 300,
                      child:
                          const Icon(Icons.no_photography_outlined, size: 200),
                    ),
                  ),
                ),
              ),
            ),

            // const SizedBox(height: 12),
            // const Spacer(),

            // myRatingBar(),
            // Row(
            //   children: [
            //     Flexible(flex: 1, child: Container()),
            //     Flexible(flex: 2, child: Center(child: myRatingBar())),
            //     Flexible(flex: 1, child: Container()),
            //   ],
            // ),
            Expanded(
              child: Center(
                child: myRatingBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
