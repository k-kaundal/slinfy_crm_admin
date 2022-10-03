import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slinfy_crm_admin/src/models/offline_model/user_object.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/utils/constants/commons.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(
            uid: user.uid, email: user.email, displayName: user.displayName);
      } else {
        return UserModel(uid: "uid");
      }
    });
  }

  Future<UserCredential?> signUp(UserModel userModel) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.password.toString());
      verifyEmail();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      FlutterError(e.code);
      ScaffoldMessenger(
        child: Text(e.code.toString()),
      );
      print(e.code.toString());
    }
  }

   signIn(UserModel userModel) async {
    final SharedPreferences prefs = await _prefs;
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.password.toString());
      User? user = FirebaseAuth.instance.currentUser;
      UserObject userObject = UserObject(
          email: userModel.email.toString(),
          password: userModel.password.toString());
      prefs.setString('email', userModel.email.toString());
      prefs.setString('password', userModel.password.toString());
      // await Commons().addUserBoxData(userObject);
      // print(userCredential.credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
     return e.code;
      // throw FirebaseAuthException(code: e.toString());
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }


  reSignIn() async{
    final SharedPreferences prefs = await _prefs;
    await FirebaseAuth.instance.signOut();
    auth.signInWithEmailAndPassword(email: prefs.getString('email').toString(), password: prefs.getString('password').toString());
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
