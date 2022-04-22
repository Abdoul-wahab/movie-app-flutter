import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {

  final movies;
  final recentSearches = [
    "The Amazing Race",
    "The Last Ship",
    "Vikings",
    "Supernatural",
  ];

  CustomSearchDelegate(this.movies);


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();//DetailsScreen(movie: movie.isNotEmpty ? movie : null)
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? recentSearches.toList()
        : movies.where((movie) => movie['name'].toString().toLowerCase().contains(query) ).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        onTap: () {
          query = query.isEmpty ? suggestionList[index] : suggestionList[index]['name'];
          showResults(context);
          close(context, query);
        },
        leading: const Icon(Icons.menu_outlined),
        title: Text(query.isEmpty ? suggestionList[index] : suggestionList[index]['name'] ),
      ),
    );
  }
}
