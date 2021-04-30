import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';

class MypageScreen extends StatelessWidget {
  final User user;
  MypageScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kMainColor,
        child: Center(child: Text("mypage")),
      ),
    );
  }
}
