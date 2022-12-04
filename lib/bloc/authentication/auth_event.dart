part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckHomeServer extends AuthEvent{
  final String homeServer;
  
  CheckHomeServer({
    required this.homeServer
  });
}

class CheckUserNameIsAvailable extends AuthEvent {
  final String username;

  CheckUserNameIsAvailable({required this.username});
}

class SignupUser extends AuthEvent {
  final String username;
  final String password;
  final String cPassword;

  SignupUser({
    required this.username,
    required this.password,
    required this.cPassword
  });
}

class LoginUser extends AuthEvent {
  final String username;
  final String password;

  LoginUser({
    required this.password,
    required this.username
  });

}