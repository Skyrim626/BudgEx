import 'package:budgex/model/budget.dart';

class ExpenseUsers {
  /* String _fullName = "John Doe";
  String _username = "Username123"; */

  // The unique identifier
  /* String _email = "johnDoe@gmail.com";
  String _password = "johnDoe123"; */

  // List of Budgets of User
  List<Budget> budgets = [];

  String _fullName = "";
  String _email = "";
  int _age = 0;

  ExpenseUsers();

  /* ExpenseUsers.fromMap(Map<String, dynamic> data) {
    _fullName = data['full_name'] ?? "";
    _email = data['email'] ?? "";
    _age = data['age'] ?? 0;
  } */

  /* ExpenseUsers.fromMap(Map<String, dynamic> data) {
    _fullName = data['full_name'] ?? "";
    _email = data['email'] ?? "";
    _age = data['age'] ?? 0;
  }
 */
  // A function that gets the full name of the user in a String data type
  String get getFullName {
    return _fullName;
  }

  // A function that gets the age of the user in a Integer data type
  int get getAge {
    return _age;
  }

  // A function that gets the email of the user in a String data type
  String get getUserEmail {
    return _email;
  }
}
