import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String firstName;
  final String lastName;
  final String occupation;
  final String description;
  final String profileImageURL;

  User(
      {this.firstName,
      this.lastName,
      this.description,
      this.occupation,
      this.profileImageURL});

  factory User.fromDocuments(DocumentSnapshot doc,) {
    return User(
        firstName: doc.data()['firstName'],
        lastName: doc.data()['LastName'],
        occupation: doc.data()['occupation'],
        description: doc.data()['description'],
        profileImageURL: doc.data()['profileImageURL']);
  }
}
