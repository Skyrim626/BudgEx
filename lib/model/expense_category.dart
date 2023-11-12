import 'package:budgex/model/expense.dart';

class ExpenseCategory {
  String _categoryName = "";
  int _iconData = 0;
  double limit = 0;
  double left = 0;

  List<Expense> expenses = [];

  // A constructor for Expense Category
  ExpenseCategory({
    required String categoryName,
    required int iconData,
    required double limit,
    required double left,
  }) {
    _categoryName = categoryName;
    _iconData = iconData;
  }

  // A function that gets the name of th category
  String get getCateogryName {
    return _categoryName;
  }
}
