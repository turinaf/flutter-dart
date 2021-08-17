import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  // const MyText({Key? key}) : super(key: key);
  final bool isClicked;
  MyText(this.isClicked);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: isClicked
          ? Text(
              "Button Clicked",
              style: TextStyle(fontSize: 22),
            )
          : Text(
              "Click the button to change this text",
              style: TextStyle(fontSize: 22),
            ),
    );
  }
}
