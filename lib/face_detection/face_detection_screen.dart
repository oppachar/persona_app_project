import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision_raw_bytes/firebase_ml_vision_raw_bytes.dart';

class FaceDetectionScreen extends StatefulWidget {
  final User user;
  FaceDetectionScreen(this.user);
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  File _imageFile;
  List<Face> _faces;

  //fetching the images from the gallery and processing the image
  void _getImageAndDetectFaces() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        enableClassification: true, //smile probability classification
        mode: FaceDetectorMode.accurate,
        enableLandmarks: true,
      ),
    );
    final faces = await faceDetector.processImage(image);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _imageFile == null
          ? NoImage()
          : SimpleImageAndFaces(imageFilePath: _imageFile, faces: _faces),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageAndDetectFaces,
        tooltip: 'Pick an image',
        backgroundColor: Colors.teal[700],
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

class NoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Please Select an Image',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class SimpleImageAndFaces extends StatelessWidget {
  SimpleImageAndFaces({@required this.imageFilePath, @required this.faces});

  final File imageFilePath;
  final List<Face> faces;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
        flex: 2,
        child: Container(
            constraints: BoxConstraints.expand(),
            child: Image.file(
              imageFilePath,
              fit: BoxFit.cover,
            )),
      ),
      Flexible(
        flex: 1,
        child: ListView(
          children: faces.map<Widget>((f) => FaceCoordinates(f)).toList(),
        ),
      ),
    ]);
  }
}

class FaceCoordinates extends StatelessWidget {
  FaceCoordinates(this.face);

  final Face face;

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;
    return ListTile(
      title: Text(
          '(T:${pos.top}, L:${pos.left}), (B:${pos.bottom}, R:${pos.right})'),
      subtitle: Text('Probability of smiling: ${face.smilingProbability}'),
    );
  }
}
