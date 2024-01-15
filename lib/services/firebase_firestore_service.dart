import 'package:budgex/model/end_users.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreService {
  final _firestoreDatabase = FirebaseFirestore.instance;

  // An instance of the EndUser class to store the retrieved user data.
  late EndUser endUser;

// A method to fetch user data from Firestore based on the user's email.
  Future<EndUser> getUserDataByEmail() async {
    final FirebaseAuthService auth = FirebaseAuthService();

    // Reference to the 'users' collection in Firestore.
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Perform a query to get the user with the specified email
    QuerySnapshot querySnapshot = await users
        .where('email', isEqualTo: auth.getCurrentUser().email.toString())
        .get();

    // Get the first document (assuming there is only one user with the specified email)
    var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

    // Convert the retrieved data into an EndUser object
    endUser = EndUser.fromMap(userData);

    // Return the EndUser object containing user data
    return endUser;
  }

  // Function to add a new user to Firestore
  Future<void> addUser({
    required String fullName, // Full name of the user
    required int age, // Age of the user
    required String email, // Email address of the user
  }) async {
    DateTime dateTime = DateTime(2024, 1, 31, 14, 17, 3);

    String formattedDate =
        DateFormat('d MMMM y "at" HH:mm:ss "UTC"Z').format(dateTime);

    // Using the Firestore database instance to access the "users" collection
    await _firestoreDatabase.collection("users").add({
      'fullName': fullName, // Storing user's full name in the document
      'age': age, // Storing user's age in the document
      'email': email,
      'dateRegistered': formattedDate, // Storing user's email in the document
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

        print("USER DATA");
        print(userData);
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
