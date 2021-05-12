import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persona/screens/loading/loading_screen.dart';
import 'package:persona/widgets/buttons/primary_button.dart';
import 'package:persona/widgets/buttons/secondary_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final User user;
  Body(this.user);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _image == null
            ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                VerticalSpacing(
                  of: 200,
                ),
                Text(
                  "촬영 전 주의사항 📸",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kActiveColor,
                      fontSize: 19,
                      height: 2.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '''

      ✔️ 페이스라인에 맞춰서 촬영해주세요
      ✔️ 앞머리, 마스크 등 얼굴을 가리지 말아주세요
      ✔️ 어두운 곳에서 촬영을 피해주세요
''',
                  style: TextStyle(
                      color: kActiveColor,
                      fontSize: 17,
                      height: 2.0,
                      fontWeight: FontWeight.w600),
                ),
                VerticalSpacing(
                  of: 30,
                ),
                SizedBox(
                    width: 200,
                    child:
                        PrimaryButton(text: "사진 찍기", press: () => getImage()))
              ])
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.file(_image),
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
                          text: "다른 사진으로 할래요", press: () => getImage()),
                    ),
                    HorizontalSpacing(),
                    SizedBox(
                      width: 150,
                      child: PrimaryButton(
                          text: "이 사진으로 분석하기",
                          press: () {
                            _uploadFile(context).then((value) =>
                                FirebaseFirestore.instance
                                    .collection('Photo')
                                    .doc(widget.user.email)
                                    .set({'imageurl': value}));
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
    await reference.putFile(_image);
    // 파일 url 반환
    return await reference.getDownloadURL();
  }
}
