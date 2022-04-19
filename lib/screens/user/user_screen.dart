import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class UserScreen extends StatefulWidget {

  const UserScreen({Key? key}) : super(key: key);
  State<UserScreen> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);


    return  const Scaffold(
        body: Center(
          child: Text(
          "User Screen",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

