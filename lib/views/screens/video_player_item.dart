import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videourl;
  VideoPlayerItem({super.key, required this.videourl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(widget.videourl)
      ..initialize().then(
        (value) => {
          _videoPlayerController.play(),
          _videoPlayerController.setVolume(1),
          _videoPlayerController.setLooping(true)
        },
      );
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
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: Colors.black),
      child: VideoPlayer(
        _videoPlayerController,
      ),
    );
  }
}
