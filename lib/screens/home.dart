import 'package:flutter/material.dart';
import 'package:projet/components/drawer.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const CustomDrawer(),
        body: const Center(
          child: Text("Home page"),
        )
    );
  }
}
