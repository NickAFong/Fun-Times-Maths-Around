import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftma/learn/CountingIsFun.dart';
import 'package:ftma/learn/HappyMath.dart';
import 'package:ftma/learn/Rulers.dart';
import 'package:ftma/main.dart';
import 'Fun_Song.dart';

class VideoButtons extends StatelessWidget {
  const VideoButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
        textStyle: TextStyle(fontSize: 30));
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fun_Song()),
                );
              },
              child: const Text('Sing Along'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CountingIsFun()),
                );
              },
              child: const Text('Counting is Fun'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HappyMath()),
                );
              },
              child: const Text('Happy Numbers'),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amberAccent,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rulers()),
                );
              },
              child: const Text(
                'Learn and Play',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 150),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                  print('New Quiz');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 170),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
