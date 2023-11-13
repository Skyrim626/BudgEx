import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Attempts to sign in a user with the provided email and password.
  ///
  /// If the sign-in is successful, the function returns `true`.
  /// If there's an error during the sign-in, the function prints the error
  /// message and returns `false`.
  ///
  /// Parameters:
  ///   - [email]: The email address of the user.
  ///   - [password]: The password of the user.
  ///
  /// Returns:
  ///   - A [Future<bool>] representing the success or failure of the sign-in.
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Attempt to sign in with the provided email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // If sign-in is successful, return true
      return true;
    } on FirebaseAuthException catch (e) {
      // If there's an error during sign-in, print the error message
      if (kDebugMode) {
        print(e);
      }

      // Return false to indicate sign-in failure
      return false;
    }
  }

  /// Signs the current user out.
  ///
  /// This function calls the Firebase authentication service to sign out the
  /// currently authenticated user.
  ///
  /// Returns:
  ///   - A [Future<void>] representing the completion of the sign-out process.
  Future<void> signOut() async {
    // Call the Firebase authentication service to sign out the user
    await _auth.signOut();
  }

  /* Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  } */

  // A function that gets the current user
  User getCurrentUser() {
    User user = _auth.currentUser!;
    return user;
  }

  /// Initiates a password reset process by sending a reset email to the specified [email].
  /// Returns true if the email is successfully sent, false otherwise.
  Future<bool> passwordReset({required String email}) async {
    try {
      // Send password reset email using Firebase authentication
      await _auth.sendPasswordResetEmail(email: email);

      // Password reset email sent successfully
      return true;
    } on FirebaseAuthException catch (e) {
      // An error occurred during password reset
      return false;
    }
  }

  Future<void> createUserEmailAndPassword(
      {required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  /// Provides a [Stream] that emits changes in the authentication state.
  ///
  /// This [Stream] allows you to listen for changes in the authentication state,
  /// such as when a user signs in or signs out. It emits [User] objects
  /// representing the current authenticated user or `null` if no user is
  /// authenticated.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
