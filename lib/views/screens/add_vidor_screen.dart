import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shorts/views/screens/confirm_screen.dart';
import 'package:shorts/views/screens/home.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({super.key});
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.to(() => ConfirmScreen(
            videofile: File(video.path),
            videopath: video.path,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SimpleDialog(
        children: [
          InkWell(
            onTap: () => pickVideo(ImageSource.gallery, context),
            child: const Padding(
              padding: EdgeInsets.only(left: 7, top: 7),
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    size: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      "Gallery",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          InkWell(
            onTap: () => pickVideo(ImageSource.camera, context),
            child: const Padding(
              padding: EdgeInsets.only(left: 7, top: 7),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      "Camera",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          InkWell(
            onTap: () => {Get.offAll(() => HomeScreen())},
            child: const Padding(
              padding: EdgeInsets.only(left: 7, top: 7),
              child: Row(
                children: [
                  Icon(
                    Icons.cancel,
                    size: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
