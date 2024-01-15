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

// A class representing the End User with essential user details.
class EndUser {
  // User's full name.
  final String fullName;

  // User's age.
  final int age;

  // User's email address.
  final String email;

  // Constructor for creating an EndUser instance.
  EndUser({required this.fullName, required this.age, required this.email});

  // Factory method to create an EndUser instance from a map of data.
  factory EndUser.fromMap(Map<String, dynamic> map) {
    print(
        "SCANNED"); // Print a debug message indicating that data is being processed.

    // Create and return an EndUser instance with data from the map.
    return EndUser(
      fullName: map["fullName"] ??
          '', // Default to an empty string if fullName is null.
      age: map["age"] ?? 0, // Default to 0 if age is null.
      email: map["email"] ?? "", // Default to an empty string if email is null.
    );
  }
}
