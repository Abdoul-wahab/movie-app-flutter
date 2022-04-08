import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projet/screens/auth/login.dart';
import 'package:projet/screens/home.dart';
import 'package:projet/screens/movies/movies.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ScreenWrapper extends StatefulWidget {

  const ScreenWrapper({Key? key}) : super(key: key);
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {

  int index = 0;

  List<Widget> list = [
    const MyHomePage(),
    const MoviesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);


    if (user == null) {
      return const LoginScreen();
    } else {
      return Scaffold(
        //drawer: const CustomDrawer(),
        body: list[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int i) {
            setState(() {
              index = i;
              log('index: $index');
            });
          },
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          iconSize: 48,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Movies'),
          ],
        ),
      );
    }
  }

}