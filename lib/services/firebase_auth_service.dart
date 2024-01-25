import 'package:budgex/model/userModel.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Creates an userModel object based on Firebase User Object
  UserModel? _userModelFromFirebase(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
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

      // Fetch the user data
      User? user = result.user;

      // TESTING PURPOSES ONLY
      /* print("---------------METHOD AREA---------------");
      print("registerWithEmailAndPassword output");
      print(user);
      print("-----------------------------------------"); */

      // Creates a new document for the user with the uid
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

  // Method Sign in with email & password
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
      // print(e.toString());
      return null;
    }
  }

  // A function that gets the current user
  User getCurrentUser() {
    User user = _auth.currentUser!;
    return user;
  }
}
