import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/models/comment.dart';

class CommentController extends GetxController {
  RxBool textWrap = false.obs;
  void updatetextWrap() {
    textWrap.toggle();
  }

  final Rx<List<Comments>> _comment = Rx<List<Comments>>([]);
  List<Comments> get comment => _comment.value;
  String _postid = "";

  updatepostId(String id) {
    _postid = id;
    getcomment();
  }

  getcomment() async {
    _comment.bindStream(firestore
        .collection("video")
        .doc(_postid)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comments> listval = [];
      for (var element in query.docs) {
        listval.add(Comments.fromSnap(element));
      }
      return listval;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userdoc = await firestore
            .collection("users")
            .doc(authController.user.uid)
            .get();
        var alldoc = await firestore
            .collection("video")
            .doc(_postid)
            .collection("comments")
            .get();

        int len = alldoc.docs.length;
        Comments comments = Comments(
          Comment: commentText,
          username: (userdoc.data()! as dynamic)["username"],
          datepublish: DateTime.now().toString(),
          id: "comment $len",
          uid: authController.user.uid,
          likes: [],
          profilepic: (userdoc.data()! as dynamic)["profilepic"],
        );
        await firestore
            .collection("video")
            .doc(_postid)
            .collection("comments")
            .doc("comment $len")
            .set(comments.toJson());
        DocumentSnapshot doc =
            await firestore.collection("video").doc(_postid).get();
        await firestore.collection("video").doc(_postid).update({
          "comments": (doc.data()! as dynamic)["comments"] + 1,
        });
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error occured: ", e.message.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection("video")
        .doc(_postid)
        .collection("comments")
        .doc(id)
        .get();
    // (doc.data()! as dynamic)["likes"].contains(uid);
    if ((doc.data()! as dynamic)["likes"].contains(uid)) {
      await firestore
          .collection("video")
          .doc(_postid)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore
          .collection("video")
          .doc(_postid)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }
}
