import 'package:budgex/model/expense_category.dart';
import 'package:uuid/uuid.dart';

class Budget {
  // A unique key for Budget
  String uuid = const Uuid().toString();

  // Total Budget
  double _totalBudget = 0;

  // List of Categories
  List<ExpenseCategory> expenseCategories = [
    ExpenseCategory(
      categoryName: 'Food',
      iconData: 0xf097,
      left: 0,
      limit: 0,
    ),
    ExpenseCategory(
      categoryName: 'Transportation',
      iconData: 0xf021,
      left: 0,
      limit: 0,
    ),
    ExpenseCategory(
      categoryName: 'Bills',
      iconData: 0xf1e0,
      left: 0,
      limit: 0,
    ),
  ];

  // A constructor for Budget Class
  Budget({required double budget}) {
    _totalBudget = budget;
  }

  String get categoryName {
    return "";
  }

  // A function that gets the the budget
  double get getBudget {
    return _totalBudget;
  }

  // A function that gets the the current budget
  double get getcurrentBudget {
    return _totalBudget - 1234;
  }
}
