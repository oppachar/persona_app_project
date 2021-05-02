import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;

  const SecondaryButton({Key key, @required this.text, @required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding =
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15));
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: Platform.isIOS
          ? CupertinoButton(
              padding: verticalPadding,
              color: kMainColor,
              onPressed: press,
              child: buildText(context),
            )
          : TextButton(
              onPressed: press,
              child: buildText(context),
            ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textScaleFactor: 1,
      style: TextStyle(
        color: kActiveColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
