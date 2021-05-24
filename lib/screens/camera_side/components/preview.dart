import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona/screens/loading/loading_screen.dart';
import 'package:persona/widgets/buttons/primary_button.dart';
import 'package:persona/widgets/buttons/secondary_button.dart';
import '../../../size_config.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final User user;
  PreviewScreen({this.imgPath, this.user});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          VerticalSpacing(
            of: 50,
          ),
          Container(
            width: 300,
            child: Image.file(
              File(widget.imgPath),
              fit: BoxFit.cover,
            ),
          ),
          VerticalSpacing(
            of: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: SecondaryButton(
                    text: "다른 사진으로 할래요", press: () => Navigator.pop(context)),
              ),
              HorizontalSpacing(),
              SizedBox(
                width: 150,
                child: PrimaryButton(
                    text: "이 사진으로 분석하기",
                    press: () {
                      _uploadFile(context).then((value) => FirebaseFirestore
                          .instance
                          .collection('result')
                          .doc(widget.user.email)
                          .update({'imageurl_side': value, 'flag': 1}));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoadingScreen(widget.user)));
                    }),
              ),
            ],
          ),
        ]));
  }

  Future<String> _uploadFile(BuildContext context) async {
    // storage 에 업로드 할 파일 경로
    final reference = FirebaseStorage.instance
        .ref()
        .child('Image')
        .child('${DateTime.now().millisecondsSinceEpoch}.png');
    // 파일 업로드
    await reference.putFile(File(widget.imgPath));
    // 파일 url 반환
    return await reference.getDownloadURL();
  }
}
