import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';
import 'package:shorts/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    _profileController.updateuserId(widget.uid);
    super.initState();
  }

  // _user.value = {
  //   "followers": followers.toString(),
  //   "followings": followings.toString(),
  //   "profilepic": profilepic,
  //   "likes": likes.toString(),
  //   "isFollowing": isFollowing,
  //   "name": name,
  //   "thumbnails": thumbnails,
  // };
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.user["name"].toString()),
              backgroundColor: Colors.black12,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(Icons.person_add_alt_1_outlined),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(Icons.settings),
                )
              ],
            ),
            body: Column(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: controller.user["profilepic"].toString(),
                          height: 120,
                          width: 120,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            controller.user["followings"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        color: Colors.black54,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Column(
                        children: [
                          Text(
                            controller.user["followers"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 15,
                        color: Colors.black54,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      Column(
                        children: [
                          Text(
                            controller.user["likes"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            "Likes",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 47,
                    width: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        if (widget.uid == authController.user.uid) {
                          authController.singout();
                        } else {
                          controller.followuser();
                        }
                      },
                      child: Text(
                        widget.uid == authController.user.uid
                            ? "Sing out"
                            : controller.user["isFollowing"]
                                ? "Unfollow"
                                : "Follow",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.user["thumbnails"].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  String thumbnail = controller.user['thumbnails'][index];
                  return CachedNetworkImage(
                    imageUrl: thumbnail,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ]),
          );
        });
  }
}
