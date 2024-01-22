import 'package:budgex/model/userModel.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Creates an userModel object based on Firebase User Object
  UserModel? _userModelFromFirebase(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  // Method for Sign in anonymously, it's an asynchronous task, it's going to return a future
  Future<UserModel?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userModelFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method for Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userModelFromFirebase);
  }

  // Method for register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      Map<String, dynamic> userInformation) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // TESTING PURPOSES ONLY
      // Fetch the user data
      User? user = result.user;

      print("---------------METHOD AREA---------------");
      print("registerWithEmailAndPassword output");
      print(user);
      print("-----------------------------------------");

      // Create a new document for the user with the uid
      await FirebaseFirestoreService(uid: user!.uid).updateUserProfileData(
          userInformation['fullName'],
          userInformation['age'],
          userInformation['email']);

      return user;
    } catch (e) {
      print("---------------METHOD ERROR AREA---------------");
      print("registerWithEmailAndPassword output");
      print("-----------------------------------------");

      print(e.toString());

      return null;
    }
  }

  // Method for Signing Out
  Future signUserOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Sign Out Method Error:");
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userModelFromFirebase(
          user); // Changes User to to a UserModel Object for OOP
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Signs the current user out.
  ///
  /// This function calls the Firebase authentication service to sign out the
  /// currently authenticated user.
  ///
  /// Returns:
  ///   - A [Future<void>] representing the completion of the sign-out process.
  Future signOut() async {
    // Call the Firebase authentication service to sign out the user
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
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
    } on FirebaseAuthException {
      // An error occurred during password reset
      return false;
    }
  }

  /// Creates a  new account for the new user
  /// Creates a new email and password for authentication
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
  // auth change user stream
  Stream<UserModel?> get onAuthStateChanged {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userModelFromFirebase(user));
        .map(_userModelFromFirebase);
  }
}
