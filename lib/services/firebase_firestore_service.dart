import 'package:budgex/model/userBudgetModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';

import 'package:budgex/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseFirestoreService {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _firestoreDatabase = FirebaseFirestore.instance;

  // Collection References
  final String _usersCollectionName = "users";
  final String _budgetsCollectionName = "user_budgets";

  // ID of the User
  final String? uid;
  FirebaseFirestoreService({this.uid});

  // A method for adding a new Data to the user collection
  // Data added are:
  // Full name(String) of the user
  // Age(int) of the user
  // Email(string) of the user
  // Date Registered(String) of the user
  Future updateUserProfileData(String fullName, int age, String email) async {
    // Gets the Current Date and Time base on Device Time
    DateTime dateTime = DateTime.now();

    // Formats the Date and Time
    String dateRegistered =
        DateFormat('d MMMM y "at" HH:mm:ss "UTC"Z').format(dateTime);

    return await _firestoreDatabase.collection("users").doc(uid).set({
      'fullName': fullName,
      'age': age,
      'email': email,
      'dateRegistered': dateRegistered,
    });
  }

  // Get User Profile Data
  Stream<QuerySnapshot> get userProfileData {
    return _firestoreDatabase.collection("users").snapshots();
  }

  // Get the current User data
  Stream<UserData?> get currentUserData {
    return _firestoreDatabase.collection("users").doc(uid).snapshots().map(
        (snapshot) =>
            UserData.fromMap(snapshot.data() as Map<String, dynamic>, uid));
  }

  Stream<UserData?> get userDocumentStream {
    final userStream = _firestoreDatabase
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) => _userDataSnapshot(snapshot));

    return _firestoreDatabase
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) => _userDataSnapshot(snapshot));
  }

  UserData? _userDataSnapshot(DocumentSnapshot snapshot) {
    return UserData.fromMap(snapshot.data() as Map<String, dynamic>, uid);
  }

  // Budget List from Snapshot
  /* List<BudgetModel> _budgetListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((budgetData) {
      return BudgetModel(
          uid: budgetData.id,
          dateCreated: budgetData['dateCreated'],
          totalBudget: budgetData['totalBudget']);
    }).toList();
  }

  // Get User Budget Information
  Stream<List<BudgetModel>> get allUserBudgetData {
    return _firestoreDatabase
        .collection("users")
        .doc(uid)
        .collection("budgets")
        .snapshots()
        .map(_budgetListFromSnapshot);
  } */

  /* Future<UserData?> getUserDataByUid(String uid) async {
    try {
      DocumentSnapshot userData =
          await _firestoreDatabase.collection("users").doc(uid).get();

      if (userData.exists) {
        return UserData.fromMap(userData.data() as Map<String, dynamic>);
      } else {
        // Handle the case when the document doesn't exist
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  } */
}
