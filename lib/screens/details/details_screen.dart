import 'package:flutter/material.dart';

import 'components/body.dart';


class DetailsScreen extends StatelessWidget {

  final movie;

  const DetailsScreen({ Key? key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(movie: movie),
    );
  }
}
