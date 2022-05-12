import 'dart:async';
import 'package:flutter/material.dart';

class QuizClock extends StatefulWidget {
  Stream<bool> clockController;

  QuizClock(this.clockController);

  @override
  QuizClockState createState() {
    return QuizClockState();
  }
}

class QuizClockState extends State<QuizClock> {
  static int counter = 0;
 String? timeSpent;

  @override
  void initState() {
    runTimer();
    super.initState();
  }

  void runTimer() {

   final stopwatch = Stopwatch()..start();
   
    widget.clockController.listen((hasFinished) {
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        if (mounted) {
          if (hasFinished) {
            timer.cancel();
            counter = counter;
          } else {
            counter += 1;
          }
            timeSpent = "${getTime(Duration(milliseconds: timer.tick))}";  
          setState(() {
          });
        }
      });
    });
  }

  String getTime(Duration duration){
    String pairDigits(int n) => n.toString().padLeft(2, "0");
    final mins = pairDigits(duration.inMinutes.remainder(60));
    String seconds = pairDigits(duration.inSeconds.remainder(60));
    return "$mins minutes and $seconds seconds";
  } 

  @override
  Widget build(BuildContext context) {
    return Text(timeSpent ?? "");
  }
}
