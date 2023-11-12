import 'package:budgex/pages/user/user_budgeting.dart';
import 'package:flutter/material.dart';

class UserCategoryExpense extends StatefulWidget {
  const UserCategoryExpense({super.key});

  @override
  State<UserCategoryExpense> createState() => _UserCategoryExpenseState();
}

class _UserCategoryExpenseState extends State<UserCategoryExpense> {
  // A function that allows the user to return to the Budgeting Screen
  void toBudgetingScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserBudgeting(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.tertiary,
            )),
      ),
    );
  }
}
