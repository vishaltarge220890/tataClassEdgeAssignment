import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quiz_view/quiz_view.dart';

class QuizClass extends StatefulWidget {
  QuizClass({Key key}) : super(key: key);

  @override
  _QuizClassState createState() => _QuizClassState();
}

class _QuizClassState extends State<QuizClass> {
  int questionNumber = 1;
  bool showMessage = false;
  bool isAnswerCorrect = false;

  List listOfQuestions = [
    'Brass gets discoloured in air because of the presence of which of the following gases in air?',
    'Which of the following is a non metal that remains liquid at room temperature?',
    'Chlorophyll is a naturally occurring chelate compound in which central metal is',
    'Which of the following is used in pencils?',
    'Which of the following metals forms an amalgam with other metals?'
  ];

  List rightAnswer = [
    'Hydrogen sulphide',
    'Bromine',
    'Magnesium',
    'Graphite',
    'Mercury'
  ];

  List wrongAnswers = [
    ['Oxygen', 'Carbon dioxide', 'Nitrogen'],
    ['Phosphorous', 'Chlorine', 'Helium'],
    ['Copper', 'Iron', 'Calcium'],
    ['Silicon', 'Charcoal', 'Phosphorous'],
    ['Tin', 'Lead', 'Zinc']
  ];

  @override
  Widget build(BuildContext context) {
    print('Build method called questionNumber: $questionNumber');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 111, 0, 255),
      appBar: AppBar(
        title: Text('Quiz Time'),
      ),
      body: Container(
        child: getQuizView()
      ),
    );
  }

  Widget getQuizView() {
    print('getQuizView called');
    return Stack(
      children: [
        showMessage ? showCorrectMessage() : QuizView(
          showCorrect: false,
          tagBackgroundColor: Colors.deepOrange,
          tagColor: Colors.black,
          questionTag: "Question: $questionNumber",
          answerColor: Colors.white,
          answerBackgroundColor: Color.fromARGB(255, 255, 0, 111),
          questionColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 111, 0, 255),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          question: listOfQuestions[questionNumber - 1],
          rightAnswer: rightAnswer[questionNumber - 1],
          wrongAnswers: wrongAnswers[questionNumber - 1],
          onRightAnswer: handleRightAnswer,
          onWrongAnswer: handleWrongAnswer,
        )
      ],
    );
  }

  void handleRightAnswer() {
    showMessage = true;
    isAnswerCorrect = true;

    if(questionNumber < 5) {
      setState(() {
        questionNumber += 1;
      });
    } else {

    }
  }

  void handleWrongAnswer() {
    showMessage = true;
    isAnswerCorrect = false;
    setState(() {});
  }

  Widget showCorrectMessage(){
    Future.delayed(Duration(seconds: 2), (){
      setState(() {
        showMessage = false;
      });
    });

    return Center(
      child: Container(
        width: 150,
        height: 150,
        child: Center(child: Text(isAnswerCorrect ? 'Correct!' : 'Wrong', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),)),
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      ),
    );
  }

}