import 'package:flutter/material.dart';
import 'package:projet/screens/auth/login.dart';
import 'package:projet/screens/auth/register.dart';
import 'package:projet/screens/home.dart';
import 'package:projet/screens/movies/movies.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/': (context) => const MyHomePage(),
  '/movies': (context) => MoviesScreen(),
  '/other': (context) => Scaffold(
    appBar: AppBar(),
  ),
};
