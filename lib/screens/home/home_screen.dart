import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/size_config.dart';
import 'package:persona/widgets/buttons/primary_button.dart';
import 'package:persona/widgets/cards/card.dart';

class HomeScreen extends StatelessWidget {
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
              onTap: () {},
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "?-?",
                      style: TextStyle(
                          color: kActiveColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    VerticalSpacing(
                      of: 30,
                    ),
                    Text(
                      "나와 어울리는 스타일은 무엇인지\n궁금하지 않으셨나요? \n페르소나가 찾아드립니다!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kActiveColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
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
