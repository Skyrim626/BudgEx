import 'package:budgex/model/userCategoryModel.dart';
import 'package:flutter/foundation.dart';

class BudgetModel {
  final String dateCreated;
  final double totalBudget;
  final double currentBudget;
  final double totalExpenses;

  List<UserCategoryModel> userCategories;

  BudgetModel(
      {required this.totalBudget,
      required this.dateCreated,
      required this.currentBudget,
      required this.totalExpenses,
      required this.userCategories});

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    List<UserCategoryModel> userCategories = [];

    // Extract the categories map
    Map<String, dynamic>? categoriesMap = map['categories'];

    // If categoriesMap is not null, transform it into UserCategoryModel instances
    if (categoriesMap != null) {
      userCategories = categoriesMap.entries.map((entry) {
        String categoryName = entry.key;
        Map<String, dynamic> categoryData = entry.value;
        return UserCategoryModel.fromMap({
          'categoryName': categoryName,
          'categoryExpense': categoryData['categoryExpense'],
          'leftLimit': categoryData['leftLimit'],
        });
      }).toList();
    }

    return BudgetModel(
      totalBudget: map['totalBudget'] ?? 0.0,
      currentBudget: map['currentBudget'] ?? 0.0,
      totalExpenses: map['totalExpenses'] ?? 0.0,
      dateCreated: map['budgetCreated'] ?? "",
      userCategories: userCategories,
    );
  }
}
