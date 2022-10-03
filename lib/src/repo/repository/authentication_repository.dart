import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationService authenticationService = AuthenticationService();
  DatabaseService databaseService = DatabaseService();

  @override
  Stream<UserModel> getCurrentUser() {
    return authenticationService.retrieveCurrentUser();
  }

  @override
  Future<String?> retrieveUserName(UserModel userModel) {
    return databaseService.retrieveUserName(userModel);
  }

  @override
  Future<UserCredential?> signIn(UserModel userModel) {
    try {
      return authenticationService.signIn(userModel);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }

  @override
  Future<void> signOut() {
    return authenticationService.signOut();
  }

  @override
  Future<UserCredential?> signUp(UserModel userModel) {
    try {
      return authenticationService.signUp(userModel);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.toString());
    }
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();

  Future<UserCredential?> signUp(UserModel userModel);

  Future<UserCredential?> signIn(UserModel userModel);

  Future<void> signOut();

  Future<String?> retrieveUserName(UserModel userModel);
}
