import 'package:flutter/material.dart';
import 'package:persona/constants.dart';
import 'package:persona/widgets/cards/card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              InkWellCard(
                  circular: 30,
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => null)),
                  child: Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "result1",
                          style: TextStyle(color: kActiveColor, fontSize: 16),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
