import 'package:assignment/text.dart';
import 'package:assignment/textcontrol.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    void _changeText() {
      setState(() {
        _isClicked = !_isClicked;
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Assignment 1"),
          leading: FlutterLogo(),
        ),
        body: Center(
          child: Column(
            children: [MyText(_isClicked), TextControl(_changeText)],
          ),
        ),
      ),
    );
  }
}
