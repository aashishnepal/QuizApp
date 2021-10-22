import 'dart:io';

import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Lets play Bambozoled")),
          backgroundColor: Colors.blueGrey,
        ),
        backgroundColor: Colors.black45,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Icon> scoreKeeper = [];
  int i = 0;

  void ansCheck(bool userAns) {
    bool correctAns = quizBrain.getAnswerText();
    setState(() {
      if (i < 12) {
        if (correctAns == userAns) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        i++;
        quizBrain.nextQuestion();
      } else {
        i = 0;
        Alert(
          context: context,
          type: AlertType.error,
          title: "Quiz Ended",
          // desc: "Do you want to play again",
          buttons: [
            DialogButton(
              child: Text("Exit Game",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              width: 120,
              onPressed: () => exit(0),
            )
          ],
        ).show();
        quizBrain.resetQu();
        scoreKeeper = [];
      }
    });
  }

  int qn = 0;
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                ansCheck(true);

                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  ansCheck(false);
                }),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
