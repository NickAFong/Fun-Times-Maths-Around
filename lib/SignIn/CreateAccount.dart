import 'package:flutter/material.dart';
import 'package:ftma/Benchmark/Quiz.dart';
import 'package:ftma/MyModels/user.dart';
import 'package:ftma/utils/FirebaseUtil.dart';

import 'package:ftma/utils/dart_exts.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  CreateAccountState createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
  TextEditingController? usernameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  late bool isLoading;

  final firebaseManager = FirebaseUtils();

  @override
  @override
  void initState() {
    super.initState();
    isLoading = false;
    confirmPasswordController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    usernameController = TextEditingController();
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
          child: ListView(children: <Widget>[
            TextFormField(
              controller: usernameController,
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
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () {
                  if (isValid()) {
                    //Call firebase
                    context.showProgress();
                    UserModel user = UserModel(
                        username: usernameController!.text.toString(),
                        email: emailController?.text.toString());
                    firebaseManager
                        .signUp(passwordController!.text.toString(), user)
                        .listen((event) {
                      // hideProgress();
                      pushGame();
                    }, onError: (error) {
                      context.hideProgress();
                      showMessage(error.toString());
                    });
                  } else {
                    showMessage("Please fill out fields");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                  print('BackButton pressed');
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 20),
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
          ]),
        ));
  }

  void showMessage(String? msg) {
    if (msg != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  bool isValid() {
    bool userNotNull = usernameController?.text.isNotEmpty ?? false;
    bool passwordNotNull = passwordController?.text.isNotEmpty ?? false;
    bool confirmPasswordNotNull =
        confirmPasswordController?.text.isNotEmpty ?? false;
    bool emailNotNull = emailController?.text.isNotEmpty ?? false;
    bool isPasswordConfirmed =
        passwordController?.text == confirmPasswordController?.text;

    return (userNotNull &&
        passwordNotNull &&
        confirmPasswordNotNull &&
        emailNotNull &&
        isPasswordConfirmed);
  }

  void pushGame() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (e) => Quiz()), (route) => false);
  }
}
