// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:login_task/network/network.dart';
// import 'package:login_task/views/home_screen/bloc/home_state.dart';
// import 'package:login_task/views/login_screen/login_bloc.dart';
// import 'package:login_task/views/login_screen/login_state.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
//
// class MockFirebaseUserCredential extends Mock implements UserCredential {}
//
// class MockFirebaseUser extends Mock implements User {}
//
// class MockFirestoreDB extends Mock implements FirebaseFirestore {}
//
// void main() {
//   late MockFirebaseAuth mockFirebaseAuth;
//   late FirebaseDB firebaseDB;
//   late MockFirestoreDB mockFirestoreDB;
//   late MockFirebaseUserCredential mockFirebaseUserCredential;
//   late MockFirebaseUser mockFirebaseUser;
//
//   setUp(() {
//     mockFirestoreDB = MockFirestoreDB();
//     mockFirebaseUser = MockFirebaseUser();
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockFirebaseUserCredential = MockFirebaseUserCredential();
//     firebaseDB = FirebaseDB(mockFirebaseAuth, mockFirestoreDB);
//   });
//
//   // given
//   // when
//   // then
//
//   // activate
//   // act
//   // assert
//
//   test("create user in firebase success case", () async {
//     // arrange
//     when(() => mockFirebaseUserCredential.user).thenReturn(mockFirebaseUser);
//     when(() => mockFirebaseAuth.signInWithEmailAndPassword(
//         email: any(),
//         password: any())).thenAnswer((_) async => mockFirebaseUserCredential);
//
//     // act
//     final result =
//         await firebaseDB.createUser("tessdfa@asldfa.com", "Azasdf@asd234fa");
//
//     // assert
//     expect(result, mockFirebaseUser);
//
//     verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
//         email: "asdfas@sad.coa123", password: "Aas@as23234")).called(1);
//   });
// }
