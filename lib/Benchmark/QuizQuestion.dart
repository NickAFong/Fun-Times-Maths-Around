import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftma/Benchmark/ResultScreen.dart';
import 'package:ftma/Benchmark/TextToData.dart';
import 'package:ftma/MyModels/Question.dart';
import 'package:ftma/MyModels/QuestionWrapper.dart';
import 'package:ftma/MyModels/QuizViewModel.dart';
import 'package:rxdart/subjects.dart';
import 'QuizClock.dart';

class QuizQuestion extends StatelessWidget {
  late QuizViewModel quizViewModel;
  int questionIndex = 0;

  TextEditingController _answerController = TextEditingController();

  QuizQuestion({
    required this.quizViewModel,
  });

  @override
  Widget build(BuildContext context) {

    BehaviorSubject<bool> clockController = BehaviorSubject();
    clockController.sink.add(false);
    return StreamBuilder<QuestionWrapper>(
      builder: (_, snapshot) {
        String? question;
        if (snapshot.hasData) {
          final questionWrapper = snapshot.data!;
          question = questionWrapper.question;
          if (questionWrapper.hasEnded) {
            clockController.sink.add(true); //Stop the timer
            questionWrapper.timeSpent = QuizClockState.counter.toString();
            return ResultScreen(
                questionWrapper);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            QuizClock(clockController.stream),
            Question(
              question!,
            ),
            Column(
              children: [
                TextField(
                  controller: _answerController,
                  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      labelText: "Answer here:",
                      border: const OutlineInputBorder()),
                ),
                _buildButton(snapshot.data?.correctAnswer, clockController)
              ],
            )
          ],
        );
      },
      stream: quizViewModel.question,
    );
  }

  Widget _buildButton(
      String? correctAnswer, BehaviorSubject<bool> clockController) {
    return StreamBuilder<bool>(
      builder: (_, snapshot) {
        return ElevatedButton(
            onPressed: snapshot.requireData
                ? () {
                    if ((clockController.value)) {
                      clockController.sink.add(false);
                    }
                    final guess = int.tryParse(_answerController.text);

                    if (guess != null) {
                      quizViewModel.checkAnswer(guess);
                    }
                  }
                : null,
            child: Text(snapshot.requireData
                ? "Check Answer"
                : "Correct Answer: $correctAnswer"));
      },
      stream: quizViewModel.checkAnswerBtn,
      initialData: true,
    );
  }
}
