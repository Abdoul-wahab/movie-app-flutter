import 'package:flutter/material.dart';
import 'package:projet/screens/auth/login_screen.dart';
import 'package:projet/screens/home/home_screen.dart';
import 'package:projet/screens/user/user_screen.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ScreenWrapper extends StatefulWidget {

  const ScreenWrapper({Key? key}) : super(key: key);
  State<ScreenWrapper> createState() => _ScreenWrapper();
}

class _ScreenWrapper extends State<ScreenWrapper> {

  int index = 0;

  List<Widget> list = [
    const HomeScreen(),
    const UserScreen(),
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
            });
          },
          selectedItemColor: Colors.black87,
          iconSize: 40,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Movies'),
          ],
        ),
      );
    }
  }

}