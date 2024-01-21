class Budgets {
  final String budgetID;

  final double currentBudget;
  final double totlaBudget;
  final double totalExpenses;

  Budgets(
      {required this.budgetID,
      required this.currentBudget,
      required this.totlaBudget,
      required this.totalExpenses});

  factory Budgets.fromMap(Map<String, dynamic> map) {
    return Budgets(
        budgetID: map["budget_id"],
        currentBudget: map["current_budget"],
        totlaBudget: map["total_budget"],
        totalExpenses: map["total_expenses"]);
  }
}
