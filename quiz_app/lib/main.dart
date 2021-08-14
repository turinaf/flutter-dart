import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {
        'question': "What's your favorite color?",
        'answers': ['Black', 'Red', "Green", 'White'],
      },
      {
        'question': "What's your favorite animal?",
        'answers': ['Cat', 'Rabbit', "Elephant", 'Lion'],
      },
      {
        'question': "Who is your favorite football player",
        'answers': ['Messi', 'Ronaldo', "Saleh", 'Robin'],
      },
    ];
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        body: Column(
          children: [
            // Text(questions[_questionIndex]),
            Question(questions[_questionIndex]['question'] as String),
            // three dots (Spread operator), take a list and pull all the value out of it and add them as individual list to the Column's children
            ...(questions[_questionIndex]['answers'] as List<String>)
                .map((answer) {
              return Answer(_answerQuestion, answer);
            }).toList()
          ],
        ),
      ),
    );
  }
}
