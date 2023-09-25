import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String username;
  String Comment;
  String datepublish;
  String profilepic;
  List likes;
  String id;
  String uid;

  Comments(
      {required this.username,
      required this.Comment,
      required this.profilepic,
      required this.likes,
      required this.id,
      required this.uid,
      required this.datepublish});
  Map<String, dynamic> toJson() => {
        "username": username,
        "Comment": Comment,
        "uid": uid,
        "id": id,
        "likes": likes,
        "datepublish": datepublish,
        "profilepic": profilepic,
      };
  static Comments fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comments(
      profilepic: snapshot["profilepic"],
      username: snapshot["username"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      Comment: snapshot["Comment"],
      likes: snapshot["likes"],
      datepublish: snapshot["datepublish"],
    );
  }
}
