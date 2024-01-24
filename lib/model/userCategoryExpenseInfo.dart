import 'package:budgex/model/userCategoryModel.dart';
import 'package:budgex/model/userExpenseModel.dart';

class UserCategoryExpenseInfo {
  final String uuid;
  final String expenseTitle;
  final String categoryType;
  final String transactionDate;
  final double amount;
  final UserExpenseModel userExpenseInfo;

  UserCategoryExpenseInfo({
    required this.uuid,
    required this.expenseTitle,
    required this.categoryType,
    required this.transactionDate,
    required this.amount,
    required this.userExpenseInfo,
  });
}
