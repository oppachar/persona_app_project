import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/screens/face_analysis_results/face_analysis_results_screen.dart';
import 'package:persona/widgets/cards/card.dart';

class Body extends StatefulWidget {
  final User user;
  Body(this.user);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return widget.user == null
        ? Center(
            child: Text(
              "로그인 후 이용할 수 있어요🥺",
              style: kHeadlineTextStyle,
            ),
          )
        : StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Result")
                .doc(widget.user.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (!snapshot.data.exists)
                return Center(
                  child: Text(
                    "얼굴 인식 분석 결과가 없어요 🥺",
                    style: kHeadlineTextStyle,
                  ),
                );
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        InkWellCard(
                            circular: 30,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FaceAnanlysisScreen(widget.user))),
                            child: Container(
                              width: 300,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "result1",
                                    style: TextStyle(
                                        color: kActiveColor, fontSize: 16),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
