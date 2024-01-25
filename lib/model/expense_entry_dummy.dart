import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ExpenseEntry {
  Uuid? uuid;
  String? expenseTitle;
  String? dateCreated;

  // TO BE ANAYZE
  String? currency;
  int? amount;
  String? description;
  Image? image;
  Category? category;

  ExpenseEntry() {}

  // This is a sample data only
  final List<Map<String, String>> expenseEntries = [
    {
      "id": "1",
      "report_date": "2023-05-02",
      "title": "Jolibee",
      "amount": "1000"
    },
    {
      "id": "2",
      "report_date": "2023-05-03",
      "title": "Greenich",
      "amount": "5000"
    },
    {"id": "3", "report_date": "2023-05-04", "title": "McDo", "amount": "450"},
    {
      "id": "4",
      "report_date": "2023-05-05",
      "title": "Shakeys",
      "amount": "300"
    },
    {
      "id": "5",
      "report_date": "2023-05-06",
      "title": "Chowking",
      "amount": "50"
    },
  ];

  // A function that gets all the expense entries
  get listExpenses {
    return expenseEntries;
  }
}
