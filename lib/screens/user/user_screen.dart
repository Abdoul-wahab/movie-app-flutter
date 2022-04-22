import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'components/body.dart';

class UserScreen extends StatefulWidget {

  const UserScreen({Key? key}) : super(key: key);
  State<UserScreen> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: Body(),
    );
  }
}

