import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videolist = Rx<List<Video>>([]);
  List<Video> get videolist => _videolist.value;
  @override
  void onInit() {
    // TODO: implement onInit
    _videolist.bindStream(
        firestore.collection("video").snapshots().map((QuerySnapshot element) {
      List<Video> retval = [];
      for (var ele in element.docs) {
        retval.add(Video.fromSnap(ele));
      }

      return retval;
    }));
    super.onInit();
  }

  likevideo(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore.collection("video").doc(id).get();

    if ((doc.data()! as dynamic)["likes"].contains(uid)) {
      await firestore.collection("video").doc(id).update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection("video").doc(id).update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }
}
