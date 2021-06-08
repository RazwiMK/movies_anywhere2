import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_anywhere/models/movie_model.dart';
import 'package:movies_anywhere/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  UserModel userModel = UserModel();
  // MovieModel movieModel = MovieModel();
  final userRef = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final movieRef = FirebaseFirestore.instance.collection("watchlist");

  AuthenticationService(this._firebaseAuth);

// managing the user state via stream.
// stream provides an immediate event of
// the user's current authentication state,
// and then provides subsequent events whenever
// the authentication state changes.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

//1
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

//2
  // ignore: missing_return
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (e) {
      print(e);
    }
  }

//3
  Future<void> addUserToDB(
      {String uid, String username, String email, DateTime timestamp}) async {
    userModel = UserModel(
        uid: uid, username: username, email: email, timestamp: timestamp);

    await userRef.doc(uid).set(userModel.toMap(userModel));
  }

  Future<void> addMovieToDB(
      {String name, String description, String bannerurl}) async {
    final User user = await auth.currentUser;
    final uid = user.uid;
    userModel = UserModel(
        uid: uid, name: name, description: description, bannerurl: bannerurl);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('/subCollectionPath')
        .doc(name)
        .set(userModel.toMap(userModel));
  }

//4
  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();

    //print(doc.data());

    return UserModel.fromMap(doc.data());
  }

//5
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
