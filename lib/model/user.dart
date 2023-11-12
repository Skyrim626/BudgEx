import 'package:budgex/model/budget.dart';

class User {
  String _fullName = "John Doe";
  String _username = "Username123";

  // The unique identifier
  String _email = "johnDoe@gmail.com";
  String _password = "johnDoe123";

  // List of Budgets of User
  List<Budget> budgets = [];

  User() {}

  // A function that gets the full name of the user in a String data type
  String get getFullName {
    return _fullName;
  }

  // A function that gets the username of the user in a String data type
  String get getUsername {
    return _username;
  }

  // A function that gets the email of the user in a String data type
  String get getUserEmail {
    return _email;
  }
}
