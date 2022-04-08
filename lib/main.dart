import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/routes.dart';
import 'package:projet/screens/auth/login.dart';
import 'package:projet/screens/auth/register.dart';
import 'package:projet/screens/home.dart';
import 'package:projet/screens/movies/movies.dart';
import 'package:projet/screens/screen_wrapper.dart';
import 'package:projet/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDgqic7EY9KQrs4jO_PGFgnOzCTXRSNLSw",
        authDomain: "projet-flutter-838f7.firebaseapp.com",
        projectId: "projet-flutter-838f7",
        storageBucket: "projet-flutter-838f7.appspot.com",
        messagingSenderId: "923240763584",
        appId: "1:923240763584:web:ad65ffea0e6b39b2625d25"
    ),
  );
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/': (context) => const ScreenWrapper(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
