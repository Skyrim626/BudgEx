import 'package:budgex/model/userBudgetModel.dart';

class UserModel {
  final String uid;

  UserModel({required this.uid});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
    );
  }
}

class UserData {
  final String uid;
  final String fullName;
  final int age;
  final String email;
  final String dateRegistered;

  BudgetModel budget;

  UserData(
      {required this.uid,
      required this.fullName,
      required this.age,
      required this.email,
      required this.dateRegistered,
      required this.budget});

  factory UserData.fromMap(Map<String, dynamic> map, String? uid) {
    return UserData(
      uid: uid ?? "",
      fullName: map['fullName'] ?? "",
      age: map['age'] ?? 0,
      email: map['email'] ?? "",
      dateRegistered: map['dateRegistered'] ?? "",
      budget: BudgetModel.fromMap(map['budget'] ?? {}),
    );
  }
}
