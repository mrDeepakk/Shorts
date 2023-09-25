import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String profilepic;
  String id;
  List likes;
  int comments;
  int share;
  String songname;
  String caption;
  String videourl;
  String thumbnail;
  Video({
    required this.username,
    required this.uid,
    required this.profilepic,
    required this.id,
    required this.likes,
    required this.comments,
    required this.share,
    required this.songname,
    required this.caption,
    required this.videourl,
    required this.thumbnail,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilepic": profilepic,
        "id": id,
        "likes": likes,
        "comments": comments,
        "share": share,
        "songname": songname,
        "caption": caption,
        "videourl": videourl,
        "thumbnail": thumbnail,
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot["username"],
      id: snapshot["id"],
      uid: snapshot["uid"],
      profilepic: snapshot["profilepic"],
      songname: snapshot["songname"],
      caption: snapshot["caption"],
      share: snapshot["share"],
      likes: snapshot["likes"],
      comments: snapshot["comments"],
      videourl: snapshot["videourl"],
      thumbnail: snapshot["thumbnail"],
    );
  }
}
