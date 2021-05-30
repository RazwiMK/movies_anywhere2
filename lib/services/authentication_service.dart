import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_anywhere/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> addUserToDB(
      {String uid, String username, String email, DateTime timestamp}) async {
    userModel = UserModel(
        uid: uid, username: username, email: email, timestamp: timestamp);

    await userRef.doc(uid).set(userModel.toMap(userModel));
  }

  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();

    return UserModel.fromMap(doc.data());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
