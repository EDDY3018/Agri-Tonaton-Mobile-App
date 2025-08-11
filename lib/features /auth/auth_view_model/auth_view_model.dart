import 'package:agri_tonaton/core/models/user_model.dart';
import 'package:agri_tonaton/core/repositories/user_repository.dart';
import 'package:agri_tonaton/core/services/auth_service.dart';
import 'package:agri_tonaton/core/utils/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  final UserRepository _userRepo;
  final LocalStorageService _localStorage = LocalStorageService();
  bool isLoading = false;
  String? error;
User? get currentUser => FirebaseAuth.instance.currentUser;
  AuthViewModel(this._authService, this._userRepo);

  /// Format Firebase errors into friendly text
  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return "The email address format is invalid.";
      case 'email-already-in-use':
        return "An account already exists for this email.";
      case 'weak-password':
        return "Password must be at least 6 characters.";
      case 'user-not-found':
        return "No user found for this email.";
      case 'wrong-password':
        return "Incorrect password. Try again.";
      case 'too-many-requests':
        return "Too many attempts. Try again later.";
      case 'network-request-failed':
        return "No internet connection. Please try again.";
      default:
        return "An unexpected error occurred. Please try again.";
    }
  }

  Future<void> signUp(UserModel user, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _authService.signUp(user.email, password);

      debugPrint("Signup Firebase Success: UID = ${result.user?.uid}");

      // Add the UID to the user model if needed
      final userWithUid = user.copyWith(uid: result.user?.uid ?? "");

      await _userRepo.createUser(userWithUid);
      await _localStorage.saveUser(userWithUid);
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: ${e.code} - ${e.message}");
      error = _mapFirebaseError(e.code);
    } catch (e) {
      debugPrint("General signup error: $e");
      error = "Something went wrong. Try again.";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.login(email, password);
      final user = await _userRepo.getUser(email);
      if (user != null) {
        await _localStorage.saveUser(user);
      }
    } on FirebaseAuthException catch (e) {
      error = _mapFirebaseError(e.code);
    } catch (_) {
      error = "Something went wrong. Please try again.";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();
      if (result != null) {
        final uid = result.user!.uid;
        final email = result.user!.email!;
        final fullName = result.user!.displayName ?? 'Google User';

        final user = UserModel(uid: uid, fullName: fullName, email: email);

        final existing = await _userRepo.getUser(email);
        if (existing == null) {
          await _userRepo.createUser(user);
        }

        await _localStorage.saveUser(user);
      }
    } on FirebaseAuthException catch (e) {
      error = _mapFirebaseError(e.code);
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      error = "Google login failed. Please try again.";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _authService.sendResetPassword(email);
      // Optionally, show a success snackbar or message
    } on FirebaseAuthException catch (e) {
      error = _mapFirebaseError(e.code);
    } catch (_) {
      error = "Failed to send password reset email. Try again.";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      await _localStorage.clearUser(); // clear locally stored user
      error = null;
    } catch (e) {
      error = "Logout failed. Try again.";
    }

    isLoading = false;
    notifyListeners();
  }
}
