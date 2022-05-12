import 'package:flutter/material.dart';

import '../Benchmark/TextToData.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {

    
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: buildQuestions(questionText),
    );
  }

  Widget buildQuestions(String questionText){
    TextToData textToData = TextToData.instance();
    List<String> questionList = questionText.split(" ");
      print("IMAGES => ${questionList[0]}");
    textToData.convert(questionList[0])?.forEach((element) {
      
      print("IMAGES => ${element}");
    });


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: textToData.convert(questionList[0])!.map((e) => Image.asset(e, width: 40, height: 40,)).toList(),
        ),  const SizedBox(width: 14,), Row(
          children: textToData.convert(questionList[1])!.map((e) => Image.asset(e, width: 20, height: 20,)).toList(),
        ), const SizedBox(width: 14,), Row(
          children: textToData.convert(questionList[2])!.map((e) => Image.asset(e, width: 40, height: 40,)).toList(),
        ), const SizedBox(width: 14,), Image.asset(textToData.convert("=")![0], width: 25, height: 25,)
      ],
    );
  }
}
