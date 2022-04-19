import 'package:flutter/material.dart';
import 'package:projet/components/genre_card.dart';
import 'package:projet/constants.dart';



class Genres extends StatelessWidget {
  const Genres({
    Key? key,
    @required this.movie,
  }) : super(key: key);

  final movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie['genres'].length,
          itemBuilder: (context, index) => GenreCard(
            genre: movie['genres'][index],
          ),
        ),
      ),
    );
  }
}
