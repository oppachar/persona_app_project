import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persona/constants.dart';
import 'package:persona/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'persona app',
        theme: ThemeData(
          primaryColor: kMainColor,
        ),
        home: SplashScreen());
  }
}
