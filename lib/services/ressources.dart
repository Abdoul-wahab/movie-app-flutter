import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class RessoucesService {

  Future<List?> getShwos() async {
    var url = Uri.https('api.tvmaze.com', '/shows');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as List;
        return jsonResponse;
      }

      print('Request failed with status: ${response.statusCode}.');
      return null;

    } catch (exception) {
      print(exception.toString());
      return null;
    }

  }
}