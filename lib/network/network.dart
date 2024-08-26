import 'package:firebase_auth/firebase_auth.dart';
class Network {
  static final _auth = FirebaseAuth.instance;

  static Future<UserCredential> createUser(
      String email, String password, context) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> login(
      String email, String password, context) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
