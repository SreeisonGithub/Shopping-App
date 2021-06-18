import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funcart/models/productModel.dart';

class AuthenticationService {
  AuthenticationService();

  Stream<User> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> addBookmark(Products item, String email) async {
    DocumentReference reference =
        FirebaseFirestore.instance.collection(email).doc("Bookmark");
    return await reference.set({
      "id": item.id,
      "Product name": item.name,
      "Image": item.imageLink,
      "CREATED_AT": FieldValue.serverTimestamp()
    }).then((value) {
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  User getCurrentFirebaseUser() {
    User currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
