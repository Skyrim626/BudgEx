class UserCategoryModel {
  final String categoryName;
  final double categoryExpense;
  final double leftLimit;
  final String iconData;

  UserCategoryModel(
      {required this.categoryName,
      required this.categoryExpense,
      required this.leftLimit,
      required this.iconData});

  factory UserCategoryModel.fromMap(Map<String, dynamic> map) {
    print("HELLO THIS IS A MAP");
    print(map['iconData']);
    print(map['categoryExpense']);
    print(map['leftLimit']);
    return UserCategoryModel(
        categoryName: map['categoryName'] ?? "",
        categoryExpense: map['categoryExpense'] ?? 0,
        leftLimit: map['leftLimit'] ?? 0,
        iconData: map['iconData'] ?? '');
  }
}
