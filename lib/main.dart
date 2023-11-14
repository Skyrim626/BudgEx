import 'package:budgex/pages/user/onboarding_screen.dart';
import 'package:budgex/pages/user/user_budgeting.dart';
import 'package:budgex/pages/other_screens/auth_page.dart';
import 'package:budgex/pages/user/user_login.dart';
import 'package:budgex/pages/user/user_settings.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/*  import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  */

void main() async {
  // Purpose is to access native code
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  /* await Hive.initFlutter(); */

  // Open the Box (Local Database is placed in the phone)
  /* var expenseStorage = await Hive.openBox('expenseStorage'); */

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
      /* home: AuthPage(), */
      /* home: const OnBoardingScreen(), */
      home: UserBudgeting(),
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
