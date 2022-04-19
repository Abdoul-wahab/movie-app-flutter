import 'package:flutter/material.dart';
import 'package:projet/screens/auth/login_screen.dart';
import 'package:projet/screens/auth/register_screen.dart';
import 'package:projet/screens/home/home_screen.dart';
import 'package:projet/screens/user/user_screen.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/': (context) => const HomeScreen(),
  '/movies': (context) => UserScreen(),
  '/other': (context) => Scaffold(
    appBar: AppBar(),
  ),
};
