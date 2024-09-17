import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final String message;
  LoginLoading(this.message);
}

class LoginSuccess extends LoginState {

}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

class RegisterInitial extends LoginState {}

class RegisterLoading extends LoginState {
  final String message;
  RegisterLoading(this.message);
}

class RegistrationSuccess extends LoginState {
  final User? user;
  final String message;
  RegistrationSuccess(this.user, this.message);
}

class RegistrationFailure extends LoginState {
  final String errorMessage;

  RegistrationFailure(this.errorMessage);
}
