class BudgetModel {
  final String uid;
  final String dateCreated;
  final double totalBudget;
  final double currentBudget;
  final double totalExpenses;

  BudgetModel(
      {required this.uid,
      required this.totalBudget,
      required this.dateCreated,
      required this.currentBudget,
      required this.totalExpenses});

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
        uid: map['uid'] ?? "",
        totalBudget: map['totalBudget'] ?? 0.0,
        currentBudget: map['currentBudget'] ?? 0.0,
        totalExpenses: map['totalExpenses'] ?? 0.0,
        dateCreated: map['dateCreated'] ?? "");
  }
}
