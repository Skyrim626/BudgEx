import 'package:budgex/model/userExpenseModel.dart';

class UserCategoryModel {
  final String categoryName;
  final int categoryExpense;
  final int leftLimit;
  final String iconData;

  List<UserExpenseModel> expenseEntry;

  UserCategoryModel(
      {required this.categoryName,
      required this.categoryExpense,
      required this.leftLimit,
      required this.iconData,
      required this.expenseEntry});

  factory UserCategoryModel.fromMap(Map<String, dynamic> map) {
    List<UserExpenseModel> userExpenses = [];

    // Extract the expense entries
    Map<String, dynamic>? expensesMap = map['expenses'];

    if (expensesMap == null) {
      expensesMap = {};
    }
    // If expensesMap is not null, transform it into UserExpenseModel instances
    print("SRUPIRSE!!!!!!!!ERORR");
    print(expensesMap);
    if (expensesMap != null) {
      userExpenses = expensesMap.entries.map((entry) {
        print("EXPENSE UUID: ${entry.key}");
        String expenseEntryUUID = entry.key;
        Map<String, dynamic> expenseData = entry.value;

        print(expenseData['description']);
        print(expenseData['expenseName']);
        print(expenseData['transactionDate']);
        print(expenseData['amount']);
        return UserExpenseModel.fromMap({
          'uuid': expenseEntryUUID,
          'description': expenseData['description'],
          'expenseName': expenseData['expenseName'],
          'transactionDate': expenseData['transactionDate'],
          'amount': expenseData['amount'],
        });
      }).toList();
    }

    return UserCategoryModel(
      categoryName: map['categoryName'] ?? "",
      categoryExpense: map['categoryExpense'] ?? 0,
      leftLimit: map['leftLimit'] ?? 0,
      iconData: map['iconData'] ?? '',
      expenseEntry: userExpenses,
    );
  }

  // A method that gets the expense entry name/title by UUID
  String? getExpenseTitleByUUID({required String entryUUID}) {
    for (UserExpenseModel entries in expenseEntry) {
      if (entryUUID == entries.uuid) {
        return entries.expenseName;
      }
    }
  }

  // A method that gets the description the expense entry
  String? getExpenseDescriptionByUUID({required String entryUUID}) {
    for (UserExpenseModel entries in expenseEntry) {
      if (entryUUID == entries.uuid) {
        return entries.description;
      }
    }
  }
}
