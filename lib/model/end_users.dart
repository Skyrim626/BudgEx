// A class representing the End User with essential user details.
import 'package:budgex/model/budgets.dart';

class EndUser {
  // User's full name.
  final String fullName;

  // User's age.
  final int age;

  // User's email address.
  final String email;

  // User's budget
  final List<Budgets> allUserBudgets;

  // List<Budgets> budgets = [];

  // Constructor for creating an EndUser instance.
  EndUser(
      {required this.fullName,
      required this.age,
      required this.email,
      required this.allUserBudgets});

  // Factory method to create an EndUser instance from a map of data.
  factory EndUser.fromMap(Map<String, dynamic> map) {
    // Create and return an EndUser instance with data from the map.
    return EndUser(
      fullName: map["fullName"] ??
          '', // Default to an empty string if fullName is null.
      age: map["age"] ?? 0, // Default to 0 if age is null.
      email: map["email"] ?? "",
      allUserBudgets: (map["budgets"] as List<dynamic>? ?? [])
          .map((budgetMap) => Budgets.fromMap(budgetMap))
          .toList(), // Default to an empty list if ArrayList is null.
    );
  }

  get getFullName {
    return fullName;
  }

  get getAge {
    return age;
  }

  get getUserEmail {
    return email;
  }

  void addAllBudget({required List<Budgets> budgets}) {
    for (Budgets budget in budgets) {
      print(budget.toString());
    }

    allUserBudgets.addAll(budgets);
  }
}
