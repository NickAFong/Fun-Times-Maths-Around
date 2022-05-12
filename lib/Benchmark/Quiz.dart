import 'package:flutter/material.dart';
import 'package:ftma/Benchmark/QuizQuestion.dart';
import 'package:ftma/MyModels/QuizViewModel.dart';
import 'package:ftma/utils/FirebaseUtil.dart';


class Quiz extends StatefulWidget {
  Quiz() {}

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final QuizViewModel _quizViewModel = QuizViewModel(FirebaseUtils());

  final requestTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _quizViewModel.setRank.listen((event) {
      // Success
      print("Success : $event");
    }, onError: (error, _) {
      print("Failed : $error");
    });

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/title2.png",
            fit: BoxFit.contain,
            height: 150,
          ),
          toolbarHeight: 150,
        ),
        body: StreamBuilder<bool?>(
          builder: (context, snapshot) {
            Color gradingColor = Colors.transparent;

            if (snapshot.data != null) {
              if (snapshot.requireData!) {
                gradingColor = Colors.green;
              } else {
                gradingColor = Colors.red;
              }
            }

            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 10,
                  color: gradingColor,
                ),
                color: Colors.lightBlue,
              ),
              padding: EdgeInsets.all(16),
              child: QuizQuestion(
                quizViewModel: _quizViewModel,
              ),
            );
          },
          stream: _quizViewModel.correctQuestion,
        ));
  }

  @override
  void dispose() {
    _quizViewModel.dispose();

    super.dispose();
  }
}
