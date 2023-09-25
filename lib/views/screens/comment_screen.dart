import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/constants.dart';

import 'package:shorts/controllers/comment_controller.dart';

// ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }

  final String id;
  CommentScreen({super.key, required this.id});
  CommentController commentController = Get.put(CommentController());
  final TextEditingController _commentcontroller = TextEditingController();
  void setDefaultLocale(String eng) {}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatepostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: commentController.comment.length,
                    itemBuilder: (context, index) {
                      final _comment = commentController.comment[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(_comment.profilepic),
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${_comment.username}  ",
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ),
                              Expanded(
                                child: Text(
                                  softWrap: true,
                                  // new
                                  _comment.Comment,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(children: [
                            Text(
                              convertToAgo(
                                  DateTime.parse(_comment.datepublish)),
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${_comment.likes.length} likes",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            ),
                          ]),
                          trailing: InkWell(
                            onTap: () =>
                                {commentController.likeComment(_comment.id)},
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: _comment.likes
                                      .contains(authController.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentcontroller,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Comment",
                  labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              trailing: TextButton(
                onPressed: () => {
                  commentController.postComment(_commentcontroller.text),
                  _commentcontroller.clear(),
                },
                child: Text(
                  "Send",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
