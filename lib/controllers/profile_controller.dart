import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;
  updateuserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myvideo = await firestore
        .collection("video")
        .where("uid", isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myvideo.docs.length; i++) {
      thumbnails.add((myvideo.docs[i].data() as dynamic)["thumbnail"]);
    }
    DocumentSnapshot userDocs =
        await firestore.collection("users").doc(_uid.value).get();
    final userData = userDocs.data()! as dynamic;
    String name = userData["username"];
    String profilepic = userData["profilepic"];
    int likes = 0;
    int followings = 0;
    int followers = 0;
    bool isFollowing = false;
    for (var item in myvideo.docs) {
      likes += (item.data()["likes"] as List).length;
    }
    var followerDocs = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .get();
    var followingDocs = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followings")
        .get();
    followers = followerDocs.docs.length;
    followings = followingDocs.docs.length;
    await firestore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(authController.user.uid)
        .get()
        .then(
      (value) {
        if (value.exists)
          isFollowing = true;
        else
          isFollowing = false;
      },
    );
    _user.value = {
      "followers": followers.toString(),
      "followings": followings.toString(),
      "profilepic": profilepic,
      "likes": likes.toString(),
      "isFollowing": isFollowing,
      "name": name,
      "thumbnails": thumbnails,
    };
    update();
  }

  followuser() async {
    var doc = await firestore
        .collection("users")
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection("users")
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection("users")
          .doc(authController.user.uid)
          .collection('followings')
          .doc(_uid.value)
          .set({});
      _user.value
          .update("followers", (value) => (int.parse(value) + 1).toString());
    } else {
      await firestore
          .collection("users")
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection("users")
          .doc(authController.user.uid)
          .collection('followings')
          .doc(_uid.value)
          .delete();
      _user.value
          .update("followers", (value) => (int.parse(value) - 1).toString());
    }
    _user..value.update("isFollowing", (value) => !value);
    update();
  }
}
