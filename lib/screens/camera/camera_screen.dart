import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:persona/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:persona/screens/loading/loading_screen.dart';
import 'package:persona/size_config.dart';
import 'package:persona/widgets/buttons/primary_button.dart';
import 'package:persona/widgets/buttons/secondary_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'components/preview.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final User user;
  CameraScreen(this.user);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imgPath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      } else {
        print('No camera available');
      }
    }).catchError((err) {
      print('Error :${err.code}Error message : ${err.message}');
    });
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "촬영",
          style: kHeadlineTextStyle,
        ),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kActiveColor,
            ),
            color: kActiveColor,
            onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _cameraPreviewWidget(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _cameraToggleRowWidget(),
                    _cameraControlWidget(context),
                    Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return ClipRect(
        child: OverflowBox(
      alignment: Alignment.center,
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight - 150,
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(fit: StackFit.expand, children: [
                  CameraPreview(controller),
                  cameraOverlay(
                      padding: 20, aspectRatio: 1, color: Color(0x55000000))
                ])),
          )),
    ));
  }

  Widget cameraOverlay({double padding, double aspectRatio, Color color}) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;

      if (parentAspectRatio < aspectRatio) {
        horizontalPadding = padding;
        verticalPadding = (constraints.maxHeight -
                ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
            2;
      } else {
        verticalPadding = padding;
        horizontalPadding = (constraints.maxWidth -
                ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
            2;
      }
      return Stack(fit: StackFit.expand, children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(border: Border.all(color: kActiveColor)),
        )
      ]);
    });
  }

  /// Display the control bar with buttons to take pictures
  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Icon(Icons.circle, color: kActiveColor),
                    Text(
                      "Front",
                      style: kBodyTextStyle,
                    )
                  ],
                ),
                HorizontalSpacing(),
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/camera.svg",
                      width: 21,
                      height: 21,
                    ),
                    VerticalSpacing(of: 2),
                    Text(
                      "Side",
                      style: kBodyTextStyle,
                    )
                  ],
                ),
              ],
            ),
            VerticalSpacing(of: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FloatingActionButton(
                  elevation: 0,
                  child: SvgPicture.asset("assets/icons/camera.svg"),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _onCapturePressed(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraToggleRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            _getCameraLensIcon(lensDirection),
            color: kActiveColor,
            size: 24,
          ),
          onPressed: _onSwitchCamera,
        ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error:${e.code}\nError message : ${e.description}';
    print(errorText);
  }

  void _onCapturePressed(context) async {
    try {
      final path =
          join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await controller.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreviewScreen(
                  imgPath: path,
                )),
      );
    } catch (e) {
      _showCameraException(e);
    }
  }

  void _onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    _initCameraController(selectedCamera);
  }
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 2,
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: kActiveColor,
//             ),
//             color: kActiveColor,
//             onPressed: () => Navigator.pop(context)),
//         title: Text(
//           '사진 촬영',
//           style: TextStyle(
//               color: kActiveColor, fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//           child: _image == null
//               ? Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//                   VerticalSpacing(
//                     of: 200,
//                   ),
//                   Text(
//                     "촬영 전 주의사항 📸",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: kActiveColor,
//                         fontSize: 19,
//                         height: 2.0,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     '''

//       ✔️ 페이스라인에 맞춰서 촬영해주세요
//       ✔️ 앞머리, 마스크 등 얼굴을 가리지 말아주세요
//       ✔️ 어두운 곳에서 촬영을 피해주세요
// ''',
//                     style: TextStyle(
//                         color: kActiveColor,
//                         fontSize: 17,
//                         height: 2.0,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   VerticalSpacing(
//                     of: 30,
//                   ),
//                   SizedBox(
//                       width: 200,
//                       child:
//                           PrimaryButton(text: "사진 찍기", press: () => getImage()))
//                 ])
//               : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Image.file(_image),
//                   VerticalSpacing(
//                     of: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 150,
//                         child: SecondaryButton(
//                             text: "다른 사진으로 할래요", press: () => getImage()),
//                       ),
//                       HorizontalSpacing(),
//                       SizedBox(
//                         width: 150,
//                         child: PrimaryButton(
//                             text: "이 사진으로 분석하기",
//                             press: () {
//                               _uploadFile(context).then((value) =>
//                                   FirebaseFirestore.instance
//                                       .collection('Photo')
//                                       .doc(widget.user.email)
//                                       .set({'imageurl': value}));
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           LoadingScreen(widget.user)));
//                             }),
//                       ),
//                     ],
//                   ),
//                 ])),
//     );
//   }

  // Future<String> _uploadFile(BuildContext context) async {
  //   // storage 에 업로드 할 파일 경로
  //   final reference = FirebaseStorage.instance
  //       .ref()
  //       .child('Image')
  //       .child('${DateTime.now().millisecondsSinceEpoch}.png');
  //   // 파일 업로드
  //   await reference.putFile(_image);
  //   // 파일 url 반환
  //   return await reference.getDownloadURL();
  // }
}
