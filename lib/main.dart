import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/theme.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: ((context) => ThemeProvider()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLogin(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      /* theme: lightMode,
      darkTheme: darkMode, */
      /* home: UserSignUp(), */
    );
  }
}
