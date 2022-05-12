import 'package:flutter/material.dart';
import 'package:ftma/MyModels/QuestionWrapper.dart';
import 'package:ftma/main.dart';
import 'StartPage.dart';

class ResultScreen extends StatelessWidget {
  late QuestionWrapper result;

  ResultScreen(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                "${result.correctGuessesCount}/10 Correct",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "Time Spent: ${parse(result.timeSpent)}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "New Rank: ${result.rank}",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                // height: 220,
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                  print('Home Page');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => StartPage()),
                      (route) => false);
                  print('New Quiz');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: Text(
                  'New Quiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ]),
      ),
    );
  }

  String parse(String? counter) {
    if (counter == null) return "";
    int? timer = int.tryParse(counter) ?? 0;

    final duration = Duration(milliseconds: timer).inSeconds;
    int mins = duration ~/ 60;
    int secs = (duration % 60) > 59 ? 0 : (duration % 60);
    return "$mins min and $secs sec";
  }
}
