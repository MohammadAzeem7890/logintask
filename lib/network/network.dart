import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_task/helper_functions/global_functions.dart';
import 'package:login_task/utils/constants.dart';

class Network {
  static final _auth = FirebaseAuth.instance;

  static Future<UserCredential> createUser(
      String email, String password, context) async {
    // try {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   // AuthExceptionHandler
    //   debugPrint("EXCEPTION CASE IN NETWORK ${e.message}");
    //   showSnackBar(e.message.toString(), context);
    //   // final errorType = AuthExceptionHandler.mapFirebaseErrorToAuthResultStatus(e);
    //   // AuthExceptionHandler.getErrorMessage(errorType);
    // } catch (e) {
    //   debugPrint("UNKNOWN ERROR CASE IN NETWORK");
    //   showSnackBar(Constants.unDefinedError, context);
    //   // final errorType = AuthExceptionHandler.mapFirebaseErrorToAuthResultStatus(e);
    //   // AuthExceptionHandler.getErrorMessage(errorType);
    //   debugPrint(e.toString());
    // }
  }

  static Future<UserCredential> login(String email, String password, context) async {
    // try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   // AuthExceptionHandler
    //   debugPrint("EXCEPTION CASE IN NETWORK ${e.message.toString() + e.code}");
    //   debugPrint("EXCEPTION CASE IN NETWORK with code ${e.code.toString()}");
    //   showSnackBar(e.message.toString(), context);
    //   // final errorType = AuthExceptionHandler.mapFirebaseErrorToAuthResultStatus(e);
    //   // AuthExceptionHandler.getErrorMessage(errorType);
    // } catch (e) {
    //   debugPrint("UNKNOWN ERROR CASE IN NETWORK");
    //   showSnackBar(Constants.unDefinedError, context);
    //   // final errorType = AuthExceptionHandler.mapFirebaseErrorToAuthResultStatus(e);
    //   // AuthExceptionHandler.getErrorMessage(errorType);
    //   debugPrint(e.toString());
    // }
  }


  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
