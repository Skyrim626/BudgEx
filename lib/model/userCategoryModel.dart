class UserCategoryModel {
  final String categoryName;
  final double categoryExpense;
  final double leftLimit;

  UserCategoryModel({
    required this.categoryName,
    required this.categoryExpense,
    required this.leftLimit,
  });

  factory UserCategoryModel.fromMap(Map<String, dynamic> map) {
    return UserCategoryModel(
        categoryName: map['categoryName'] ?? "",
        categoryExpense: map['categoryExpense'] ?? 0,
        leftLimit: map['leftLimit'] ?? 0);
  }
}
