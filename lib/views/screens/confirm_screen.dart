import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/upload_video_controller.dart';
import 'package:shorts/views/widgets/textinput_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videofile;
  final String videopath;

  ConfirmScreen({super.key, required this.videopath, required this.videofile});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  UploadVideoController _uploadVideoController =
      Get.put(UploadVideoController());
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _videoPlayerController = VideoPlayerController.file(widget.videofile);
    });
    _videoPlayerController.setVolume(1);
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(_videoPlayerController),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(
                        controller: _songController,
                        labeltext: 'Song name',
                        icon: Icons.music_note,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: TextInputField(
                        controller: _captionController,
                        labeltext: 'Caption',
                        icon: Icons.closed_caption,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _uploadVideoController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videopath),
                      child: const Text(
                        "Share!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
