import 'package:flutter/material.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/controllers/video_controller.dart';
import 'package:shorts/views/screens/comment_screen.dart';
import 'package:shorts/views/screens/video_player_item.dart';
import 'package:shorts/views/widgets/circle_animation.dart';
import 'package:get/get.dart';

class VideoScreen extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());
  VideoScreen({super.key});
  buildProfile(String profile) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  profile,
                  fit: BoxFit.cover,
                )),
          ),
        )
      ]),
    );
  }

  buildMusicalbum(String profile) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Column(children: [
        Container(
          child: Image.network(
            profile,
            fit: BoxFit.cover,
          ),
          padding: EdgeInsets.all(8.2),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.grey, Colors.white]),
            borderRadius: BorderRadius.circular(25),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videolist.length,
          scrollDirection: Axis.vertical,
          controller: PageController(initialPage: 0, viewportFraction: 1.0),
          itemBuilder: (context, index) {
            final data = videoController.videolist[index];
            return Stack(
              children: [
                InkWell(
                  onDoubleTap: () => videoController.likevideo(data.id),
                  child: VideoPlayerItem(
                    videourl: data.videourl,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    data.username,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.caption,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.music_note,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songname,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.red,
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 2.6),
                            child: Column(children: [
                              buildProfile(data.profilepic),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        videoController.likevideo(data.id),
                                    child: Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: data.likes
                                              .contains(authController.user.uid)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () => Get.to(() => CommentScreen(
                                          id: data.id,
                                        )),
                                    child: Icon(
                                      Icons.comment,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    data.comments.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Icon(
                                      Icons.reply,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    data.share.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CircularAnimation(
                                    child: buildMusicalbum(data.profilepic),
                                  ),
                                ],
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
