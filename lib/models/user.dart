import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String profilepic;
  String uid;
  String password;
  User(
      {required this.username,
      required this.email,
      required this.profilepic,
      required this.uid,
      required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "profilepic": profilepic,
        "uid": uid,
      };
  static User fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot["email"],
      password: snapshot["password"],
      profilepic: snapshot["profilepic"],
      uid: snapshot["uid"],
      username: snapshot["username"],
    );
  }
}
