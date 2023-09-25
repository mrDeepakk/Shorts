import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compresVideo(String videopath) async {
    final finalvideo = await VideoCompress.compressVideo(videopath,
        quality: VideoQuality.MediumQuality);
    return finalvideo!.file;
  }

  _getThumbnail(String videopath) async {
    final finalThubnail = VideoCompress.getFileThumbnail(videopath);
    return finalThubnail;
  }

  Future<String> _uploadVideotoStroage(String id, String videopath) async {
    Reference ref = firebasestorage.ref().child("video").child(id);
    UploadTask uploadTask = ref.putFile(await _compresVideo(videopath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImagetoStorage(String id, String videopath) async {
    Reference ref = firebasestorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videopath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadVideo(
      String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseauth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();
      var allDoc = await firestore.collection("video").get();
      int len = allDoc.docs.length;

      String videourl = await _uploadVideotoStroage("video $len", videoPath);
      String videoThumbnail =
          await _uploadImagetoStorage("video $len,", videoPath);

      // getting username and profile pic from firebas
      String name = await (userDoc.data()! as Map<String, dynamic>)["username"];
      String profilepic =
          await (userDoc.data()! as Map<String, dynamic>)["profilepic"];
      // --------------------------------------------------------------------------

      Video _video = Video(
          username: name,
          uid: uid,
          share: 0,
          likes: [],
          songname: songName,
          id: "video $len",
          comments: 0,
          caption: caption,
          profilepic: profilepic,
          thumbnail: videoThumbnail,
          videourl: videourl);
      await firestore
          .collection("video")
          .doc("video $len")
          .set(_video.toJson());

      Get.back();
    } on FirebaseFirestore catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }
  }
}
