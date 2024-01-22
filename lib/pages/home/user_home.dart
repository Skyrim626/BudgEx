import 'package:budgex/model/category_model_dummy.dart';
import 'package:budgex/pages/constants/constants.dart';
import 'package:budgex/pages/home/main_home.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:budgex/services/firebase_firestore_service.dart';
import 'package:budgex/widgets/customDetectorCategory.dart';
import 'package:budgex/widgets/custom_button.dart';
import 'package:budgex/widgets/custom_circle_chart.dart';
import 'package:budgex/widgets/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budgex/model/userModel.dart';

// ignore: must_be_immutable
class UserHomepage extends StatefulWidget {
  UserHomepage();

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  // Open Firebase Auth Service
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      value: FirebaseFirestoreService(uid: _authService.getCurrentUser().uid)
          .userDocumentStream,
      initialData: null,
      child: HomeFeature(),
    );
  }
}
