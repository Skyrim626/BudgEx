import 'package:budgex/model/budgets.dart';
import 'package:budgex/model/end_users.dart';
import 'package:budgex/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreService {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _firestoreDatabase = FirebaseFirestore.instance;

  // Collection References
  final String _usersCollectionName = "users";
  final String _budgetsCollectionName = "user_budgets";

  // An instance of the EndUser class to store the retrieved user data.
  late EndUser endUser;

  // Fetches both user profile and budget details for the current user.
  Future<EndUser> getCurrentUserData() async {
    // Reference to the 'users' collection in Firestore.
    CollectionReference usersReference =
        _firestoreDatabase.collection(_usersCollectionName);

    // Fetch all details of user data (Profile)
    endUser = await getUserProfileData(
        reference: usersReference,
        userEmail: _auth.getCurrentUser().email.toString());

    // Fetch all budget details of user data (Budgets)
    List<Budgets> usersBudgets = await getAllUserBudgets(
        userReference: usersReference,
        userEmail: _auth.getCurrentUser().email.toString());

    // Add all the budgets as object
    endUser.addAllBudget(budgets: usersBudgets);
    // You can call the method to fetch user budgets here

    return endUser;
  }

// Fetches all budget details for a specific user based on the provided CollectionReference and email.
  Future<List<Budgets>> getAllUserBudgets(
      {required CollectionReference userReference,
      required String userEmail}) async {
    // Perform a query to get the user with the specified email
    QuerySnapshot querySnapshot =
        await userReference.where('email', isEqualTo: userEmail).get();

    var userDocument = querySnapshot.docs.first;

    // Reference to the 'user_budgets' subcollection within the user document
    CollectionReference budgetsCollection =
        userDocument.reference.collection(_budgetsCollectionName);

    // Get documents from the 'user_budgets' subcollection
    QuerySnapshot budgetsSnapshot = await budgetsCollection.get();

    // Convert each budget document data into a Budgets object
    List<Budgets> userBudgets = budgetsSnapshot.docs
        .map((budgetDoc) =>
            Budgets.fromMap(budgetDoc.data() as Map<String, dynamic>))
        .toList();

    // Return the list of Budgets objects containing user's budget data
    return userBudgets;
  }

// Fetches user profile data based on the provided CollectionReference and email.
  Future<EndUser> getUserProfileData(
      {required CollectionReference reference,
      required String userEmail}) async {
    // Perform a query to get the user with the specified email
    QuerySnapshot querySnapshot =
        await reference.where('email', isEqualTo: userEmail).get();

    // Get the first document (assuming there is only one user with the specified email)
    var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

    // Convert the retrieved data into an EndUser object
    EndUser userProfile = EndUser.fromMap(userData);

    // Return the EndUser object containing user data
    return userProfile;
  }

  // Function to add a new user to Firestore
  Future<void> addUser({
    required String fullName, // Full name of the user
    required int age, // Age of the user
    required String email, // Email address of the user
  }) async {
    // Reference to the 'users' collection in Firestore.
    CollectionReference users = _firestoreDatabase.collection('users');

    // Specify the document ID (email) you want to use
    String documentId = email;

    // Gets the Current Date and Time base on Device Time
    DateTime dateTime = DateTime.now();

    // Formats the Date and Time
    String formattedDate =
        DateFormat('d MMMM y "at" HH:mm:ss "UTC"Z').format(dateTime);

    // Reference to the specific document using the custom ID
    DocumentReference documentReference = users.doc(documentId);

    // Data to be inserted to the collection
    Map<String, dynamic> data = {
      'fullName': fullName, // Storing user's full name in the document
      'age': age, // Storing user's age in the document
      'email': email, // Storing user's email in the document
      'dateRegistered': formattedDate, // Storing user's email in the document
    };

    // Add to the Firestore Collection 'users' with a specified ID and data
    await documentReference.set(data);

    print('Document with ID $documentId added to Firestore');
  }
}
