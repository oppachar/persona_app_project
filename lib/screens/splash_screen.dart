import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persona/screens/signIn/sign_in_screen.dart';
import 'bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/Intro@3x.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
