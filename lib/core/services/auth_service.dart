import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendResetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async => _auth.signOut();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw Exception("No logged-in user");

    final cred = EmailAuthProvider.credential(email: user.email!, password: oldPassword);
    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
  }
}
