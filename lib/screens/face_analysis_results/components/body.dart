import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/screens/face_analysis_results/components/hair.dart';
import 'package:persona/screens/face_analysis_results/components/makeup.dart';
import 'package:persona/size_config.dart';

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
                DocumentSnapshot data = snapshot.data;
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
                            // CachedNetworkImage(
                            //   imageUrl: data['test'],
                            //   placeholder: (context, url) =>
                            //       CircularProgressIndicator(),
                            //   errorWidget: (context, url, error) =>
                            //       Icon(Icons.error),
                            // ),
                            // VerticalSpacing(),
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
                                    .doc(
                                        snapshot.data['cheek_front'].toString())
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
                                    .doc(
                                        snapshot.data['eyeh_result'].toString())
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return Text(
                                    "# " +
                                        snapshot.data['title'] +
                                        " (" +
                                        data['eyeh_percent'].toString() +
                                        "%)",
                                    style: kSecondaryTextStyle,
                                  );
                                }),
                            VerticalSpacing(),
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("eyew")
                                    .doc(
                                        snapshot.data['eyew_result'].toString())
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator();
                                  return Text(
                                    "# " +
                                        snapshot.data['title'] +
                                        " (" +
                                        data['eyew_percent'].toString() +
                                        "%)",
                                    style: kSecondaryTextStyle,
                                  );
                                }),
                            VerticalSpacing(),
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("eyeshape")
                                    .doc(snapshot.data['eyeshape_result']
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
                            if (snapshot.data['nose_result'] == 1)
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("nose")
                                      .doc(snapshot.data['nose_result']
                                          .toString())
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return Text(
                                      "# " +
                                          snapshot.data['title'] +
                                          " (" +
                                          data['nose_percent'].toString() +
                                          "%)",
                                      style: kSecondaryTextStyle,
                                    );
                                  }),
                            VerticalSpacing(),
                            if (snapshot.data['between_result'] != 0)
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("between")
                                      .doc(snapshot.data['between_result']
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
                            if (snapshot.data['shorteye_index'] == 1)
                              StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("shorteye")
                                      .doc(snapshot.data['shorteye_index']
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
                          ]),
                      VerticalSpacing(of: 30),
                      HairStyle(snapshot.data),
                      MakeupStyle(snapshot.data),
                      Center(
                        child: Text(
                          "오랫동안 나를 봐왔던 나에게 신경 쓰이는 \n특징들만 커버해도 충분히 큰 변화가 될 거에요 😁 \n스타일링에는 법칙은 있지만 정답은 없습니다!",
                          style: kHeadlineTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      VerticalSpacing(of: 30),
                      // PrimaryButton(
                      //     text: "홈으로 돌아가기",
                      //     press: () => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomeScreen(user))))
                    ]);
              }),
        ),
      ),
    );
  }
}
