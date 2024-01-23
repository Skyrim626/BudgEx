import 'package:budgex/model/userBudgetModel.dart';

// Class representing the basic user information
class UserModel {
  final String uid;

  // Constructor for UserModel
  UserModel({required this.uid});

  // Factory method to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
    );
  }
}

// Class representing detailed user data including budget information
class UserData {
  final String uid;
  final String fullName;
  final int age;
  final String email;
  final String dateRegistered;
  final bool firstTimer;

  // BudgetModel object to store budget information
  BudgetModel budget;

  // Constructor for UserData
  UserData({
    required this.uid,
    required this.fullName,
    required this.age,
    required this.email,
    required this.dateRegistered,
    required this.budget,
    required this.firstTimer,
  });

  // Factory method to create a UserData object from a map
  factory UserData.fromMap(Map<String, dynamic> map, String? uid) {
    print("USER DATA OBJECT $map");

    return UserData(
      uid: uid ?? "",
      fullName: map['fullName'] ?? "",
      age: map['age'] ?? 0,
      email: map['email'] ?? "",
      dateRegistered: map['dateRegistered'] ?? "",
      firstTimer: map['firstTimer'],
      budget: BudgetModel.fromMap(
        map['budget'] ?? {},
      ),
    );
  }
}
