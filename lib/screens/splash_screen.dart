import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projet/screens/auth/login_screen.dart';
import 'package:projet/screens/home/home_screen.dart';
import 'package:projet/screens/user/user_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
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
        bottomNavigationBar: buildBottomNavBar(context),
      );
    }
  }

  Container buildBottomNavBar(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: index == 0
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: index == 1
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
              ),
            ],
          )),
    );
  }

}