import 'package:flutter/material.dart';

import 'AnswerForRuler.dart';

class Rulers extends StatelessWidget {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Card(
            elevation: 50,
            child: Image.asset('assets/images/ruler1.jpg'),
          ),
          SizedBox(height: 30),
          Card(
            child: Text(
              'Do you know what is in the picture?',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            elevation: 20,
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            child: Text('Answer'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnswerForRulers()),
              );
            },
            style: style,
          ),
        ],
      ),
    );
  }
}
