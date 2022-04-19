import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MoviesScreen extends StatefulWidget {

  const MoviesScreen({Key? key}) : super(key: key);
  State<MoviesScreen> createState() => _MoviesScreen();
}

class _MoviesScreen extends State<MoviesScreen> {

  var _request = [];

  var url = Uri.https('api.tvmaze.com', '/shows');

  void getAllShwos() async {
    var url = Uri.https('api.tvmaze.com', '/shows');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as List;
        setState(() {
          _request = jsonResponse;
        });
      }
      print('Request failed with status: ${response.statusCode}.');
    } catch (exception) {
      print(exception.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    getAllShwos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemCount: _request.length,
            itemBuilder: (context, index) {
              final item = _request[index];
              return Card(
                  child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(item['summary']),
                  )
              );
            })
    );
  }
}

