import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ftma/SignIn/SignInPage.dart';

import 'learn/videoButtons.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    //  setUp();
    return MaterialApp(
      title: 'Fun Times Maths Around',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: HomePage(),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return HomePage();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              //print("snapshot => ${snapshot.error}");

              return snapshot.hasData
                  ? Container(
                      color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoButtons()));
                              print('LearnButton pressed');
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            child: Text(
                              'Learn',
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
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                              print('BenchmarkButton pressed');
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            child: Text(
                              'Benchmark',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ))
                  : const Center(child: CircularProgressIndicator());
            }));
  }
}
