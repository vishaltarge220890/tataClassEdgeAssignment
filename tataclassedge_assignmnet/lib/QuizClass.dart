import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';

class QuizClass extends StatefulWidget {
  QuizClass({Key key}) : super(key: key);

  @override
  _QuizClassState createState() => _QuizClassState();
}

class _QuizClassState extends State<QuizClass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 111, 0, 255),
      appBar: AppBar(
        title: Text('Quiz Time'),
      ),
      body: QuizView(
        showCorrect: true,
        tagBackgroundColor: Colors.deepOrange,
        tagColor: Colors.black,
        questionTag: "Question: 2",
        answerColor: Colors.white,
        answerBackgroundColor: Color.fromARGB(255, 255, 0, 111),
        questionColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 111, 0, 255),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        question: "Which is the best framework for app development?",
        rightAnswer: "Flutter",
        wrongAnswers: ["Fluttor", "Flitter"],
        onRightAnswer: () => print("Right"),
        onWrongAnswer: () => print("Wrong"),
      ),
    );
  }

}