import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persona/constants.dart';

import 'components/body.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kActiveColor,
            ),
            color: kActiveColor,
            onPressed: () => Navigator.pop(context)),
        title: Text(
          '사진 선택',
          style: TextStyle(color: kActiveColor),
        ),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kActiveColor,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(
          Icons.add_a_photo,
        ),
      ),
    );
  }
}
