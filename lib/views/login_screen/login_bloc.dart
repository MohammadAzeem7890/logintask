import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/helper_functions/global_functions.dart';
import 'package:login_task/helper_functions/handle_exceptions.dart';
import 'package:login_task/network/network.dart';
import 'package:login_task/utils/constants.dart';
import 'package:login_task/views/login_screen/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<User?> createUser(String email, String password) async {
    emit(RegisterLoading(Constants.creatingNewUserMessage));

    try {
      UserCredential userCredential =
          await FirebaseDB.createUser(email.trim(), password.trim());
      if (userCredential.user != null) {
        emit(RegistrationSuccess(
            userCredential.user, Constants.registrationSuccessMessage));
        emit(LoginLoading(Constants.loadingLoginMessage));
        validateLogin(email, password);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      emit(RegistrationFailure(e.message.toString()));
    } catch (e) {
      emit(RegistrationFailure(Constants.unDefinedError));
    }
    return null;
  }

  Future<User?> login(String email, String password) async {
    emit(LoginLoading(Constants.loadingLoginMessage));
    try {
      UserCredential userCredential = await FirebaseDB.login(
        email.trim(),
        password.trim(),
      );
      if (userCredential.user != null) {
        emit(LoginSuccess());
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == Constants.userNotFoundErrorCode) {
        emit(LoginFailure(Constants.userNotFoundErrorCode));
        createUser(email, password);
      } else {
        emit(LoginFailure(e.message.toString()));
      }
    } catch (e) {
      emit(LoginFailure(Constants.unDefinedError));
    }
    return null;
  }

  Future<void> logOut() async {
    try {
      await FirebaseDB.logOut();
      emit(LoginInitial());
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
        e.code,
      );
    } catch (e) {
      showErrorMessage(
        Constants.unDefinedError,
      );
    }
  }

  validateLogin(String email, String password) {
    if (validateEmail(email) == true && validatePassword(password) == true) {
      login(email, password);
    }
  }

  bool validateEmail(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      showToast(
        Constants.emailEmptyError,
      );
      debugPrint("Email can't be empty");
      return false;
    }
    // Regular expression for validating an email address
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      showToast(
        Constants.emailFormatError,
      );
      debugPrint("Please match following email format");
      return false;
    }
    return true;
  }

  bool validatePassword(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      showToast(
        Constants.passwordEmptyError,
      );
      debugPrint("Password can't be empty");
      return false;
    }
    // Password should be at least 8 characters long
    if (value.length < 8) {
      showToast(
        Constants.passwordLengthError,
      );
      debugPrint("Password must be greater than 8 characters");
      return false;
    }
    // Password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      showToast(
        Constants.passwordFormatError,
      );
      debugPrint("Please match following password format");
      return false;
    }
    return true;
  }

  showErrorMessage(
    code,
  ) {
    final errorType = HandleExceptions.mapFirebaseErrorToAuthErrorType(code);
    final errorMessage = HandleExceptions.getErrorMessage(errorType).toString();
    showToast(
      errorMessage,
    );
  }
}
