import 'package:budgex/pages/user/user_change_password.dart';
import 'package:budgex/pages/user/user_expense.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/* import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; */

void main() async {
  // Purpose is to access native code
  /* WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */

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
      /* home: UserExpense(), */
      /* home: UserSettings(), */
      /* home: UserChangePassword(), */
      /* home: UserVerifyCode(), */
      /* theme: lightMode,
      darkTheme: darkMode, */
      /* home: UserSignUp(), */
    );
  }
}
