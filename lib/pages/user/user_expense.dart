import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserExpense extends StatefulWidget {
  const UserExpense({super.key});

  @override
  State<UserExpense> createState() => _UserExpenseState();
}

class _UserExpenseState extends State<UserExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
      ),
      drawer: CustomDrawer(),
    );
  }
}
