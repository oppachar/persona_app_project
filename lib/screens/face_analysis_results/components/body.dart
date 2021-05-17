import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http; //Http 프로토콜을 이용하기 위한 패키지
import 'dart:async'; //async / await 지원. 선언하지 않아도 이용가능
import 'dart:convert'; //JSON 데이터 처리 지원

class Body extends StatelessWidget {
  final User user;
  Body(this.user);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("result")
                .doc(user.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName + "님의 얼굴분석 👩🏻",
                    style: kHeadlineTextStyle,
                    textScaleFactor: 1,
                  ),
                  VerticalSpacing(of: 20),
                  CachedNetworkImage(
                    imageUrl: snapshot.data['imageurl'],
                    width: 100,
                  ),
                  VerticalSpacing(of: 50),
                  Text(
                    "이런 헤어스타일을 추천해드려요 💇🏻‍♀️",
                    style: kHeadlineTextStyle,
                    textScaleFactor: 1,
                  ),
                  Text(snapshot.data['hair']),
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
              );
            }),
      ),
    );
  }
}
