import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:login_task/utils/constants.dart';

import '../views/home_screen/models/todo_list_helper_model.dart';

class FirebaseDB {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static Future<UserCredential> createUser(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future postListItemToFirebase(
      List<TodoListItemHelperModel> itemList) async {

    // create batch
    WriteBatch batch = _db.batch();

    // collection reference
    CollectionReference cRef = _db.collection(Constants.toDoListCollection);

    DocumentReference dRef = cRef.doc();

    for (var item in itemList) {
      dRef.set(item.toMap());
    }
    try {
      await batch.commit();
      if (kDebugMode) {
        print("Bulk write successful!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Bulk write FAILED : $e");
      }
    }
  }

  static Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
