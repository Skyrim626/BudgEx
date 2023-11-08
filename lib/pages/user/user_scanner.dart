import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserScanReceipt extends StatefulWidget {
  const UserScanReceipt({super.key});

  @override
  State<UserScanReceipt> createState() => _UserScanReceiptState();
}

class _UserScanReceiptState extends State<UserScanReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner Receipt"),
      ),
      drawer: CustomDrawer(),
    );
  }
}
