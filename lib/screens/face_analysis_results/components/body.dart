import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/size_config.dart';
import 'package:persona/widgets/cards/card.dart';

class Body extends StatelessWidget {
  final User user;
  Body(this.user);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("faceline")
                                  .doc(snapshot.data['faceline_index']
                                      .toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("ratio")
                                  .doc(snapshot.data['ratio'].toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("cheek_side")
                                  .doc(snapshot.data['cheek_side'].toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("cheek_front")
                                  .doc(snapshot.data['cheek_front'].toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("eyeh")
                                  .doc(snapshot.data['eyeh_result'].toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("eyew")
                                  .doc(snapshot.data['eyew_result'].toString())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return CircularProgressIndicator();
                                return Text(
                                  "# " + snapshot.data['title'],
                                  style: kSecondaryTextStyle,
                                );
                              }),
                          VerticalSpacing(),
                          if (snapshot.data['nose_result'] == 1)
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("nose")
                                    .doc(
                                        snapshot.data['nose_result'].toString())
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return Text(
                                    "# " + snapshot.data['title'],
                                    style: kSecondaryTextStyle,
                                  );
                                }),
                          VerticalSpacing(),
                        ]),
                    VerticalSpacing(of: 30),
                    Text(
                      "이런 헤어스타일을 추천해드려요 💇🏻‍♀️",
                      style: kHeadlineTextStyle,
                      textScaleFactor: 1,
                    ),
                    VerticalSpacing(of: 10),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("faceline")
                            .doc(snapshot.data['faceline_index'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + "에게 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Best : " + snapshot.data['best'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                  Text(
                                    "Worst : " + snapshot.data['worst'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("ratio")
                            .doc(snapshot.data['ratio'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + " 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(of: 10),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("cheek_side")
                            .doc(snapshot.data['cheek_side'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + " 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(of: 10),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("cheek_front")
                            .doc(snapshot.data['cheek_front'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + " 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(of: 10),
                    VerticalSpacing(of: 30),
                    Text(
                      "이런 메이크업을 추천해드려요 💄",
                      style: kHeadlineTextStyle,
                      textScaleFactor: 1,
                    ),
                    VerticalSpacing(of: 10),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("eyeh")
                            .doc(snapshot.data['eyeh_result'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + " 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(of: 10),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("eyew")
                            .doc(snapshot.data['eyew_result'].toString())
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return InkWellCard(
                            onTap: () {},
                            circular: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data['title'] + " 추천해요!",
                                    style: kHeadlineTextStyle,
                                  ),
                                  VerticalSpacing(of: 20),
                                  Text(
                                    "Comment : " + snapshot.data['comment'],
                                    style: kBodyTextStyle,
                                  ),
                                  VerticalSpacing(),
                                ],
                              ),
                            ),
                          );
                        }),
                    VerticalSpacing(of: 10),
                    if (snapshot.data['nose_result'] == 1)
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("nose")
                              .doc(snapshot.data['nose_result'].toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return InkWellCard(
                              onTap: () {},
                              circular: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data['title'] + " 추천해요!",
                                      style: kHeadlineTextStyle,
                                    ),
                                    VerticalSpacing(of: 20),
                                    Text(
                                      "Comment : " + snapshot.data['comment'],
                                      style: kBodyTextStyle,
                                    ),
                                    VerticalSpacing(),
                                  ],
                                ),
                              ),
                            );
                          }),
                    VerticalSpacing(of: 30),
                    Center(
                      child: Text(
                        "오랫동안 나를 봐왔던 나에게 신경 쓰이는 \n특징들만 커버해도 충분히 큰 변화가 될 거에요 😁 \n스타일링에는 법칙은 있지만 정답은 없습니다!",
                        style: kHeadlineTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    VerticalSpacing(of: 30),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
