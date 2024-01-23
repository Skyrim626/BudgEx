import 'package:flutter/material.dart';

class CategoryData {
  String iconData;
  String categoryName;
  double leftLimit;
  double categoryExpense;

  CategoryData({
    required this.iconData,
    required this.categoryName,
    required this.leftLimit,
    required this.categoryExpense,
  });
}

List<CategoryData> sampleCategories = [
  CategoryData(
    iconData: "0xe59c",
    categoryName: 'Groceries',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe532",
    categoryName: 'Dining Out',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  /* CategoryData(
    iconData: "0xe25a",
    categoryName: 'Fast Food',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe87d",
    categoryName: 'Transportation',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe595",
    categoryName: 'Utilities',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe8b1",
    categoryName: 'Entertainment',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe8cc",
    categoryName: 'Shopping',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe8d1",
    categoryName: 'Health',
    leftLimit: 0,
    categoryExpense: 0,
  ),
  CategoryData(
    iconData: "0xe8f5",
    categoryName: 'Education',
    leftLimit: 0,
    categoryExpense: 0,
  ), */
  // Add more categories as needed
];
