part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String? displayName;
  final String? userType;

  const AuthenticationSuccess({this.displayName,this.userType});

  @override
  List<Object?> get props => [displayName,userType];
}

class AuthenticationFailure extends AuthenticationState {
  String? error;
  AuthenticationFailure({this.error});
  @override
  List<Object?> get props => [error];
}
