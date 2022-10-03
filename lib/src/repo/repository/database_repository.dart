import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }


  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  // _onEmailChanged(EmailChanged event, Emitter<DetailsFormsValidate> emit) {
  //   emit(state.copyWith(
  //     isFormSuccessful: false,
  //     isFormValid: false,
  //     isFormValidateFailed: false,
  //     errorMessage: "",
  //     email: event.email,
  //     isEmailValid: _isEmailValid(event.email),
  //   ));
  // }
  //
  // _onFormSubmitted(DetailsFormSubmitted event, Emitter<DetailsFormsValidate> emit) async {
  //   UserModel user = UserModel(
  //       email: state.email,
  //       password: state.password,
  //       age: state.age,
  //       displayName: state.displayName);
  //
  //   if (event.value == Status.signUp) {
  //     await _updateUIAndSignUp(event, emit, user);
  //   } else if (event.value == Status.signIn) {
  //     await _authenticateUser(event, emit, user);
  //   }
  // }
  // _updateUIAndSignUp(
  //     DetailsFormSubmitted event, Emitter<DetailsFormsValidate> emit, UserModel user) async {
  //   emit(
  //       state.copyWith(errorMessage: "",
  //           isFormValid: _isPasswordValid(state.password) &&
  //               _isEmailValid(state.email) &&
  //               _isAgeValid(state.age) &&
  //               _isNameValid(state.displayName),
  //           isLoading: true));
  //   if (state.isFormValid) {
  //     try {
  //
  //       UserCredential? authUser = await _authenticationRepository.signUp(user);
  //       UserModel updatedUser = user.copyWith(
  //           uid: authUser!.user!.uid, isVerified: authUser.user!.emailVerified);
  //       await _databaseRepository.saveUserData(updatedUser);
  //       if (updatedUser.isVerified!) {
  //         emit(state.copyWith(isLoading: false, errorMessage: ""));
  //       } else {
  //         emit(state.copyWith(isFormValid: false,errorMessage: "Please Verify your email, by clicking the link sent to you by mail.",isLoading: false));
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       emit(state.copyWith(
  //           isLoading: false, errorMessage: e.message, isFormValid: false));
  //     }
  //   } else {
  //     emit(state.copyWith(
  //         isLoading: false, isFormValid: false, isFormValidateFailed: true));
  //   }
  // }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<List<UserModel>> retrieveUserData();
}