class UserExpenseModel {
  final String uuid;
  final String expenseName;
  final double amount;
  final String description;
  final String transactionDate;

  UserExpenseModel(
      {required this.uuid,
      required this.expenseName,
      required this.amount,
      required this.description,
      required this.transactionDate});

  factory UserExpenseModel.fromMap(Map<String, dynamic> map) {
    print("SRUPIRSE!!!!!!!!1EXPENSE");
    return UserExpenseModel(
        uuid: map['uuid'],
        expenseName: map['expenseName'],
        amount: map['amount'],
        description: map['description'],
        transactionDate: map['transactionDate']);
  }
}
