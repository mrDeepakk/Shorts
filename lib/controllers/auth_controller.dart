import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/models/user.dart' as model;
import 'package:shorts/views/screens/auth/login_screen.dart';
import 'package:shorts/views/screens/home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  //image pick
  late Rx<User?> _user;
  late Rx<File?> _pickedimage;
  File? get profilePic => _pickedimage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    // TODO: implement onReady
    _user = Rx<User?>(firebaseauth.currentUser);
    _user.bindStream(firebaseauth.authStateChanges());
    ever(_user, _setInitialScreen);
    super.onReady();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  void picImage() async {
    final pickedimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedimage != null) {
      Get.snackbar("Profile selected", "Successfull");
    }
    _pickedimage = Rx<File?>(File(pickedimage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadimage(File image) async {
    Reference reference = firebasestorage
        .ref()
        .child("profilePic")
        .child(firebaseauth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

  // register new user
  void registerUser(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseauth
            .createUserWithEmailAndPassword(email: email, password: password);
        String imgurl = await _uploadimage(image);
        model.User modelUser = model.User(
            email: email,
            password: password,
            username: userName,
            profilepic: imgurl,
            uid: userCredential.user!.uid);
        firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(modelUser.toJson());
      } else {
        throw ();
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error Occured", e.message.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseauth.signInWithEmailAndPassword(
            email: email, password: password);
        print("user loggin successful");
      } else {
        Get.snackbar("Enter the user name and password", "");
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error Occured", e.message.toString());
    }
  }

  void logoutUser() {
    try {
      firebaseauth.signOut();
    } on FirebaseException catch (e) {
      Get.snackbar("Error Occured", e.message.toString());
    }
  }
}
