import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ftma/MyModels/user.dart';


class FirebaseUtils {
  final firebaseAuth = FirebaseAuth.instance;
  final _firebaseDb = FirebaseDatabase.instance.ref();

  bool hasSignedIn() {
    return firebaseAuth.currentUser != null;
  }

  Stream<String> signUp(password, UserModel user) async* {
    // Create an account
    final signUp = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!, password: password);
    final uId = signUp.user?.uid;
    if (uId != null) {
      //  ADD user record to realtime database
      _firebaseDb.child("users").child(uId).set(user.toJson());
      yield "Successfully created an account!";
    } else {
      yield "Sign up failed";
    }
  }

  Stream<UserCredential> signIn(String email, String password) {
    try {
      final creds = firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .asStream();
      return creds;
    } catch (error, trace) {
      print('trace => $trace');
      return Stream.error(error);
    }
  }

  Stream<DataSnapshot> getRank() async* {
    final userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      final rank =
          await _firebaseDb.child("users").child(userId).child("rank").once();
      yield rank.snapshot;
    } else {
      throw Exception("User has not logged in");
    }
  }

  Stream<String> setRank(String rank) async* {
    final userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      await _firebaseDb.child("users").child(userId).update({"rank": rank});
      yield "Update successful.";
    } else {
      throw Exception("User has not logged in");
    }
  }
}
