import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      debugPrint("🔹 Attempting to sign up with email: $email");
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("✅ Sign up successful! UID: ${userCredential.user?.uid}");
      return userCredential;
    } catch (e) {
      debugPrint("❌ Sign up error: $e");
      rethrow;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      debugPrint("🔹 Attempting to sign in with email: $email");
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("✅ Login successful! UID: ${userCredential.user?.uid}");
      return userCredential;
    } catch (e) {
      debugPrint("❌ Login error: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      debugPrint("🔹 Logging out...");
      await _auth.signOut();
      debugPrint("✅ User successfully signed out.");
    } catch (e) {
      debugPrint("❌ Sign out error: $e");
      rethrow;
    }
  }

  User? getCurrentUser() {
    final user = _auth.currentUser;
    debugPrint("👤 Current user: ${user?.email ?? 'No user logged in'}");
    return user;
  }
}
