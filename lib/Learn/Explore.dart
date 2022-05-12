import 'package:flutter/material.dart';
import 'package:ftma/learn/videoButtons.dart';

class Explore extends StatelessWidget {
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
            child: Image.asset('assets/images/ruler4.jpg'),
          ),
          SizedBox(height: 30),
          Card(
            child: Text(
              'Rulers are different shapes, but they all show the same length. Can you find a ruler in your home?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            elevation: 20,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => VideoButtons()),
                    (route) => false);
                print('Back VideoButtons');
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              child: Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
    );
  }
}
