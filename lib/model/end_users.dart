import 'package:cloud_firestore/cloud_firestore.dart';

/* class EndUsers {
  final String? email;
  final String? age;
  final String? fullName;

  EndUsers({this.email, this.age, this.fullName});

  factory EndUsers.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EndUsers(
      fullName: data?['full_name'],
      email: data?['email'],
      age: data?['age'].toString(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (fullName != null) "full_name": fullName,
      if (age != null) "age": age,
    };
  }
} */

class EndUser {}
