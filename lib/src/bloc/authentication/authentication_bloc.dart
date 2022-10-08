import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slinfy_crm_admin/src/models/user_model.dart';
import 'package:slinfy_crm_admin/src/repo/repository/authentication_repository.dart';
import 'package:slinfy_crm_admin/src/repo/service/authentication_service.dart';
import 'package:slinfy_crm_admin/src/repo/service/database_service.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationRepositoryImpl authenticationRepositoryImpl)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        dynamic userCredential =
            await AuthenticationService().signIn(event.userModel!);
        // debugPrintStack(label: userCredential.toString());
        // User? user = FirebaseAuth.instance.currentUser;
        // print(userCredential.runtimeType);
        if (userCredential.runtimeType != UserCredential) {
          emit(AuthenticationFailure(error: userCredential));
        } else {
          UserModel userModel = await DatabaseService()
              .retrieveSingleUserData(userCredential!.user!.uid.toString());
          emit(AuthenticationSuccess(
              displayName: userModel.displayName,
              userType: userModel.userType));
        }
      } else if (event is AuthenticationSignedOut) {
        AuthenticationService().signOut();
        emit(AuthenticationInitial());
      } else if (event is AuthenticationChecking) {
        FirebaseAuth auth = FirebaseAuth.instance;

        if (auth.currentUser != null) {
          // print(auth.currentUser);
          UserModel userModel = await DatabaseService()
              .retrieveSingleUserData(auth.currentUser!.uid.toString());
          emit(AuthenticationSuccess(
              displayName: userModel.displayName,
              userType: userModel.userType));
        } else {
          emit(AuthenticationInitial());
        }
      } else {
        emit(AuthenticationFailure());
      }
    });
  }
}
