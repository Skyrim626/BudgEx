import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserBudgeting extends StatefulWidget {
  const UserBudgeting({super.key});

  @override
  State<UserBudgeting> createState() => _UserBudgetingState();
}

class _UserBudgetingState extends State<UserBudgeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budgeting"),
      ),
      drawer: CustomDrawer(),
    );
  }
}
