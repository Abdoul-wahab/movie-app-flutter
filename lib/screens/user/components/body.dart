import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/authentication.dart';
import '../../../services/database.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _auth = AuthenticationService();
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    final database = DatabaseService(currentUser.uid);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: StreamBuilder<UserData>(
        stream: database.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            if (userData == null) return Container();
            return Column(
              children: [
                const ProfilePic(),
                const SizedBox(height: 20),
                ProfileMenu(
                  text: "${userData.firstname} ${userData.lastname}",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {},
                  arrowIcon: Container(),
                ),
                ProfileMenu(
                  text: "${userData.city}",
                  icon: "assets/icons/Location point.svg",
                  press: () {},
                  arrowIcon: Container(),
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {},
                  arrowIcon: const Icon(Icons.arrow_forward_ios)
                ),
                ProfileMenu(
                  text: "Help Center",
                  icon: "assets/icons/Question mark.svg",
                  press: () {},
                  arrowIcon: const Icon(Icons.arrow_forward_ios)
                ),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    await _auth.signOut();
                  },
                  arrowIcon: const Icon(Icons.arrow_forward_ios)
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
