import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;

  PreviewScreen({this.imgPath});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Image.file(
          File(widget.imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
