import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';

class ResultScreen extends StatelessWidget {
  final User user;
  ResultScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kMainColor,
        child: Center(child: Text("result")),
      ),
    );
  }
}
