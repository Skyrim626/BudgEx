import 'package:budgex/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseFirestoreService {
  final _firestoreDatabase = FirebaseFirestore.instance;

  /* Future<Map<String, dynamic>> getUserDataByEmail(String email) async {
    try {
      // Query Firestore to get user data based on email
      QuerySnapshot querySnapshot = await _firestoreDatabase
          .collection("users")
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, return the data
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        // User not found
        return {};
      }
    } catch (e) {
      // Handle errors
      print('Error getting user data by email: $e');
      return {};
    }
  } */

  /* Future<Map<String, dynamic>> getUserDataByEmail(String? email) async {
    try {
      // Query Firestore to get user data based on email
      QuerySnapshot querySnapshot = await _firestoreDatabase
          .collection("users")
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, return the data
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        // User not found
        return {};
      }
    } catch (e) {
      // Handle errors
      print('Error getting user data by email: $e');
      return {};
    }
  } */

  // Function to add a new user to Firestore
  Future<void> addUser({
    required String fullName, // Full name of the user
    required int age, // Age of the user
    required String email, // Email address of the user
  }) async {
    // Using the Firestore database instance to access the "users" collection
    await _firestoreDatabase.collection("users").add({
      'full_name': fullName, // Storing user's full name in the document
      'age': age, // Storing user's age in the document
      'email': email, // Storing user's email in the document
    }).then((DocumentReference doc) =>
        // After the document is successfully added, print a message with the document ID
        {print('DocumentSnapshot added with ID: ${doc.id}')});
  }

  // A function that fetch users data
  Future<Map<String, dynamic>> getUserData() async {
    final FirebaseAuthService auth = FirebaseAuthService();

    try {
      // Get the current user
      User? user = auth.getCurrentUser();

      // Fetch additional user data from Firestore
      DocumentSnapshot userDoc =
          await _firestoreDatabase.collection("users").doc(user.uid).get();
      if (userDoc.exists) {
        // User document exists in Firestore
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        return userData;
      } else {
        // User document does not exist in Firestore
        return {};
      }
    } catch (e) {
      // Handle errors
      if (kDebugMode) {
        print('Error getting user data: $e');
      }
      return {};
    }
  }
}
