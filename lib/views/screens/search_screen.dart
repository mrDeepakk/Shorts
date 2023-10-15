import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/search_controller.dart';
import 'package:shorts/models/user.dart';
import 'package:shorts/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final Searchcnt _searchController = Get.put(Searchcnt());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              onFieldSubmitted: (value) => _searchController.searchUser(value),
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white)),
            )),
        body: _searchController.searchedUser.isEmpty
            ? const Center(
                child: Text(
                "Search for User !",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
            : ListView.builder(
                itemCount: _searchController.searchedUser.length,
                itemBuilder: (context, index) {
                  User user = _searchController.searchedUser[index];
                  return InkWell(
                    onTap: () => Get.to(ProfileScreen(
                      uid: user.uid,
                    )),
                    child: ListTile(
                        title: Text(
                          user.username,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilepic),
                        )),
                  );
                },
              ),
      );
    });
  }
}
