
import '../utils/constants.dart';
import 'auth_error_type.dart';

class HandleExceptions {
  static String getErrorMessage(AuthErrorType errorType) {
    switch (errorType) {
      case AuthErrorType.invalidEmail:
        return Constants.invalidEmailError;
      case AuthErrorType.userNotFound:
        return Constants.emailNotRegisteredError;
      case AuthErrorType.wrongPassword:
        return Constants.wrongPasswordError;
      case AuthErrorType.invalidCredential:
        return Constants.invalidCredentialsErrorMessage;
      case AuthErrorType.unknown:
      default:
        return Constants.unDefinedError;
    }
  }

  static AuthErrorType mapFirebaseErrorToAuthErrorType(
      String code) {
    switch (code) {
      case 'invalid-email':
        return AuthErrorType.invalidEmail;
      case 'user-not-found':
        return AuthErrorType.userNotFound;
      case 'wrong-password':
        return AuthErrorType.wrongPassword;
      case 'invalid-credential':
        return AuthErrorType.invalidCredential;
      default:
        return AuthErrorType.unknown;
    }
  }
}
