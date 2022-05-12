import 'package:flutter/material.dart';
import 'package:ftma/Learn/VideoButtons.dart';

import 'Explore.dart';

class AnswerForRulers extends StatelessWidget {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
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
            child: Image.asset('assets/images/ruler3.jpg'),
          ),
          SizedBox(height: 30),
          Card(
            child: Text(
              'The answer is: ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            elevation: 20,
          ),
          SizedBox(height: 30),
          Card(
            child: Text(
              'Ruler',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            elevation: 20,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Explore'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Explore()),
              );
            },
            style: style,
          ),
        ],
      ),
    );
  }
}
