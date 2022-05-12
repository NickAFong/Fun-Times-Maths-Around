import 'package:flutter/material.dart';
import 'package:ftma/Benchmark/StartPage.dart';
import 'package:ftma/utils/FirebaseUtil.dart';
import 'package:ftma/utils/dart_exts.dart';


class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  late FirebaseUtils firebaseUtils;

  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    firebaseUtils = FirebaseUtils();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
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
        body: Container(
          color: Colors.green,
          padding: EdgeInsets.all(16),
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (isValid()) {
                        context.showProgress();
                        firebaseUtils
                            .signIn(emailController!.text.toString(),
                                passwordController!.text.toString())
                            .listen((event) {
                          // Sign in
                          pushGame();
                        }, onError: (error) {
                          showMessage(error.toString());
                          context.hideProgress();
                        });
                      } else {
                        showMessage("Fields are not properly filled");
                      }
                      print('SubmitButton pressed');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Text(
                      'Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ]),
        ));
  }

  bool isValid() {
    bool passwordNotNull = passwordController?.text.isNotEmpty ?? false;
    bool emailNotNull = emailController?.text.isNotEmpty ?? false;

    return (passwordNotNull && emailNotNull);
  }

  void pushGame() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (e) => StartPage()), (route) => false);
  }

  void showMessage(String? msg) {
    if (msg != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}
