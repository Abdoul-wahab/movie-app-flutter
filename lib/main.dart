import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/providers/theme_provider.dart';
import 'package:projet/routes.dart';
import 'package:projet/screens/auth/login_screen.dart';
import 'package:projet/screens/auth/register_screen.dart';
import 'package:projet/screens/splash_screen.dart';
import 'package:projet/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return StreamProvider<AppUser?>.value(
        value: AuthenticationService().user,
        initialData: null,
        child: MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/': (context) => const ScreenWrapper(),
          }
        ),
      );

    },
  );
}
