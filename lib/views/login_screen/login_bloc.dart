import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/helper_functions/auth_error_type.dart';
import 'package:login_task/helper_functions/global_functions.dart';
import 'package:login_task/helper_functions/handle_exceptions.dart';
import 'package:login_task/network/network.dart';
import 'package:login_task/utils/constants.dart';
import 'package:login_task/views/login_screen/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> createUser(String email, String password, context) async {
    emit(LoginLoading());
    try {
      await Network.createUser(email.trim(), password.trim(), context);
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message.toString()));
      showErrorMessage(e.code, context);
    } catch (e) {
      emit(LoginFailure(Constants.unDefinedError));
      showErrorMessage(Constants.unDefinedError, context);
    }
  }

  Future<void> login(String email, String password, context) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential =
          await Network.login(email.trim(), password.trim(), context);
      if (userCredential.user != null) {
        debugPrint("success case in cubit");
        emit(LoginSuccess(userCredential.user));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == Constants.userNotFoundErrorCode) {
        createUser(email, password, context);
      }
      emit(LoginFailure(e.message.toString()));
      showErrorMessage(e.code, context);
    } catch (e) {
      emit(LoginFailure(Constants.unDefinedError));
      showErrorMessage(Constants.unDefinedError, context);
    }
  }

  Future<void> logOut(context) async {
    try {
      await Network.logOut();
      emit(LoginInitial());
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code, context);
    } catch (e) {
      showErrorMessage(Constants.unDefinedError, context);
    }
  }

  validateLogin(String email, String password, context) {
    if (validatePassword(password, context) && validateEmail(email, context)) {
      login(email, password, context);
    }
  }

  bool validateEmail(String? value, context) {
    if (value == null || value.isEmpty) {
      showSnackBar(Constants.emailEmptyError, context);
      debugPrint("Email can't be empty");
      return false;
    }
    // Regular expression for validating an email address
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      showSnackBar(Constants.emailFormatError, context);
      debugPrint("Please match following email format");
      return false;
    }
    return true;
  }

  bool validatePassword(String? value, context) {
    if (value == null || value.isEmpty) {
      showSnackBar(Constants.passwordEmptyError, context);
      debugPrint("Password can't be empty");
      return false;
    }
    // Password should be at least 8 characters long
    if (value.length < 8) {
      showSnackBar(Constants.passwordLengthError, context);
      debugPrint("Password must be greater than 8 characters");
      return false;
    }
    // Password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      showSnackBar(Constants.passwordFormatError, context);
      debugPrint("Please match following password format");
      return false;
    }
    return true;
  }

  showErrorMessage(code, context) {
    final errorType = HandleExceptions.mapFirebaseErrorToAuthErrorType(code);
    final errorMessage = HandleExceptions.getErrorMessage(errorType).toString();
    showSnackBar(errorMessage, context);
  }
}
