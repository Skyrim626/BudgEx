import 'package:budgex/widgets/custom_appbar.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SafeArea(
        child: Column(),
      ),
      drawer: CustomDrawer(),
    );
  }
}
