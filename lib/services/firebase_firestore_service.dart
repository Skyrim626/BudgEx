import 'package:budgex/data/categoryData.dart';
import 'package:budgex/model/userBudgetModel.dart';
import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userExpenseModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';
import 'package:budgex/model/userModel.dart';

import 'package:budgex/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  // Update the Full Name of the user in Firestore
  Future<void> updateFullName(
      {required String newFullName, required String uuid}) async {
    try {
      await _firestoreDatabase.collection("users").doc(uuid).update({
        'fullName': newFullName,
      });
    } catch (e) {
      print("Error updating full name: $e");
      // Handle error as needed
    }
  }

  // A method that updates the current budget in the firestore
  Future<void> updateCurrentBudget(
      {required String uuid, required int newCurrentBudget}) async {
    try {
      await _firestoreDatabase.collection("users").doc(uuid).update({
        'budget.currentBudget': newCurrentBudget,
      });
    } catch (e) {
      print("Error updating full name: $e");
      // Handle error as needed
    }
  }

  // A method that edits the expense title
  Future<void> updateExpenseTitle(
      {required String userUUID,
      required String expenseUUID,
      required String newExpenseTitle,
      required String categoryName}) async {
    try {
      await _firestoreDatabase.collection("users").doc(userUUID).update({
        'budget.categories.$categoryName.expenses.$expenseUUID.expenseName':
            newExpenseTitle
      });
    } catch (e) {
      print("Error updating full name: $e");
      // Handle error as needed
    }
  }

  // A method that edits the expense description
  Future<void> updateExpenseDescription(
      {required String userUUID,
      required String expenseUUID,
      required String newExpenseDescription,
      required String categoryName}) async {
    try {
      await _firestoreDatabase.collection("users").doc(userUUID).update({
        'budget.categories.$categoryName.expenses.$expenseUUID.description':
            newExpenseDescription
      });
    } catch (e) {
      print("Error updating full name: $e");
      // Handle error as needed
    }
  }

  // Update the Age of the user in the Firestore
  Future<void> updateAge({required int age, required String uuid}) async {
    try {
      await _firestoreDatabase
          .collection('users')
          .doc(uuid)
          .update({'age': age});
    } catch (e) {
      print("Error updating age $e");
    }
  }

  // Deletes the document of the user permanently
  Future<void> deleteAccountDocument({
    required String uuid,
    required User user,
  }) async {
    // Deletes the document of the firestore
    await _firestoreDatabase.collection("users").doc(uuid).delete();
  }

  // Deletes an expense entry to the firestore
  Future<void> deleteExpense({
    required String uuid,
    required String expenseUUID,
    required String categoryType,
    required int categoryExpense,
    required int categoryLeftLimit,
    required int currentBudget,
    required int totalBudgetExpense,
  }) async {
    print("DELETED");
    print("Exepense ID : $expenseUUID");
    try {
      /* await _firestoreDatabase.collection('users').doc(uuid).update({
        'budget': {
          'categories': {
            categoryType: {
              'expenses': {expenseUUID: FieldValue.delete()}
            }
          }
        }
      }); */

      // Updates the budget
      // Returns the amount of the expense entry before deletion
      await _firestoreDatabase.collection('users').doc(uuid).update({
        'budget.currentBudget': currentBudget,
        'budget.totalExpenses': totalBudgetExpense,
        'budget.categories.$categoryType.categoryExpense': categoryExpense,
        'budget.categories.$categoryType.leftLimit': categoryLeftLimit,
      });
      /* await _firestoreDatabase.collection('users').doc(uuid).update({
        'budget': {
          'currentBudget': currentBudget,
          'totalExpenses': totalBudgetExpense,
          'categories': {
            categoryType: {
              'categoryExpense': categoryExpense,
              'leftLimit': categoryLeftLimit,
            }
          }
        }
      });
 */
      // Deletes the expense entry
      await _firestoreDatabase.collection('users').doc(uuid).update({
        'budget.categories.$categoryType.expenses.$expenseUUID':
            FieldValue.delete(),
      });
    } catch (e) {
      print("Error deleting expse $e");
    }
  }

  // A method that deletes the category of the user to the Firestore
  Future<void> deleteCategoryUser(
      {required String uuid,
      required List<UserCategoryModel> categories}) async {
    /* return await _firestoreDatabase.collection("users").doc(uuid).set({
      'budget': {
        'categories': categoriesMap,
      }
    }, SetOptions(merge: true));  */

    // Empty Map for storing Categories
    Map categoriesMap = {};

    print(
        "-------------------------------------------deleteCategoryUser AREA-------------------------------------------");
    print("To the FireStore");
    print("USER UUID: $uuid");
  }

  // A method to store new expense transaction in the specific category
  Future<void> addNewExpense({
    required String uuid,
    required String categoryName,
    required UserExpenseModel expenseEntry,
    required int currentBudget,
    required int totalExpenses,
    required int categoryExpense,
    required int leftLimit,
  }) async {
    print(
        "------------------------------------------- addNewExpense AREA-------------------------------------------");
    print("To the FireStore");
    print("USER UUID: $uuid");
    print("EXPENSE UUID321321: ${expenseEntry.uuid}");
    print(expenseEntry.amount);
    print(expenseEntry.description);
    print(expenseEntry.expenseName);
    print(expenseEntry.transactionDate);

    print("INFO");
    print("Current budget: $currentBudget");
    print("Total Expense: $totalExpenses");
    print("CategoryExpense: $categoryExpense");
    print("Left Limit: $leftLimit");

    return await _firestoreDatabase.collection('users').doc(uuid).set(
        {
          'budget': {
            'totalExpenses': totalExpenses,
            'currentBudget': currentBudget,
            'categories': {
              categoryName: {
                'leftLimit': leftLimit,
                'categoryExpense': categoryExpense,
                'expenses': {
                  expenseEntry.uuid: {
                    'amount': expenseEntry.amount,
                    'description': expenseEntry.description,
                    'expenseName': expenseEntry.expenseName,
                    'transactionDate': expenseEntry.transactionDate,
                  }
                }
              }
            }
          }
        },
        SetOptions(
          merge: true,
        ));
  }

  // A method that stores the category of the user to the Firestore
  Future<void> updateCategoryUser(
      {required String uuid,
      required List<UserCategoryModel> categories}) async {
    // Empty Map for storing Categories
    Map categoriesMap = {};

    // Default Category Expense
    int categoryExpense = 0;
    print(
        "------------------------------------------- updateCategoryUser AREA-------------------------------------------");
    print("To the FireStore");
    print("USER UUID: $uuid");
    for (UserCategoryModel category in categories) {
      print(category.categoryName);
      print(category.iconData);
      print(category.leftLimit);
      print(categoryExpense);
      print('------------------');

      categoriesMap[category.categoryName] = {
        'categoryExpense': categoryExpense,
        'leftLimit': category.leftLimit,
        'iconData': category.iconData,
      };
    }

    /*  return await _firestoreDatabase.collection("users").doc(uuid).update({
      'budget': budget,
      'firstTimer': firstTimer,
    }); */

    return await _firestoreDatabase.collection("users").doc(uuid).set({
      'budget': {
        'categories': categoriesMap,
      }
    }, SetOptions(merge: true));
  }

  // Method for storing new budget of the user to the FireStore
  Future<void> updateBudgetUser(
      {required int budgetDeclared,
      required String uuid,
      required List<CategoryData> categories}) async {
    // Gets the Current Date and Time base on Device Time
    DateTime dateTime = DateTime.now();

    // Formats the Date and Time
    String dateRegistered =
        DateFormat('d MMMM y "at" HH:mm:ss "UTC"Z').format(dateTime);

    // Default Budget Expense
    int totalBudget = budgetDeclared;
    int totalExpense = 0;
    int currentBudget = totalBudget;

    // Default Category Expense
    int categoryExpense = 0;

    // Sets the firstTimer to true;
    bool firstTimer = false;

    // Empty Category Map
    // User to store categories
    Map categoriesMap = {};

    for (CategoryData category in categories) {
      print(category.categoryName);
      print(category.iconData);
      print(category.leftLimit);
      print(categoryExpense);
      print('------------------');

      categoriesMap[category.categoryName] = {
        'categoryExpense': categoryExpense,
        'leftLimit': category.leftLimit,
        'iconData': category.iconData,
      };
    }

    Map budget = {
      'currentBudget': currentBudget,
      'totalExpenses': totalExpense,
      'totalBudget': totalBudget,
      'budgetCreated': dateRegistered,
      'categories': categoriesMap
    };

    return await _firestoreDatabase.collection("users").doc(uuid).update({
      'budget': budget,
      'firstTimer': firstTimer,
    });
  }

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

    Map budget = {"currentBudget": 0, "totalExpenses": 0, "totalBudget": 0};

    return await _firestoreDatabase.collection("users").doc(uid).set({
      'fullName': fullName,
      'age': age,
      'email': email,
      'dateRegistered': dateRegistered,
      'budget': budget,
      'firstTimer': true
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
    return _firestoreDatabase
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) => _userDataSnapshot(snapshot));
  }

  Stream<UserData?> get userMainDocumentStream {
    return _firestoreDatabase
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapshot) => _userDataSnapshotTest(snapshot));
  }

  UserData? _userDataSnapshotTest(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      return UserData.fromMap(snapshot.data() as Map<String, dynamic>, uid);
    } else {
      // Handle the case when the document doesn't exist
      return null;
    }
  }

  UserData? _userDataSnapshot(DocumentSnapshot snapshot) {
    UserData? sampleData =
        UserData.fromMap(snapshot.data() as Map<String, dynamic>, uid);

    print("_userDataSnapshot SECTION");
    print(sampleData.dateRegistered);
    return UserData.fromMap(snapshot.data() as Map<String, dynamic>, uid);
  }
}
