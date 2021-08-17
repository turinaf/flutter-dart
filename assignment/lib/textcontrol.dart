import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback buttonHandler;
  TextControl(this.buttonHandler);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonHandler,
      child: Text("Change Text"),
    );
  }
}
