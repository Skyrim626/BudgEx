class UserExpenseModel {
  final String uuid;
  final String expenseName;
  final int amount;
  final String description;
  final String transactionDate;

  UserExpenseModel(
      {required this.uuid,
      required this.expenseName,
      required this.amount,
      required this.description,
      required this.transactionDate});

  factory UserExpenseModel.fromMap(Map<String, dynamic> map) {
    return UserExpenseModel(
        uuid: map['uuid'],
        expenseName: map['expenseName'],
        amount: map['amount'],
        description: map['description'],
        transactionDate: map['transactionDate']);
  }

  // A method that gets the amount of the expense entry
  int get getAmount {
    return amount;
  }
}
