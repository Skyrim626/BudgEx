import 'package:budgex/model/userModel.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/theme_provider.dart';
import 'package:budgex/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Purpose is to access native code
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: ((context) => ThemeProvider()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: FirebaseAuthService().user,
      initialData: null,
      builder: (context, snapshot) {
        return MaterialApp(
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ThemeProvider>(context).themeData,
        );
      },
    );
  }
}
