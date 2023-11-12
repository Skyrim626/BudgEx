import 'package:budgex/model/category_model_dummy.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

/* import 'package:flutter/material.dart'; */

class Budget_Dummy {
  // Generates a current date and time
  DateTime _now = DateTime.now();

  // Unique Identifier for the budget
  Uuid _uuid = Uuid();

  // Total Budget
  double? _totalBudget = 0;

  // Total Expenses on the specific Budget
  double? _totalExpenses;

  // Budget Remaining
  double? _currentBudget;
  /* List<ExpenseEntry>? _expenses; */
  final List<CategoryModel> _listCategories = [];
  String? _dateCreated;
  String? _timeCreated;

  Budget({required double totalBudget}) {
    // Generate Time
    _totalBudget = totalBudget;
    _dateCreated = generateDateNow();
    _timeCreated = generateTimeNow();

    // GENERATES THE CATEGORIES
    _generateCategory();
  }

  List<CategoryModel> get getAllCategories {
    return _listCategories;
  }

  // A function that returns the total Budget in a double type
  double? get getTotalBudget {
    return _totalBudget;
  }

  void _generateCategory() {
    for (var category in allCategories) {
      String categoryName = category['categoryName'];
      _listCategories.add(CategoryModel(categoryName: categoryName));
    }
  }

  // A function that generates the current date
  // NOTE: THE DATE FORMAT IS YEAR-MONTH-DAY
  // RETURNS A STRING OF THE CURRENT DATE
  get generateDateNow {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(_now);

    return formatted.toString();
  }

  /// A function that generates a 12 hour format
  /// NOTE: THE CURRENT TIME FORMAT IS 24
  /// RETURNS A STRING of 12 Hour format
  get generateTimeNow {
    return DateFormat.jm().format(_now).toString();
  }
}
