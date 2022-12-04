part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class HomeServerType extends AuthState {
  final bool isRegistrationSupported;

  HomeServerType({
    required this.isRegistrationSupported
  });
}

class AuthBlocInitial extends AuthState {}

class Loading extends AuthState {}

class LoginSuccess extends AuthState {}

class UserNameAvailable extends AuthState {}

class SignupSuccess extends AuthState {}

class PasswordMismatch extends AuthState {}

class Failure extends AuthState {
  final String message;

  Failure({required this.message});
}