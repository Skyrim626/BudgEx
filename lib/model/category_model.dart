import 'package:budgex/model/expense_entry.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> dummyCategories = [
  {
    "categoryName": 'Food',
    "categoryIconData": 0xf097,
  },
  {
    "categoryName": 'Transportation',
    "categoryIconData": 0xf021,
  },
  {
    "categoryName": 'Baby Stuff',
    "categoryIconData": 0xeec8,
  },
  {
    "categoryName": 'Bills',
    "categoryIconData": 0xf1e0,
  },
  {
    "categoryName": 'Business Expense',
    "categoryIconData": 0xef0b,
  },
  {
    "categoryName": 'Cable',
    "categoryIconData": 0xef0d,
  },
];

List<Map<String, dynamic>> allCategories = [
  {
    "categoryName": 'Food',
    "categoryIcon": 0xf097,
  },
  {
    "categoryName": 'Transportation',
    "categoryIcon": 0xf021,
  },
  {
    "categoryName": 'Baby Stuff',
    "categoryIcon": 0xeec8,
  },
  {
    "categoryName": 'Bills',
    "categoryIcon": 0xf1e0,
  },
  {
    "categoryName": 'Business Expense',
    "categoryIcon": 0xef0b,
  },
  {
    "categoryName": 'Cable',
    "categoryIcon": 0xef0d,
  },
  {
    "categoryName": 'Car',
    "categoryIcon": Icons.car_rental_outlined,
  },
  {
    "categoryName": 'Credit Card Payments',
    "categoryIcon": Icons.credit_card_outlined,
  },
  {
    "categoryName": 'Educational',
    "categoryIcon": Icons.school_outlined,
  },
  {
    "categoryName": 'Electricity (Utility Bills)',
    "categoryIcon": Icons.miscellaneous_services_outlined,
  },
  {
    "categoryName": 'Food Delivery',
    "categoryIcon": Icons.delivery_dining_outlined,
  },
  {
    "categoryName": 'Games and Gaming',
    "categoryIcon": Icons.games_outlined,
  },
  {
    "categoryName": 'Gas',
    "categoryIcon": Icons.gas_meter_outlined,
  },
  {
    "categoryName": 'Groceries',
    "categoryIcon": Icons.local_grocery_store_outlined,
  },
  {
    "categoryName": 'Home',
    "categoryIcon": Icons.home_max_outlined,
  },
  {
    "categoryName": 'Insurance (Others)',
    "categoryIcon": Icons.family_restroom_outlined,
  },
  {
    "categoryName": 'Internet',
    "categoryIcon": Icons.home_max_outlined,
  },
];

class CategoryModel {
  String? _categoryName;
  String? _budgetLimit;
  String? _totalExpenses;
  List<ExpenseEntry>? expenses;
  /* List<String>? names = getAllCategoriesName; */

  CategoryModel({budgetLimit, totalExpenses, categoryName}) {
    _budgetLimit = budgetLimit;
    _totalExpenses = totalExpenses;
    _categoryName = categoryName;
  }

  // A function that gets all the name of each categories
  // Returns a List of String type representation of Category name
  List<String> get getAllCategoriesName {
    // Empty List
    List<String> categoryNames = [];

    // Loops and gets the cateogory name
    for (var category in allCategories) {
      String categoryName = category['categoryName'];
      categoryNames.add(categoryName);
    }

    return categoryNames;
  }

  // A function that gets all the categories
  get getAllCategories {
    return allCategories;
  }
}
