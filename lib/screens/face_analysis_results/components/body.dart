import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/size_config.dart';

class Body extends StatelessWidget {
  final User user;
  Body(this.user);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName + "님의 얼굴분석 👩🏻",
              style: kHeadlineTextStyle,
              textScaleFactor: 1,
            ),
            VerticalSpacing(of: 150),
            Text(
              "이런 헤어스타일을 추천해드려요 💇🏻‍♀️",
              style: kHeadlineTextStyle,
              textScaleFactor: 1,
            ),
            VerticalSpacing(of: 150),
            Text(
              "이런 메이크업을 추천해드려요 💄",
              style: kHeadlineTextStyle,
              textScaleFactor: 1,
            ),
            VerticalSpacing(of: 150),
            Text(
              user.displayName + "님과 비슷한 특징을 가진 연예인 ",
              style: kHeadlineTextStyle,
              textScaleFactor: 1,
            ),
            VerticalSpacing(of: 150),
          ],
        ),
      ),
    );
  }
}
