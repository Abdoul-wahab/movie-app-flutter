import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'backdrop_rating.dart';
import 'genres.dart';
import 'title_duration_and_fav_btn.dart';
import 'package:html/parser.dart';

class Body extends StatelessWidget {
  final movie;
  const Body({Key? key, this.movie}) : super(key: key);

  String _parseHtmlString(String htmlString) {
    final doc = parse(htmlString);

    if(doc.documentElement != null){
      String parsedString = doc.documentElement!.text;
      return parsedString;
    }
    return htmlString;
  }



  @override
  Widget build(BuildContext context) {
    // it will provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackdropAndRating(size: size, movie: movie),
          const SizedBox(height: kDefaultPadding / 2),
          TitleDurationAndFabBtn(movie: movie),
          Genres(movie: movie),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              "Plot Summary",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              _parseHtmlString(movie['summary']),
              style: const TextStyle(
                color: Color(0xFF737599),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
