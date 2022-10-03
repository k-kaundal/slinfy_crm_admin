part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  final UserModel? userModel;

  AuthenticationStarted({this.userModel});

  @override
  List<Object> get props => [];
}

class AuthenticationChecking extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationSignedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
