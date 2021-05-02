import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/screens/camera/camera_screen.dart';
import 'package:persona/size_config.dart';
import 'package:persona/widgets/cards/card.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWellCard(
              circular: 30,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CameraScreen())),
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/style.svg",
                      width: 80,
                    ),
                    VerticalSpacing(
                      of: 50,
                    ),
                    Text(
                      "나와 어울리는 스타일은 무엇인지\n궁금하지 않으셨나요? \n페르소나가 찾아드립니다!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kActiveColor,
                          fontSize: 17,
                          height: 1.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
